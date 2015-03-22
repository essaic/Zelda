class Mover {
  final int BOARDWIDTH = 400;
  final int BOARDLENGTH = 400;
  final int BOARDHEIGHT = 20;
  
  PVector location;
  PVector velocity;
  PVector gravity;
  
  float boardEdgeX;
  float boardEdgeY;
  float boardEdgeZ;
  
  final int RADIUS = 25;
  final float gravityConstant = 0.2;
  
  Ball ball;
  Board board;
  ArrayList<Cylinder> cylinders;
  
  Mover(float initX, float initZ, float boardEdgeX, float boardEdgeY, float boardEdgeZ) {
    location = new PVector(initX, 0, initZ);
    velocity = new PVector(0, 0, 0);
    gravity = new PVector(0,0,0);
    
    this.boardEdgeX = boardEdgeX;
    this.boardEdgeY = boardEdgeY;
    this.boardEdgeZ = boardEdgeZ;
    
    ball = new Ball(RADIUS);
    board = new Board(BOARDLENGTH, BOARDHEIGHT, BOARDWIDTH);
  }
  
  void update(float rotX, float rotZ) {
    gravity.x = sin(rotZ) * gravityConstant;
    gravity.z = -sin(rotX) * gravityConstant;
    
    float normalForce = 1;
    float mu = 0.02;
    float frictionMagnitude = normalForce * mu;
    PVector friction = velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(frictionMagnitude);
    
    velocity.add(gravity);
    velocity.add(friction);
    
    checkEdges();
    location.add(velocity);
  }
  
  void display() {
    board.display();
    pushMatrix();
    translate(location.x, -boardEdgeY/2-RADIUS, location.z);
    ball.display();
   
    
    /*translate(location.x, -boardEdgeY/2-RADIUS, location.z);
    stroke(0);
    strokeWeight(1);
    fill(255);*/
    
    popMatrix();
  }
  
  void checkEdges() {
    if(location.x > boardEdgeX/2-RADIUS) {
      velocity.x *= -1;
    }
    else if(location.x < -boardEdgeX/2+RADIUS) {
      velocity.x *= -1;
    }
    if(location.z > boardEdgeZ/2-RADIUS) {
      velocity.z *= -1;
    }
    else if(location.z < -boardEdgeZ/2+RADIUS) {
      velocity.z *= -1;
    }  
  }
  
  void checkCylinders() {
    
  }
  
  void addCylinder(Cylinder cylinder) {
    
  }
}