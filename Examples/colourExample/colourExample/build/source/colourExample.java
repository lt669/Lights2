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

public class colourExample extends PApplet {

public void setup(){
	size (400,400);

	colorMode(HSB,360,100,100);

	fill(180,100,100);
	rect(100,100,50,50);

	int colourHSB = color(HSB,180,100,100);

	float red = red(colourHSB);
	float green = green(colourHSB);
	float blue = blue(colourHSB);

	println("red: "+red+" green: "+green+" blue: "+blue);
}

public void draw(){
	
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "colourExample" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
