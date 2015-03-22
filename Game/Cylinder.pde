class Cylinder {

  float cylinderBaseSize = 50;
  float cylinderHeight = 50;
  int cylinderResolution = 40;
  PShape cylinderShape = new PShape();


  Cylinder() {
  
  }

  void setup(){
      float angle;
    float[] x = new float[cylinderResolution + 1];
    float[] y = new float[cylinderResolution + 1];
    //get the x and y position on a circle for all the sides
    for (int i = 0; i < x.length; i++) {
      angle = (TWO_PI / cylinderResolution) * i;
      x[i] = sin(angle) * cylinderBaseSize;
      y[i] = cos(angle) * cylinderBaseSize;
    }

    PShape openCylinder = new PShape();
    openCylinder = createShape();
    openCylinder.beginShape(QUAD_STRIP);

    PShape topCylinder = new PShape();
    topCylinder = createShape();
    topCylinder.beginShape(TRIANGLE_FAN);
    topCylinder.vertex(0, 0, cylinderHeight);

    PShape botCylinder = new PShape();
    botCylinder = createShape();
    botCylinder.beginShape(TRIANGLE_FAN);
    botCylinder.vertex(0, 0, 0);

    for (int i = 0; i < x.length; i++) {
      openCylinder.vertex(x[i], y[i], 0);
      openCylinder.vertex(x[i], y[i], cylinderHeight);
      topCylinder.vertex(x[i], y[i], cylinderHeight);
      botCylinder.vertex(x[i], y[i], 0);
    }
    openCylinder.endShape();
    topCylinder.endShape();
    botCylinder.endShape(); 

    cylinderShape = createShape(GROUP);
    cylinderShape.addChild(openCylinder);
    cylinderShape.addChild(topCylinder);
    cylinderShape.addChild(botCylinder);
  }
  
  void display() {
    shape(cylinderShape);
  }
}

