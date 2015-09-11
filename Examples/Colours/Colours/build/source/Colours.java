import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Colours extends PApplet {

int canX = 600;
int canY = 400;
//color col;
public void setup() {

  size(canX, canY);
  background(-1);
}

public void draw() {

  // drawRec(canX/4,canY/4, 50, color(194,59,34));
  // drawRec(canX/4,canY*3/4, 50, color(255,179,71));
  // drawRec(canX*3/4,canY/4, 50, color(174,198,207));
  // drawRec(canX*3/4,canY*3/4, 50, color(119,158,203));


  //colorMode(RGB,255,255,255);
  //fill(30,144,255);
  //rect(0,0,200,200);
  //
  //
  colorMode(HSB,360,100,100);
  fill(210,50,50);
  rect(200,0,50,50);

  colorMode(HSB,360,360,360);
  fill(210,50,50);
  rect(150,0,50,50);

  colorMode(HSB,360);
  fill(210,50,50);
  rect(100,0,50,50);
  
  
  // fill(100);
  // beginShape();
  // curveVertex(canX/4, canY/4);
  // curveVertex(canX*3/4, canY/4);
  // curveVertex(canX*3/4, canY*3/4);
  // curveVertex(canX/4, canY*3/4);
  // curveVertex(canX/4, canY/4);
  // endShape();
}



public void drawRec(int posX, int posY, int size, int col) {
  stroke(0);
  fill(col);
  rect(posX, posY, size, size);
}

public void drawMultiRec(int posX, int posY, int size, int col) {
  stroke(0);
  fill(col);
  rect(posX, posY, size, size);
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Colours" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
