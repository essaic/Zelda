float angleX = PI/8;
float angleY = 0;
float scale = 1;

void setup() {
  size(1000, 1000, P2D);
}

void draw() {
  background(255, 255, 255);
  My3DPoint eye = new My3DPoint(0, 0, -5000);
  My3DPoint origin = new My3DPoint(-75, -75, -75);
  My3DBox input3DBox = new My3DBox(origin, 150, 150, 150);
  //scaled
  float[][] transform3 = scaleMatrix(scale, scale, scale);
  input3DBox = transformBox(input3DBox, transform3);
  //scaled and rotated
  float[][] transform1 = rotateXMatrix(angleX);
  input3DBox = transformBox(input3DBox, transform1);
  float[][] transform4 = rotateYMatrix(angleY);
  input3DBox = transformBox(input3DBox, transform4);
  //rotated and translated and scaled
  float[][] transform2 = translationMatrix(500, 500, 0);
  input3DBox = transformBox(input3DBox, transform2);
  projectBox(eye, input3DBox).render();
}

void mouseDragged() {
  scale += (0.01) * (mouseY - pmouseY);
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == UP) {
      angleX -= PI/64;
    }
    else if(keyCode == DOWN) {
      angleX += PI/64;
    }
    else if(keyCode == LEFT) {
      angleY -= PI/64;
    }
    else if(keyCode == RIGHT) {
      angleY += PI/64;
    }
  }
}
class My2DPoint {
  float x;
  float y;
  My2DPoint(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class My3DPoint {
  float x;
  float y;
  float z;
  My3DPoint(float x , float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

class My2DBox {
  My2DPoint[] s;
  My2DBox(My2DPoint[] s) {
    this.s = s;
  }
  
  void render() {
    strokeWeight(3);
    
    stroke(0,255,0);
    line(s[4].x, s[4].y, s[7].x, s[7].y);
    line(s[4].x, s[4].y, s[5].x, s[5].y);
    line(s[6].x, s[6].y, s[7].x, s[7].y);
    line(s[6].x, s[6].y, s[5].x, s[5].y);
    
    stroke(0,0,255);
    
    line(s[4].x, s[4].y, s[0].x, s[0].y);
    line(s[7].x, s[7].y, s[3].x, s[3].y);
    line(s[6].x, s[6].y, s[2].x, s[2].y);
    line(s[5].x, s[5].y, s[1].x, s[1].y);

    stroke(255, 0 ,0);
    line(s[0].x, s[0].y, s[3].x, s[3].y);
    line(s[2].x, s[2].y, s[3].x, s[3].y);
    line(s[1].x, s[1].y, s[2].x, s[2].y);
    line(s[0].x, s[0].y, s[1].x, s[1].y);
    
    strokeWeight(1);
  }
}

class My3DBox {
  My3DPoint[] p;
  My3DBox(My3DPoint origin, float dimX, float dimY, float dimZ) {
    float x = origin.x;
    float y = origin.y;
    float z = origin.z;
    this.p = new My3DPoint[]{new My3DPoint(x,y+dimY,z+dimZ),
                              new My3DPoint(x,y,z+dimZ),
                              new My3DPoint(x+dimX,y,z+dimZ),
                              new My3DPoint(x+dimX,y+dimY,z+dimZ),
                              new My3DPoint(x,y+dimY,z),
                              origin,
                              new My3DPoint(x+dimX,y,z),
                              new My3DPoint(x+dimX,y+dimY,z)
                              };
  }
  My3DBox(My3DPoint[] p) {
    this.p = p;
  }
}

My2DBox projectBox(My3DPoint eye, My3DBox box) {
  My2DPoint[] s = new My2DPoint[box.p.length];
  
  for(int i = 0; i < box.p.length; i++) {
    s[i] = projectPoint(eye, box.p[i]);
  }
  
  return new My2DBox(s);
}

My2DPoint projectPoint(My3DPoint eye, My3DPoint p) {
  return new My2DPoint((p.x - eye.x)/(-p.z/eye.z + 1), (p.y - eye.y)/((-p.z/eye.z + 1)));
}

float[] homogeneous3DPoint(My3DPoint p) {
  float[] result = {p.x, p.y, p.z, 1};
  return result;
}

float[][] rotateXMatrix(float angle) {
  return(new float[][] {{1,0,0,0},
                        {0, cos(angle), sin(angle), 0},
                        {0, -sin(angle), cos(angle), 0},
                        {0,0,0,1}});
}

float[][] rotateYMatrix(float angle) {
  return(new float[][] {{cos(angle), 0, sin(angle), 0},
                        {0, 1, 0, 0},
                        {-sin(angle), 0, cos(angle), 0},
                        {0, 0, 0, 1}});
}

float[][] rotateZMatrix(float angle) {
  return(new float[][] {{cos(angle), -sin(angle), 0, 0},
                        {sin(angle), cos(angle), 0, 0},
                        {0, 0, 1, 0},
                        {0, 0, 0, 1}});
}

float[][] scaleMatrix(float x, float y, float z) {
  return(new float[][] {{x, 0, 0, 0},
                        {0, y, 0, 0},
                        {0, 0, z, 0},
                        {0, 0, 0, 1}});
}

float[][] translationMatrix(float x, float y, float z) {
  return(new float[][] {{1, 0, 0, x},
                        {0, 1, 0, y},
                        {0, 0, 1, z},
                        {0, 0, 0, 1}});
}

float[] matrixProduct(float[][] a, float[] b) {
  float[] result = new float[b.length];
  
  for(int i = 0; i < a.length; i++) { // hauteur de la matrice
     for(int j = 0; j < b.length; j++) {
       result[i] += a[i][j] * b[j];
     }
  }
  
  return result;
}

My3DBox transformBox(My3DBox box, float[][] transformMatrix) {
  My3DPoint[] s = new My3DPoint[box.p.length];
  
  for(int i = 0; i < box.p.length; i++) {
    s[i] = euclidian3DPoint(matrixProduct(transformMatrix, homogeneous3DPoint(box.p[i])));
  }
  
  return new My3DBox(s);
}

My3DPoint euclidian3DPoint(float[] a) {
  My3DPoint result = new My3DPoint(a[0]/a[3], a[1]/a[3], a[2]/a[3]);
  return result;
}
