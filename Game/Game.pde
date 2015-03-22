final int BOARDWIDTH = 400;
final int BOARDLENGTH = 400;
final int BOARDHEIGHT = 20;

final float ROTY_COEFF = PI/64;
final float DEFAULT_TILT_COEFF = 0.01;
final float MAX_TILT_COEFF = 1.5*DEFAULT_TILT_COEFF;
final float MIN_TILT_COEFF = 0.2*DEFAULT_TILT_COEFF;
final float TILT_MAX = PI/3;

float tilt_coeff = DEFAULT_TILT_COEFF;

float rotation = 0.0;
float tiltX = 0.0;
float tiltZ = 0.0;

Mover sphere;

boolean showAxis = true;
boolean drawOrigin = false;
float longueurAxes = 1000;

void setup() {
  size(500, 500, P3D);
  noStroke();
  sphere = new Mover(0,0, BOARDLENGTH, BOARDHEIGHT, BOARDWIDTH);
}

void draw() {
  pushMatrix();
  if(drawOrigin) {
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
  popMatrix();
  
  camera(width/2, height/2, 1000, width/2, height/2, 0, 0, 1, 0);
  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(102, 102, 102);
  background(200);

  pushMatrix();
  translate(width/2, height/2, 0);

  rotateX(tiltX);
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
  
  stroke(30);
  fill(255);
  box(BOARDLENGTH, BOARDHEIGHT, BOARDWIDTH);
  sphere.update(tiltX, tiltZ);
  sphere.display();
  popMatrix();
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == LEFT) {
      rotation += ROTY_COEFF;
    }
    else if(keyCode == RIGHT) {
      rotation -= ROTY_COEFF;
    }
  }
}

void mouseDragged() {
  float tiltXIncrement = -tilt_coeff*(mouseY - pmouseY);
  float tiltZIncrement = tilt_coeff*(mouseX - pmouseX);
  
  if(abs(tiltX + tiltXIncrement) < TILT_MAX)
    tiltX += tiltXIncrement;
  if(abs(tiltZ + tiltZIncrement) < TILT_MAX)
    tiltZ += tiltZIncrement;
}

void mouseWheel(MouseEvent event) {
  float newTilt = tilt_coeff + event.getCount()*0.1*DEFAULT_TILT_COEFF;
  
  if(newTilt > MIN_TILT_COEFF && newTilt < MAX_TILT_COEFF)
    tilt_coeff = newTilt;
}
