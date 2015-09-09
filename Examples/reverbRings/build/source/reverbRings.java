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

public class reverbRings extends PApplet {

int radius;
int alpha = 100;
boolean pressed;
boolean DONE;

reverbRingsClass r1;
reverbRingsClass r2;

public void setup(){
	size(400,400);
	r1 = new reverbRingsClass(100,100,0,100);
	r2 = new reverbRingsClass(100,200,0,100);
}

public void draw(){
	background(-1);
	colorMode(HSB,360,100,100,100);

	if(pressed == true || DONE == false){
	radius += 1;
	alpha -= 1;
	}

	if(alpha <= 0){
		alpha = 100;
		radius = 0;
		DONE = true;
		pressed = false;
	}

	r1.drawRings(radius,alpha);
	r2.drawRings(radius,alpha);
}

public void mousePressed(){
	pressed = true;
	println("PRESSED");
}
class reverbRingsClass{

int xPos,yPos, r, alpha;

	//Constructor
	reverbRingsClass(int iXPos, int iYPos, int iR, int iAlpha){
		xPos = iXPos;
		yPos = iYPos;
		r = iR;
		alpha = iAlpha;
	}

public void drawRings(int r, int alpha){

	stroke(0,0,0,alpha);
	fill(0,0,0,0);
	beginShape();
	for (int i = 0; i < r; i++) {
	float x = cos(radians(i*360/r))*r;
	float y = sin(radians(i*360/r))*r;
	vertex(x+xPos,y+yPos);
}
	endShape(CLOSE);
}

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "reverbRings" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
