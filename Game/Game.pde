final int BOARDWIDTH = 400;
final int BOARDLENGTH = 400;
final int BOARDHEIGHT = 20;

final float ROTY_COEFF = PI/64;
final float DEFAULT_TILT_COEFF = 0.01;
final float MAX_TILT_COEFF = 1.5*DEFAULT_TILT_COEFF;
final float MIN_TILT_COEFF = 0.2*DEFAULT_TILT_COEFF;
final float TILT_MAX = PI/3;
final float UP_TILT = -PI/6;

final float BALL_RADIUS = 25;

float tilt_coeff = DEFAULT_TILT_COEFF;

float rotation = 0.0;
float tiltX = 0.0;
float tiltZ = 0.0;
float tiltXBackup = 0.0;
float tiltZBackup = 0.0;
float rotationBackup = 0.0;

Mover mover;

boolean showAxis = false;
boolean drawOrigin = false;
float longueurAxes = 1000;

boolean addingCylinderMode = false;

void setup() {
  size(500, 500, P3D);
  noStroke();
  mover = new Mover(BALL_RADIUS, BOARDLENGTH, BOARDHEIGHT, BOARDWIDTH);
}

void draw() {
  background(200);
  directionalLight(255, 255, 255, 0, 1, -1);
  ambientLight(102, 102, 102);
  if(addingCylinderMode)
    camera(width/2, height/2, 400, width/2, height/2, 0, 0, 1, 0);
  else
    camera(width/2, height/2, 600, width/2, height/2, 0, 0, 1, 0);

  translate(width/2, height/2, 0);
  if(!addingCylinderMode) rotateX(tiltX + UP_TILT);
  else rotateX(tiltX);
  rotateZ(tiltZ);
  rotateY(rotation);
  
  if(showAxis) {
    //Axe X
    stroke(0, 255, 0);
    line(-longueurAxes/2, 0, 0, longueurAxes/2, 0, 0);
    //Axe Y
    stroke(255, 0, 0);
    line(0, -longueurAxes/2, 0, 0, longueurAxes/2, 0);
    //Axe Z
    stroke(0,0,255);
    line(0, 0, -longueurAxes/2, 0, 0, longueurAxes/2);
  }
  
  //If we are in adding cylinder mode, place a cylinder
  if(addingCylinderMode) {  
    mover.placeCylinder(map(mouseX, 0, width, -BOARDLENGTH/2, BOARDLENGTH/2), map(mouseY, 0, height, -BOARDWIDTH/2, BOARDWIDTH/2));
  }
  else {
    // Draw board here
    mover.update(tiltX, tiltZ);
    mover.display();
  }
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == SHIFT && !addingCylinderMode) {
      addingCylinderMode = true;
      mover.setAddingCylinderMode(true);
      tiltXBackup = tiltX;
      tiltZBackup = tiltZ;
      rotationBackup = rotation;
      rotation = 0;
      
      tiltX = -PI/2;
      tiltZ = 0;
    }
    if(!addingCylinderMode) {
      if(keyCode == LEFT) {
        rotation += ROTY_COEFF;
      }
      else if(keyCode == RIGHT) {
        rotation -= ROTY_COEFF;
      }
    }
  }
}

void keyReleased() {
 if(key == CODED) {
   if(keyCode == SHIFT) {
      addingCylinderMode = false;
      mover.setAddingCylinderMode(false);
      tiltX = tiltXBackup;
      tiltZ = tiltZBackup;
      rotation = rotationBackup;
   }
 }
}

void mouseDragged() {
  if(!addingCylinderMode) {
    float tiltXIncrement = -tilt_coeff*(mouseY - pmouseY);
    float tiltZIncrement = tilt_coeff*(mouseX - pmouseX);
    
    if(abs(tiltX + tiltXIncrement) < TILT_MAX)
      tiltX += tiltXIncrement;
    if(abs(tiltZ + tiltZIncrement) < TILT_MAX)
      tiltZ += tiltZIncrement;
  }
}

void mousePressed() {
  mover.addCylinder(map(mouseX, 0, width, -BOARDLENGTH/2, BOARDLENGTH/2), map(mouseY, 0, height, -BOARDWIDTH/2, BOARDWIDTH/2));
}

void mouseWheel(MouseEvent event) {
  float newTilt = tilt_coeff + -event.getCount()*0.1*DEFAULT_TILT_COEFF;
  
  if(newTilt > MIN_TILT_COEFF && newTilt < MAX_TILT_COEFF)
    tilt_coeff = newTilt;
}
