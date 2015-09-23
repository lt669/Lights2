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

public class IntroScreen extends PApplet {

int canX = 2048;
int canY = 768;

 // int canX = 1200;
 // int canY = 200;
boolean glow = false;
int timeRunning;
int totalTimeRunning;
int last;
int minutesLeft = 4; 
int fontSize = 50;
int bulbArmLength;
int loopCounter;

bulbClass bulb1;

PFont f;

public void setup() {
  f = createFont("Arial", 16, true);
  size(canX, canY);
  bulb1 = new bulbClass(canX/4, 0);
  frameRate(30);
}

public void draw() {
  background(0);
  runBulb();
  timer();
  export();
}

public void runBulb() {
  bulb1.swing(bulbArmLength);
  bulb1.glow();
}

public void mousePressed() {
  //glow = true;
}

public void mouseReleased() {
  //glow = false;
  //bulb1.setArmLength();
}

public void export(){
  if(timeRunning < 5000*60 + 10000){
    saveFrame("/Users/Lewis/Desktop/IntroVideo2/sketch-#######.png");
  }
  else{
    println("Done Recording");
  }
}

public void timer() {

  timeRunning = ((loopCounter/25)*1000)-last;
  totalTimeRunning = (loopCounter/25)*1000;

  // timeRunning = millis() - last;

  int secondsLeft = (60000 - timeRunning)/1000;
  if (secondsLeft < 0 && minutesLeft != 0) {
    //last = millis(); 
    last = totalTimeRunning;
    minutesLeft -= 1;
  }

  int timeRemaining = 300000 - timeRunning; /*millis();*/ /* (minutesLeft*10000)+(secondsLeft*1000) */

  bulbArmLength = PApplet.parseInt(map(timeRemaining, 0, 300000, 0, canY - 160));
  //bulbArmLength = int(map(timeRemaining, 300000,0, canY, 0));

  int startPos = canX*3/4+100;

  //colorMode(HSB, 360, 100, 100, 100);
  textFont(f, fontSize);
  fill(255, 255, 255, 100);
  if(secondsLeft <= 0 && minutesLeft <= 0){
    text("Ready To Begin", canX/2, canY/2);
  } else {
  if (secondsLeft < 10) {
    text("Time Remaining - "+(minutesLeft) + ":0" + secondsLeft +"", canX/2, canY/2);
  } else {
    text("Time Remaining - "+(minutesLeft) + ":" + secondsLeft +"", canX/2, canY/2);
  }
}
  loopCounter++;
}

//bulbClass

class bulbClass {

  int offSet = 25;
  float xMovement;
  float yMovement;
  float xPos;
  float yPos;
  int centerX;
  int centerY;
  float size = 0.05f;
  float theta = 0.0f;
  int swing = 20;
  float rotation;
  int topX = 10;
  int topY = 75;

  PImage bulb;


  //Physics variables
  float g = -0.005f;
  float a;
  float angle = HALF_PI/4;
  float v;
  float armLength;
  float NewarmLength;
  float m; //Mass
  float damp = 1; //Damping factor
  float l = 50;
  float w = sqrt(g/l);

  int flash;
  int flashSize;
  int trailLength = 30;
  float[] [] trail = new float[trailLength][2];

  //Constructor
  bulbClass(int iPosX, int iPosY) {
    xPos = iPosX;
    yPos = iPosY;
    centerX = iPosX;
    centerY = iPosY;

    imageMode(CENTER);
    //    bulb = loadImage("/Users/Lewis/Developer/Lights_Project/Lights/Examples/Bulb/Bulb/Bulb_cutV2.png");
    dataPath("images/Bulb_cutV2.png");
    bulb = loadImage(dataPath("images/Bulb_cutV2.png"));
    //Dimensions 2448 x 3264
  }

  public void swing(float armLength) { 
    //  this.armLength = armLength;   

    //armLength = NewarmLength;
    
    m = map(armLength, 0, canY, 1, 10);
    //Calculate acceleration
    a = (g/m) * sin(angle);

    //Increment Velocity
    v += a;
    
    //Damp velocity
    v *= damp;

    //Increment Angle
    angle += v;


    //Calculate Positions
    xPos = armLength * sin(angle) + centerX;
    yPos = armLength * cos(angle) + centerY;


    for (int i=0; i< (trail.length-1); i++) {
      trail[(trailLength-1)-i][0] = trail[(trailLength-1)-(i+1)][0];
      trail[(trailLength-1)-i][1] = trail[(trailLength-1)-(i+1)][1];
    }
    trail[0][0] = xPos;
    trail[0][1] = yPos;

//    for (int i=0; i<trail.length; i++) {
//      println("["+i+"]: topX: "+trail[i][0]+" topY "+trail[i][1]);
//    }
  }

  public void drawBulb() {

    if(glow == false){
    stroke(0);
    } else if (glow == true){
    stroke(255,255,255);
  }
  
    line(centerX, centerY, xPos, yPos);

    pushMatrix();
    translate(xPos, yPos);
    rotate(-(angle));
    image(bulb, topX, topY, 2448*size, 3264*size);
    popMatrix();
  }

  public void glow() {

    glow = true;
    
    if (glow == true) {  

      for (int i=0; i<trail.length; i++) {
        pushMatrix();
        translate(trail[i][0], trail[i][1]);
        rotate(-(angle));
        //      //Black
        //      noStroke();
        //      fill(0, 0, 0, 255 - flash);
        //      ellipse(topX, topY, 200, 200);
        //White
        noStroke();
        fill(255, 0, 0, flash);
        ellipse(topX, topY + 20, flashSize - (i*5), flashSize-(i*5));
        //        fill(0, 0, 0, 50);
        //        ellipse(topX, topY + 20, flashSize-20, flashSize-20);
        popMatrix();
      }
      flashSize += 20;
      if (flashSize >= 160) {
        flashSize = 160;
      }
      flash+= 20;
      if (flash >= 100) {
        flash = 100;
      }
      drawBulb();
    } else {
      drawBulb();
      flash = 0;
      flashSize = 0;
      pushMatrix();
      translate(xPos, yPos);
      rotate(-(angle));
      noStroke();
      fill(0, 0, 0, 230);
      ellipse(topX, topY, 200, 200);
      popMatrix();
    }
  }
  
  public void setArmLength(){
    //NewarmLength = random(0,canY - 200); //Must be set to appropriate number of pixles
    xPos = mouseX;
    print("A ",armLength);
  }

  //  void glow() {
  //    if (glow == true) {
  //      smooth();
  //      noStroke();
  //      fill(255, 50, 0);
  //      ellipse(xPos+topX, yPos+offSet+topY, 120, 120);
  //      filter( BLUR, 3 );
  //    }
  //    if (glow == false) {
  //      noStroke();
  //      rectMode(CORNER);
  //      fill(255, 255, 255, 5);
  //      rect(0, 0, canX, canY);
  //    }
  //  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "IntroScreen" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
