import processing.opengl.*;

void setup() {
  
  size(600,400,P3D);
  background(-1);
}

void draw() {
  drawCylinder(20, 70, 200);
}


void drawCylinder(int sides, float r, float h)
{
  float angle = 360 / sides;
  float halfHeight = h / 2;
  // draw top shape
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x + 100, y + 100, -halfHeight );
  }
  endShape(CLOSE);
  // draw bottom shape
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x + 100, y + 100, halfHeight );
  }
  endShape(CLOSE);

  // draw body
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x + 100, y + 100, halfHeight);
    vertex( x + 100, y + 100, -halfHeight);
  }
  endShape(CLOSE);
} 

