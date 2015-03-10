final int BOARDWIDTH = 400;
final int BOARDLENGTH = 400;
final int BOARDHEIGHT = 20;

final float ROTY_COEFF = PI/64;
final float TILT_COEFF = 0.01;
final float TILT_MAX = PI/3;

float rotation = 0.0;
float tiltX = 0.0;
float tiltZ = 0.0;

void setup() {
  size(500, 500, P3D);
  noStroke();
}

void draw() {
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
  float tiltXIncrement = -TILT_COEFF*(mouseY - pmouseY);
  float tiltZIncrement = TILT_COEFF*(mouseX - pmouseX);
  
  if(abs(tiltX + tiltXIncrement) < TILT_MAX)
    tiltX += tiltXIncrement;
  if(abs(tiltZ + tiltZIncrement) < TILT_MAX)
    tiltZ += tiltZIncrement;
}
