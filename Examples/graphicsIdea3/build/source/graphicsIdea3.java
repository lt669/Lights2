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

public class graphicsIdea3 extends PApplet {

archClass arch1;
archClass arch2;
archClass arch3;

public void setup(){
	size (400, 400);
	arch1 = new archClass(50,100,350,100,50);
	arch2 = new archClass(50,200,350,200,50);
	arch3 = new archClass(50,300,350,300,50);
}

public void draw(){
	background(-1);
	arch1.drawArch(255,100,0,0,205,30);
	arch2.drawArch(0,100,58,12,106,200);
	arch3.drawArch(100,255,200,90,50,100);
}
class archClass{

	int xStartPos, yStartPos, xEndPos, yEndPos, size/*, pitch1, pitch2*/;
	int extraHeight = 20;
	

	//Constructor
	archClass(int iXStartPos, int iYStartPos, int iXEndPos, int iYEndPos, int iSize){
		xStartPos = iXStartPos;
		yStartPos = iYStartPos;
		xEndPos = iXEndPos;
		yEndPos = iYEndPos;

		size = iSize;

	}


public void drawArch(int r1, int g1, int b1, int r2, int g2, int b2){


	int midPoint = xEndPos - (xEndPos-xStartPos)/2;

	//Convert Pitch

	//drawArch for first circle
	noStroke();
	fill(r1,g1,b1,50);
	beginShape();
	curveVertex(xStartPos, yStartPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xEndPos,yEndPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape(CLOSE);
	noStroke();
	fill(r1,g1,b1,50);
	beginShape();
	curveVertex(xEndPos, yEndPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xStartPos,yStartPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape();


	noStroke();
	fill(r2,g2,b2,50);
	beginShape();
	curveVertex(xEndPos, yEndPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xStartPos,yStartPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape();
	noStroke();
	fill(r2,g2,b2,50);
	beginShape();
	curveVertex(xStartPos, yStartPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xEndPos,yEndPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape(CLOSE);

		//Draw circles
	fill(r1,g1,b1);
	ellipse(xStartPos, yStartPos, size, size);

	//End Circle
	fill(r2,g2,b2);
	ellipse(xEndPos, yEndPos, size, size);

}


}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "graphicsIdea3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
