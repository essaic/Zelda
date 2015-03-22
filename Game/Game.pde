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

final Sphere sphere = new Sphere();
final Cylinder cylinder = new Cylinder();
final ArrayList<PVector> cylinders = new ArrayList<PVector>();
boolean shiftMode;

void setup() {
  size(500, 500, P3D);  
  cylinder.setup();
  noStroke();
}

void draw() {
  if(shiftMode) {
    drawShiftMode();
  }
  else {
    drawGame();
  }
}

void drawGame(){
  camera(width/2, height/2, 1000, width/2, height/2, 0, 0, 1, 0);
  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(102, 102, 102);
  background(200);
  
  pushMatrix();
  translate(width/2, height/2, 0);

  rotateX(tiltX);
  rotateZ(tiltZ);
  rotateY(rotation);
  box(BOARDLENGTH, BOARDHEIGHT, BOARDWIDTH);

  for(int i = 0; i < cylinders.size(); i++){
    pushMatrix();
    PVector loc = cylinders.get(i);
    translate(loc.x, 0, loc.y);
    rotateX(PI/2);
    cylinder.display();
    popMatrix();
  }

  sphere.update(tiltX, tiltZ);
  sphere.checkEdges();
  sphere.display();
  popMatrix();
}

void drawShiftMode(){
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  //camera(width/2, height/2, 1000, width/2, height/2, 0, 0, 1, 0);
  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(102, 102, 102);
  background(200);

  pushMatrix();
  translate(mouseX, mouseY, 0);
  cylinder.display();
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2, 0);
  
  rotateX(-PI/2);
  box(BOARDLENGTH, BOARDHEIGHT, BOARDWIDTH);
  sphere.display();
 
  for(int i = 0; i < cylinders.size(); i++){
    pushMatrix();
    PVector loc = cylinders.get(i);
    translate(loc.x, 0, loc.y);
        rotateX(PI/2);
    cylinder.display();
    popMatrix();
  }

  
  popMatrix();
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == SHIFT) {
      shiftMode = true;
    }
    else if(keyCode == LEFT) {
      rotation += ROTY_COEFF;
    }
    else if(keyCode == RIGHT) {
      rotation -= ROTY_COEFF;
    }
  }
}

void keyReleased(){
  if(keyCode == SHIFT){
    shiftMode = false;
  }
}

void mouseClicked(){
  if(shiftMode){
    cylinders.add(new PVector(mouseX - width/2, mouseY - height/2));
  }
}

void mouseDragged() {
  if(!shiftMode){
    float tiltXIncrement = -tilt_coeff*(mouseY - pmouseY);
    float tiltZIncrement = tilt_coeff*(mouseX - pmouseX);
    
    if(abs(tiltX + tiltXIncrement) < TILT_MAX)
      tiltX += tiltXIncrement;
    if(abs(tiltZ + tiltZIncrement) < TILT_MAX)
      tiltZ += tiltZIncrement;
  }
}

void mouseWheel(MouseEvent event) {
  if(!shiftMode){
    float newTilt = tilt_coeff + event.getCount()*0.1*DEFAULT_TILT_COEFF;
    
    if(newTilt > MIN_TILT_COEFF && newTilt < MAX_TILT_COEFF)
      tilt_coeff = newTilt;
  }
}
