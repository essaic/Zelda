class Cylinder {
  float cylinderBaseSize = 25;
  float cylinderHeight = -50;
  int cylinderResolution = 40;
  
  PShape openCylinder = new PShape();
  PShape topCylinder = new PShape();
  PShape bottomCylinder = new PShape();
  
  Cylinder() {
    float angle;
    float[] x = new float[cylinderResolution + 1];
    float[] z = new float[cylinderResolution + 1];
    
    //get the x and y position on a circle for all the sides
    for(int i = 0; i < x.length; i++) {
      angle = (TWO_PI / cylinderResolution) * i;
      x[i] = sin(angle) * cylinderBaseSize;
      z[i] = cos(angle) * cylinderBaseSize;
    }
    
    openCylinder = createShape();
    openCylinder.beginShape(QUAD_STRIP);
    //draw the border of the cylinder
    for(int i = 0; i < x.length; i++) {
      openCylinder.vertex(x[i], 0 , z[i]);
      openCylinder.vertex(x[i], cylinderHeight, z[i]);
    }
    openCylinder.endShape();
    
    bottomCylinder = createShape();
    bottomCylinder.beginShape(TRIANGLE_FAN);
    //draw the bottom of the cylinder
    bottomCylinder.vertex(0, 0, 0);
    for(int i = 0; i < x.length; i++) {
      bottomCylinder.vertex(x[i], 0, z[i]);
    }
    bottomCylinder.endShape();
    
    topCylinder = createShape();
    topCylinder.beginShape(TRIANGLE_FAN);
    //draw the top of the cylinder
    topCylinder.vertex(0,cylinderHeight,0);
    for(int i = 0; i < x.length; i++) {
      topCylinder.vertex(x[i], cylinderHeight, z[i]);
    }
    topCylinder.endShape();
  }
  
  void display() {
    stroke(0);
    strokeWeight(1);
    shape(openCylinder);
    shape(topCylinder);
    shape(bottomCylinder);
  }
}
