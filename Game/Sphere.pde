class Sphere {  
  
  PVector location;
  PVector velocity;
  PVector gravityForce;
  float gravityConstant;
  
  Sphere() {
    location = new PVector(0, 0,0);
    velocity = new PVector(0, 0, 0);
    gravityForce = new PVector(0,0,0);
    gravityConstant = 0.0981;       
  }
  void update(float rotX, float rotZ) {
    gravityForce.x = sin(rotZ) * gravityConstant;
    gravityForce.z = sin(-rotX) * gravityConstant;
    gravityForce.y = 0;
    float normalForce = 1;
    float mu = 0.01;
    float frictionMagnitude = normalForce * mu;
    PVector friction = velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(frictionMagnitude);
    
    velocity.add(gravityForce);
    velocity.add(friction);
    location.add(velocity);
    //velocity.add(gravity);
    //location.add(velocity);
    
  }
  void display() {
    pushMatrix();
    translate(location.x,location.y-40,location.z);  
    fill(255);
    sphere(30);
    popMatrix();
  }
  
  void checkEdges() {
    if(location.x > BOARDWIDTH/2){
      velocity.x *= -0.8;
      location.x = BOARDWIDTH/2;
    }
    else if(location.x < -BOARDWIDTH/2){
      velocity.x *= -0.8;
      location.x = -BOARDWIDTH/2;
    }
    if(location.z > BOARDLENGTH/2){
      velocity.z *= -0.8;
      location.z = BOARDLENGTH/2;
    }
    else if(location.z < -BOARDLENGTH/2){
      velocity.z *= -0.8;
      location.z = -BOARDLENGTH/2;
    }
  }
}
