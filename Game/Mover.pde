class Mover {
  final float gravityConstant = 0.2;
  
  PVector location;
  PVector velocity;
  PVector gravity;
  
  float board_length;
  float board_height;
  float board_width;
  
  Ball ball;
  Board board;
  ArrayList<Cylinder> cylinders;
  ArrayList<PVector> cylinderPositions;
  
  Cylinder tempCylinder = new Cylinder();
  
  boolean addingCylinderMode = false;
  
  Mover(float ball_radius, float board_length, float board_height, float board_width) {
    location = new PVector(0, 0, 0);
    velocity = new PVector(0, 0, 0);
    gravity = new PVector(0,0,0);
    
    this.board_length = board_length;
    this.board_height = board_height;
    this.board_width = board_width;
    
    ball = new Ball(ball_radius);
    board = new Board(board_width, board_height, board_length);
    
    cylinders = new ArrayList<Cylinder>();
    cylinderPositions = new ArrayList<PVector>();
  }
  
  void setAddingCylinderMode(boolean b) {
    addingCylinderMode = b;
  }
  
  void update(float rotX, float rotZ) {
    if(!addingCylinderMode) {
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
  }
  
  void placeCylinder(float x, float z) {
    if(addingCylinderMode) {  
      // Display board first 
      display();
       
      pushMatrix();
      translate(x, -board_height/2, z);
      tempCylinder.display();
      popMatrix();
    }
  }
  
  void display() {
    board.display();
    
    // Place all cylinders
    for(int i = 0; i < cylinders.size(); i++) {
      PVector position = cylinderPositions.get(i);
      Cylinder c = cylinders.get(i);
      
      pushMatrix();
      translate(position.x, -board_height/2, position.z);
      c.display();
      popMatrix();
    }
    
    // Draw the ball only if we are not in adding cylinder mode
    if(!addingCylinderMode) {
      translate(location.x, -board_height/2-ball.getRadius(), location.z);
      ball.display();
    }
  }
  
  void checkEdges() {
    float ballRadius = ball.getRadius();
    if(location.x > board_width/2-ballRadius) {
      velocity.x *= -1;
    }
    else if(location.x < -board_width/2+ballRadius) {
      velocity.x *= -1;
    }
    if(location.z > board_length/2-ballRadius) {
      velocity.z *= -1;
    }
    else if(location.z < -board_length/2+ballRadius) {
      velocity.z *= -1;
    }  
  }
  
  void checkCylinders() {
    
  }
  
  void addCylinder(float x, float z) {
    if(addingCylinderMode) {
      cylinders.add(new Cylinder());
      cylinderPositions.add(new PVector(x, 0, z));
    }
  }
}
