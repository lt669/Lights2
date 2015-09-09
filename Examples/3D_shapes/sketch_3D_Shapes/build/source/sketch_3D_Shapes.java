import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_3D_Shapes extends PApplet {



int numberOfSides = 4;
int starterX = 400;
int starterY = 300;
int hue;
int sat;
int bri;


int r;

public void setup() {
  
  size(600,400,P3D);
  background(-1);
}

public void draw() {
 // background(-1);
  numberOfSides += 1;
  if(numberOfSides >= 100){
    numberOfSides = 4;
  }
  hue += 1;
  if(hue >= 360){
    hue = 0;
  }
  sat += 1;
  if(sat >= 100){
    sat = 0;
  }
  bri = 100;

starterX += 1;
if(starterX >= 600){
  starterX = 0;
}

  r -= 1;
  if(r <= 0){
    r = 100;
  }

  drawCylinder(numberOfSides, r, 200);
}


public void drawCylinder(int sides, float r, float h)
{
  float angle = 360 / sides;
  float halfHeight = h / 2;
  // draw top shape
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x + starterX, y + starterY, -halfHeight );
  }
  endShape(CLOSE);
  // draw bottom shape
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x + starterX, y + starterY, halfHeight );
  }
  endShape(CLOSE);

  // draw body
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    colorMode(HSB,360,100,100);
    fill(hue,sat,bri);
    vertex( x + starterX, y + starterY, halfHeight);
    vertex( x + starterX, y + starterY, -halfHeight);
  }
  endShape(CLOSE);
} 

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_3D_Shapes" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
