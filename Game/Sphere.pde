class Sphere {  
  
  PVector location;
  PVector velocity;
  PVector gravityForce;
  float gravityConstant;
  int radius = 30;
  float elasticity;
  
  Sphere() {
    location = new PVector(0, 0,0);
    velocity = new PVector(0, 0, 0);
    gravityForce = new PVector(0,0,0);
    gravityConstant = 0.2;
    radius = 30;
    elasticity = 0.8;
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
    sphere(radius);
    popMatrix();
  }
  
  void checkEdges() {
    if(location.x > BOARDWIDTH/2 - radius){
      velocity.x *= -elasticity;
      location.x = BOARDWIDTH/2 - radius;
    }
    else if(location.x < -BOARDWIDTH/2 + radius){
      velocity.x *= -elasticity;
      location.x = -BOARDWIDTH/2 + radius;
    }
    if(location.z > BOARDLENGTH/2 - radius){
      velocity.z *= -elasticity;
      location.z = BOARDLENGTH/2 - radius;
    }
    else if(location.z < -BOARDLENGTH/2 + radius){
      velocity.z *= -elasticity;
      location.z = -BOARDLENGTH/2 + radius;
    }
  }
  
  void checkCylinderCollision(PVector loc, Cylinder c){
    if( pow((location.x - loc.x), 2) +  pow((location.z - loc.y), 2) <= pow(c.radius + radius, 2) ) {
       PVector newVelocity = new PVector(0, 0, 0);
       PVector normal = normal(loc, location);
       normal.mult(2* normal.dot(velocity));
       
       newVelocity.add(velocity);
       newVelocity.sub(normal);
       
       velocity.x = newVelocity.x * elasticity;
       velocity.z = newVelocity.z * elasticity;
       
       normal.normalize();
       normal.mult(c.radius + radius);
       location.x = loc.x - normal.x;
       location.z = loc.y - normal.z;
    }
  }
  
  PVector normal(PVector o, PVector p){
    PVector n = new PVector();
    n.x = p.x - o.x;
    n.z = p.z - o.y;
    n.normalize();
    return n;
  }
  
}
