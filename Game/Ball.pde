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
    fill(255);
    sphere(radius);
  }
}
