/* A simple class that draws a ball of radius "radius" */
class Ball {
  final float radius;
  
  Ball(float radius) {
    this.radius = radius;
  }
  
  float getRadius() {
    return radius;
  }
  
  void display() {
    noStroke();
    fill(255, 0, 7);
    sphere(radius);
  }
}
