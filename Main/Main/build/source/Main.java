import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import org.puredata.processing.PureData; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 
import processing.serial.*; 
import codeanticode.gsvideo.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Main extends PApplet {






//import com.hamoid.*;
Serial port;

//Quicktime Variables
//VideoExport videoExport2;
//GSMovieMaker video;
boolean recordVideo, stopVideo;
//import processing.sound.*;
//SoundFile file;

//Playing Audio File
Minim minim;
AudioPlayer player;

//Shared Variables

//Office Screen
//int canX = 1650;
//int canY = 600;

//int squigleCanX = canX;
//int squigleCanY = canY;

//Set up classes
squigleClass sq1;
squigleClass sq2;
squigleClass sq3;
squigleClass sq4;
squigleClass sq5;
squigleClass sq6;

Cir singer1;
Cir singer2;
Cir singer3;
Cir singer4;
Cir singer5;
Cir singer6;

archClass arch1;
archClass arch2;
archClass arch3;


textFileReader PART1;
textFileReader PART2;
textFileReader PART3;
textFileReader PART4;
textFileReader PART5;
textFileReader PART6;

reverbRings reverb1;
reverbRings reverb2;

PureData pd;
PGraphics Circles;
PGraphics Squigles;

int alpha;
boolean alphaDONE;
boolean just;
int [] graphicChooser = new int[2];
boolean fadedDONE;

public void setup() {

  //Setup video rendering
  // video = new GSMovieMaker(this,canX,canY,"ProcessingVideo.mov", GSMovieMaker.THEORA, GSMovieMaker.MEDIUM, fps);
  // video.setQueueSize(50,10);
  // video.start();

  //Initialise Port to send serial data to arduino
  // port = new Serial(this, "/dev/cu.usbmodem411", 9600); 
  // port.bufferUntil('\n');

  // videoExport2 = new VideoExport(this, "/Users/Lewis/Desktop/export.mp4");
  // videoExport2.setQuality(70);
  // videoExport2.setFrameRate(60);
  //Create PGraphics
  Circles = createGraphics(canX, canY);
  //Squigles = createGraphics(squigleCanX, squigleCanY);

  minim = new Minim(this);
  //PC
  //  player = minim.loadFile("C:/Users/lt669/Desktop/music/music(verb).mp3");
  //  player.play();

  //Mac
   // player = minim.loadFile("/Users/Lewis/Desktop/music(verb).mp3");
   // player.play();


  //Setup PD patch
//   pd = new PureData(this, 44100, 0, 2); //6 outputs
//   //  pd.openPatch("/Users/Lewis/Developer/Lights_Project/Lights/Main/Main/patch.pd");  
//   pd.openPatch("patch.pd");
//   pd.start();

  //Load cues into array
  setCues();

  //Load .txt files to singer classes
  PART1 = new textFileReader("Part1.txt");
  PART2 = new textFileReader("Part2.txt");
  PART3 = new textFileReader("Part3.txt");
  PART4 = new textFileReader("Part4.txt");
  PART5 = new textFileReader("Part5.txt");
  PART6 = new textFileReader("Part6.txt");

  //Read Data from .txt files
  PART1.read();
  PART2.read();
  PART3.read();
  PART4.read();
  PART5.read();
  PART6.read();

  //Calculate the Pitch and Duration range for scaling purposes
  PART1.rangeCalc();
  PART2.rangeCalc();
  PART3.rangeCalc();
  PART4.rangeCalc();
  PART5.rangeCalc();
  PART6.rangeCalc();
  
  //Send the length of each text file o the arduino
//  port.write("PART1 Length");
//  port.write(PART1.getTextLength());

  //Circle Objects
  singer1 = new Cir(canX/4, canY/4, 0, 0);
  singer2 = new Cir(canX/2, canY/4, 0, 0);
  singer3 = new Cir(canX*3/4, canY/4, 0, 0);
  singer4 = new Cir(canX/4, canY*3/4, 0, 0);
  singer5 = new Cir(canX/2, canY*3/4, 0, 0);
  singer6 = new Cir(canX*3/4, canY*3/4, 0, 0);

  //Squigle Objects
  sq1 = new squigleClass(canX/4, canY/4);
  sq2 = new squigleClass(canX/2, canY/4);
  sq3 = new squigleClass(canX*3/4, canY/4);
  sq4 = new squigleClass(canX/4, canY*3/4);
  sq5 = new squigleClass(canX/2, canY*3/4);
  sq6 = new squigleClass(canX*3/4, canY*3/4);

  //reverbRings objects
  reverb1 = new reverbRings(canX/4, canY/2,0,100);
  reverb2 = new reverbRings(canX*3/4, canY/2,0,100);

  //archClass objects
  arch1 = new archClass(canX/4,canY/4,canX*3/4,canY/4,50);
  arch2 = new archClass(canX/4,canY/2,canX*3/4,canY/2,50);
  arch3 = new archClass(canX/4,canY*3/4,canX*3/4,canY*3/4,50);


  //Set the Pitch and Duration ranges in the appropriate classes
  singer1.setRange(PART1.getMinPitch(), PART1.getMaxPitch(), PART1.getMinDuration(), PART1.getMaxDuration());
  singer2.setRange(PART2.getMinPitch(), PART2.getMaxPitch(), PART2.getMinDuration(), PART2.getMaxDuration());
  singer3.setRange(PART3.getMinPitch(), PART3.getMaxPitch(), PART3.getMinDuration(), PART3.getMaxDuration());
  singer4.setRange(PART4.getMinPitch(), PART4.getMaxPitch(), PART4.getMinDuration(), PART4.getMaxDuration());
  singer5.setRange(PART5.getMinPitch(), PART5.getMaxPitch(), PART5.getMinDuration(), PART5.getMaxDuration());
  singer6.setRange(PART6.getMinPitch(), PART6.getMaxPitch(), PART6.getMinDuration(), PART6.getMaxDuration());

  sq1.setRange(PART1.getMinPitch(), PART1.getMaxPitch(), PART1.getMinDuration(), PART1.getMaxDuration());
  sq2.setRange(PART2.getMinPitch(), PART2.getMaxPitch(), PART2.getMinDuration(), PART2.getMaxDuration());
  sq3.setRange(PART3.getMinPitch(), PART3.getMaxPitch(), PART3.getMinDuration(), PART3.getMaxDuration());
  sq4.setRange(PART4.getMinPitch(), PART4.getMaxPitch(), PART4.getMinDuration(), PART4.getMaxDuration());
  sq5.setRange(PART5.getMinPitch(), PART5.getMaxPitch(), PART5.getMinDuration(), PART5.getMaxDuration());
  sq6.setRange(PART6.getMinPitch(), PART6.getMaxPitch(), PART6.getMinDuration(), PART6.getMaxDuration());

  arch1.setRange(PART1.getMinPitch(), PART1.getMaxPitch(), PART1.getMinDuration(), PART1.getMaxDuration());
  arch2.setRange(PART2.getMinPitch(), PART2.getMaxPitch(), PART2.getMinDuration(), PART2.getMaxDuration());
  arch3.setRange(PART3.getMinPitch(), PART3.getMaxPitch(), PART3.getMinDuration(), PART3.getMaxDuration());
  

  //Send start bang to PD
  // pd.sendFloat("bang",startBang);

  //Initialise cues array
  //cueArray[] = new int[]

  size(canX, canY);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);

}

public void draw() {
  //reDraw = false;

  timer = (loopCounter/60)*1000; //In milliseconds
  println("Timer: ",timer);
  //recordSketch();

  colorMode(HSB, 360, 100, 100, 100);

  if (alphaDONE == true) {
    background(BGhue, BGsat, BGbri);
  }

  if (choice < 4) {
    //Fades out parts of the screen
    noStroke();
    fill(BGhue, BGsat, BGbri, 10);
    rect(random((0-canX/4), canX), random((0-canY/4), canY), canX/4, canY/4);
  } else if (choice == 4 || choice == 5 /*|| choice == 6*/) {
    //    noStroke();
    //    fill(BGhue, BGsat, BGbri, 5);
    //    rect(0, 0, canX, canY);
  } else {
    background(BGhue, BGsat, BGbri);
  }

  PART1.timer(1);
  PART2.timer(2);
  PART3.timer(3);
  PART4.timer(4);
  PART5.timer(5);
  PART6.timer(6);

  //graphicsOrder(); //Listens for cues and changes graphics accordingly
  graphicsOrder2();
  graphicChoice(); //Sets all settings for each graphic
  runCircleClass();
  runSquigleClass();
  runArchClass();
  halfScreen();
  screenFader();

  //Cue Reader
  if(millis() == cueArray[cueAddress]){
    println("Cue["+cueAddress+"}");
    x++;
  }

  loopCounter++; //Increase loopCounter

  //Run PD function
  //PD();
}

public void graphicsOrder(){
   if(millis() < cueArray[2]){
     graphicChooser[0] = 11; //New graphic choise
    } else if(millis() > cueArray[2] && millis() < cueArray[4]){
       if(millis() < cueArray[2]+100){
        setFader();
   }

    graphicChooser[0] = 1; //New graphic choise
    } else if(millis() > cueArray[4] && millis() < cueArray[5]){
     if(millis() < cueArray[4]+100){
     setFader();
   }
     graphicChooser[0] = 3; //New graphic choise
    } else if(millis() > cueArray[5] && millis() < cueArray[6]){
     if(millis() < cueArray[5]+100){
     setFader();
   }
     graphicChooser[0] = 4; //New graphic choise
    } else if(millis() > cueArray[6] && millis() < cueArray[7]){
     if(millis() < cueArray[6]+100){
     setFader();
   }
     graphicChooser[0] = 11; //New graphic choise
    } else if(millis() > cueArray[7] && millis() < cueArray[9]){
     if(millis() < cueArray[7]+100){
     setFader();
   }
     graphicChooser[0] = 7; //New graphic choise
    } else if(millis() > cueArray[9] && millis() < cueArray[10]){
     if(millis() < cueArray[9]+100){
     setFader();
   }
     graphicChooser[0] = 2; //New graphic choise
    } else if(millis() > cueArray[10] && millis() < cueArray[11]){
     if(millis() < cueArray[10]+100){
     setFader();
   }
     graphicChooser[0] = 3; //New graphic choise else if(millis() > cueArray[11] && millis() < cueArray[12]){
     if(millis() < cueArray[11]+100){
     setFader();
   }
     graphicChooser[0] = 9; //New graphic choise
    } else if(millis() > cueArray[12] && millis() < cueArray[13]){
     if(millis() < cueArray[12]+100){
     setFader();
   }
     graphicChooser[0] = 10; //New graphic choise
    } else if(millis() > cueArray[13] && millis() < cueArray[16]){
     if(millis() < cueArray[13]+200){
     setFader();
   }
     graphicChooser[0] = 6; //New graphic choise
    } else if(millis() > cueArray[16] && millis() < cueArray[18]){
     if(millis() < cueArray[16]+100){
     setFader();
   }
     graphicChooser[0] = 7; //New graphic choise
    } else if(millis() > cueArray[18] && millis() < cueArray[19]){
     if(millis() < cueArray[18]+100){
     setFader();
   }
     graphicChooser[0] = 11; //New graphic choise
    } else if(millis() > cueArray[19] && millis() < cueArray[20]){
     if(millis() < cueArray[19]+100){
     setFader();
   }
     graphicChooser[0] = 1; //New graphic choise
    } else if(millis() > cueArray[20]){
     if(millis() < cueArray[20]+100){
     setFader();
   }
     graphicChooser[0] = 11; //New graphic choise
    }
  }

  public void graphicsOrder2(){
   if(timer < cueArray[2]){
     graphicChooser[0] = 11; //New graphic choise
    } else if(timer > cueArray[2] && timer < cueArray[4]){
       if(timer < cueArray[2]+1000){
        setFader();
         
   }
      graphicChooser[0] = 1; //New graphic choise
    } else if(timer > cueArray[4] && timer < cueArray[5]){
     if(timer < cueArray[4]+2000){
     setFader();
   }
     graphicChooser[0] = 3; //New graphic choise
    } else if(timer > cueArray[5] && timer < cueArray[6]){
     if(timer < cueArray[5]+2000){
     setFader();
   }
     graphicChooser[0] = 4; //New graphic choise
    } else if(timer > cueArray[6] && timer < cueArray[7]){
     if(timer < cueArray[6]+100){
     setFader();
   }
     graphicChooser[0] = 11; //New graphic choise
    } else if(timer > cueArray[7] && timer < cueArray[9]){
     if(timer < cueArray[7]+100){
     setFader();
   }
     graphicChooser[0] = 7; //New graphic choise
    } else if(timer > cueArray[9] && timer < cueArray[10]){
     if(timer < cueArray[9]+100){
     setFader();
   }
     graphicChooser[0] = 2; //New graphic choise
    } else if(timer > cueArray[10] && timer < cueArray[11]){
     if(timer < cueArray[10]+100){
     setFader();
   }
     graphicChooser[0] = 3; //New graphic choise else if(millis() > cueArray[11] && millis() < cueArray[12]){
     if(timer < cueArray[11]+100){
     setFader();
   }
     graphicChooser[0] = 9; //New graphic choise
    } else if(timer > cueArray[12] && timer < cueArray[13]){
     if(timer < cueArray[12]+100){
     setFader();
   }
     graphicChooser[0] = 10; //New graphic choise
    } else if(timer > cueArray[13] && timer < cueArray[16]){
     if(timer < cueArray[13]+200){
     setFader();
   }
     graphicChooser[0] = 6; //New graphic choise
    } else if(timer > cueArray[16] && timer < cueArray[18]){
     if(timer < cueArray[16]+100){
     setFader();
   }
     graphicChooser[0] = 7; //New graphic choise
    } else if(timer > cueArray[18] && timer < cueArray[19]){
     if(timer < cueArray[18]+100){
     setFader();
   }
     graphicChooser[0] = 11; //New graphic choise
    } else if(timer > cueArray[19] && timer < cueArray[20]){
     if(timer < cueArray[19]+100){
     setFader();
   }
     graphicChooser[0] = 1; //New graphic choise
    } else if(timer > cueArray[20]){
     if(timer < cueArray[20]+100){
     setFader();
   }
     graphicChooser[0] = 11; //New graphic choise
    }
  }


public void setFader(){
      fadedDONE = false;
      just = true;
}

public void recordSketch(){

  if(timer /*millis()*/ < cueArray[20] + 10000){

//videoExport2.saveFrame();
    
    saveFrame("/Users/Lewis/Desktop/Images/sketch-#######.png");
    // loadPixels();
    // video.addFrame(pixels);
    // println("Number of queued frames : " + video.getQueuedFrames());
    // println("Number of dropped frames: " + video.getDroppedFrames());
  } else {
    //video.finish();
    println("Done Recording");
  }

}

public void screenFader(){
   if (fadedDONE == false) {
    if (just == true) {
      alpha = 1;
    }
    just = false;

    if (alphaDONE == false) {
      alpha += 1;
    }

    if (alpha >= 100) {
      alphaDONE = true;
      //graphicChooser += 1 /* round(random(1, 7))*/;
      graphicChooser[1] = graphicChooser[0];
    }

    if (alphaDONE == true) {
      alpha -= 1;
    }

    if (alpha < 0) {
      fadedDONE = true;
      alphaDONE = false;
      alpha = -2;
    }

    //Extra canvas used for the fade effect
    Circles.beginDraw();
    Circles.colorMode(HSB, 360, 100, 100, 100);
    Circles.background(0, 0, 0, 0);
    Circles.fill(0, 0, 100, alpha);
    Circles.noStroke();
    Circles.rect(0, 0, canX, canY);
    Circles.endDraw();
    image(Circles, 0, 0, canX, canY);
  }
}

public void mousePressed() {
  //just = true;
  check = 1;
  redraw();
  //port.write('A');
  //  pd.sendFloat("stopBang",stopBang);
}

public void mouseReleased() {
  check = 0;
}

public void graphicChoice() {
  if (graphicChooser[1] == 1) {
    choice = 1;
    select = 5;
  } else if (graphicChooser[1] == 2) {
    choice = 2;
    select = 3;
  } else if (graphicChooser[1] == 3) {
    choice = 3;
    select = 5;
  } else if (graphicChooser[1] == 4) {
    choice = 4;
    select = 5;
  } else if (graphicChooser[1] == 5) {
    choice = 4;
    select = 4;
  } else if (graphicChooser[1] == 6) {
    choice = 5;
    select = 5;
  } else if (graphicChooser[1] == 7) {
    choice = 5;
    select = 4;
  } else if (graphicChooser[1] == 8) {
    choice = 6;
    select = 3;
  } else if (graphicChooser[1] == 9) {
    choice = 7;
    select = 6;
  } else if (graphicChooser[1] == 10) {
    choice = 8;
    select = 6;
  } else if (graphicChooser[1] == 11) {
    choice = 0;
    select = 4;
  }

  if (select == 3) { //Black BG, flat colours
    BGhue = 0;
    BGsat = 0;
    BGbri = 0;
    colorBright = 1;
  } else if (select == 4) { //Black BG, bright colours
    BGhue = 0;
    BGsat = 0;
    BGbri = 0;
    colorBright = 2;
  } else if (select == 5) { //White BG, flat colours
    BGhue = 0;
    BGsat = 0;
    BGbri = 100;
    colorBright = 1;
  } else if (select == 6) { //White BG, bright colours
    BGhue = 0;
    BGsat = 0;
    BGbri = 100;
    colorBright = 2;
  }
}

public void halfScreen(){

  if(choice == 7){
    //LeftSide
    noStroke();
    fill(0,0,100);
    rect(0,0,canX/2,canY);
    //RightSide
    noStroke();
    fill(0,100,70);
    rect(canX/2,0,canX/2,canY);
  } else if(choice == 8){
    //LeftSide
    noStroke();
    fill(108,94,30);
    rect(0,0,canX/2,canY);
    //RightSide
    noStroke();
    fill(0,0,100);
    rect(canX/2,0,canX/2,canY);
  }
}

public void keyPressed() {

  select = Character.digit(key, 10);
  //state = select;
  println("Select: ", select);
  if (select == 0) {
    // just = true;
    // fadedDONE = false;
    state++;
  }

  if(select == 1){
    state--;
  }
  pressed = true;
}

public void keyReleased() {
  pressed = false;
}

public void runCircleClass() {

  // background(-1);

  singer1.setBright(PART1.getPitch());
  singer1.setSize(PART1.getDuration());
  singer1.setSecondPassed(PART1.getSecondPassed());
  singer1.setNext(PART1.getNext());
  singer1.drawCir(canX/4, canY/4);

  singer2.setBright(PART2.getPitch());
  singer2.setSize(PART2.getDuration());
  singer2.setSecondPassed(PART2.getSecondPassed());
  singer2.setNext(PART2.getNext());
  singer2.drawCir(canX/2, canY/4);

  singer3.setBright(PART3.getPitch());
  singer3.setSize(PART3.getDuration());
  singer3.setSecondPassed(PART3.getSecondPassed());
  singer3.setNext(PART3.getNext());
  singer3.drawCir(canX*3/4, canY/4);

  singer4.setBright(PART4.getPitch());
  singer4.setSize(PART4.getDuration());
  singer4.setSecondPassed(PART4.getSecondPassed());
  singer4.setNext(PART4.getNext());
  singer4.drawCir(canX/4, canY*3/4);

  singer5.setBright(PART5.getPitch());
  singer5.setSize(PART5.getDuration());
  singer5.setSecondPassed(PART5.getSecondPassed());
  singer5.setNext(PART5.getNext());
  singer5.drawCir(canX/2, canY*3/4);

  singer6.setBright(PART6.getPitch());
  singer6.setSize(PART6.getDuration());
  singer6.setSecondPassed(PART6.getSecondPassed());
  singer6.setNext(PART6.getNext());
  singer6.drawCir(canX*3/4, canY*3/4);

  //  float imgX = random(-5, 5);
  //  float imgY = random(-5, 5);
}

public void runSquigleClass() {



  sq1.calcShape(PART1.getDuration(), PART1.getLvl(), canX/4, canY/4);
  sq1.edgeCheck();
  sq1.drawShape();

  sq2.calcShape(PART2.getDuration(), PART2.getLvl(), canX/2, canY/4);
  sq2.drawShape();
  sq2.edgeCheck();

  sq3.calcShape(PART3.getDuration(), PART3.getLvl(), canX*3/4, canY/4);
  sq3.drawShape();
  sq3.edgeCheck();

  sq4.calcShape(PART4.getDuration(), PART4.getLvl(), canX/4, canY*3/4);
  sq4.drawShape();
  sq4.edgeCheck();

  sq5.calcShape(PART5.getDuration(), PART5.getLvl(), canX/2, canY*3/4);
  sq5.drawShape();
  sq5.edgeCheck();

  sq6.calcShape(PART6.getDuration(), PART6.getLvl(), canX*3/4, canY*3/4);
  sq6.drawShape();
  sq6.edgeCheck();
}

public void runReverbClass(){


  reverb1.drawRings(PART1.getNext());

}

public void PD() {

  pd.sendFloat("frequency1", (float)PART1.getPitch());
  pd.sendFloat("lvl1", PART1.getLvl());

  // pd.sendFloat("frequency2", (float)PART2.getPitch());
  // pd.sendFloat("lvl2", PART2.getLvl());

  // pd.sendFloat("frequency3", (float)PART3.getPitch());
  // pd.sendFloat("lvl3", PART3.getLvl());

  // pd.sendFloat("frequency4", (float)PART4.getPitch());
  // pd.sendFloat("lvl4", PART4.getLvl());

  // pd.sendFloat("frequency5", (float)PART5.getPitch());
  // pd.sendFloat("lvl5", PART5.getLvl());

  // pd.sendFloat("frequency6", (float)PART6.getPitch());
  // pd.sendFloat("lvl6", PART6.getLvl());
}

public void runRectangles() {

  colorMode(HSB, 360, 100, 100);
  int colour1 = PApplet.parseInt(map(PART1.getPitch(), PART1.getMinPitch(), PART1.getMaxPitch(), 0, 360));
  int colour2 = PApplet.parseInt(map(PART2.getPitch(), PART2.getMinPitch(), PART2.getMaxPitch(), 0, 360));
  int colour3 = PApplet.parseInt(map(PART3.getPitch(), PART3.getMinPitch(), PART3.getMaxPitch(), 0, 360));
  int colour4 = PApplet.parseInt(map(PART4.getPitch(), PART4.getMinPitch(), PART4.getMaxPitch(), 0, 360));
  int colour5 = PApplet.parseInt(map(PART5.getPitch(), PART5.getMinPitch(), PART5.getMaxPitch(), 0, 360));
  int colour6 = PApplet.parseInt(map(PART6.getPitch(), PART6.getMinPitch(), PART6.getMaxPitch(), 0, 360));


  drawRect(colour1, 10, 10, 50, 100);
  drawRect(colour2, 60, 10, 50, 100);
  drawRect(colour3, 110, 10, 50, 100);
  drawRect(colour4, 160, 10, 50, 100);
  drawRect(colour5, 210, 10, 50, 100);
  drawRect(colour6, 260, 10, 50, 100);

  //Mix

  drawRect(colour1, 100, 100, 70, 10);
  drawRect(colour2, 100, 100, 70, 10);
  drawRect(colour3, 100, 100, 70, 10);
  drawRect(colour4, 100, 100, 70, 10);
  drawRect(colour5, 100, 100, 70, 10);
  drawRect(colour6, 100, 100, 70, 10);
}

public void runArchClass(){
  if(choice == 6){

  arch1.getNext(PART1.getNext(),PART2.getNext());
  arch2.getNext(PART3.getNext(),PART4.getNext());
  arch3.getNext(PART5.getNext(),PART6.getNext());

  arch1.getPitch(PART1.getPitch(),PART2.getPitch());
  arch2.getPitch(PART3.getPitch(),PART4.getPitch());
  arch3.getPitch(PART5.getPitch(),PART6.getPitch());

  arch1.drawArch();
  arch2.drawArch();
  arch3.drawArch();
  }
}

public void drawRect(int col, int posX, int posY, int size, int tran) {
  int colour = col;

  if (PART1.getNext() == true) {
    comp[1] = comp[0];
    comp[0] = col;
  }
  if (comp[0] > comp[1]) {
    colour-=10;
  } else if ( comp[0] < comp[1]) {
    colour+=10;
  } else {
    colour = colour;
  }

  println("comp[0]: "+comp[0]+" comp[1]: "+comp[1]+" col: "+col+" colour: "+colour);

  noStroke();
  fill(colour, 100, 100, tran);
  rect(posX, posY, size, size);
}



//Class for drawing a randomly moving, size changing circle

class Cir {
  int posX;
  int posY;
  int maxSize;
  int size = 0;
  int bright;
  boolean DONE;
  boolean NEXT;
  boolean durationTime;
  boolean secondPassed;
  int durationMod;
  int durationCounter = 0;
  int last = 0;
  int millis;
  int seconds;
  int[] secondArray = new int[2]; // place to compare seconds values
  float Saturation;
  float Brightness;

  //Range Variables
  int minPitch;
  int maxPitch;
  int minDuration;
  int maxDuration;

  int movement;
  int sizeMultiplier;

  int durationInMS;

  boolean w;

  //Constructor
  Cir(int iPosX, int iPosY, int iSize, int iBright) {
    posX = iPosX;
    posY = iPosY;
    maxSize = iSize;
    bright = iBright;
  }

  public void drawCir(int restartX, int restartY) {

    if (alphaDONE == true) {
      posX = restartX;
      posY = restartY;
    }

    float incX = 0;
    float incY = 0;

    if (select == 3 || select == 4) {
      movement = 2;
      sizeMultiplier = 1;
      incX = random(-(size*sizeMultiplier)*movement, (size*sizeMultiplier)*movement);
      incY = random(-(size*sizeMultiplier)*movement, (size*sizeMultiplier)*movement);
    } else if (select == 5) {
      movement = 1;
      sizeMultiplier = 1;
      incX = random(-(size)*movement, size*movement);
      incY = random(-(size)*movement, size*movement);
    } else if (select == 6) {
      int randomMovement = round(random(3));

      if (randomMovement == 0) {
        incX = size*sizeMultiplier;
        incY = size*sizeMultiplier;
      } else if (randomMovement == 1) {
        incX = -size*sizeMultiplier;
        incY = size*sizeMultiplier;
      } else if (randomMovement == 2) {
        incX = size*sizeMultiplier;
        incY = -size*sizeMultiplier;
      } else if (randomMovement == 3) {
        incX = -size*sizeMultiplier;
        incY = -size*sizeMultiplier;
      }
    }

    //Random movement variables


    //Update position
    posX += incX;
    posY += incY;

    //Wrap around canvas
    if (posX <= 0) {
      posX += canX;
    } else if (posX == canX) {
      posX -= canX;
    }

    if (posY <= 0) {
      posY += canY;
    } else if (posY >= canY) {
      posY -= canY;
    }

    //New Size Altering Algorithm
    float increaseTime = durationInMS/(maxSize + 1); //+1 to prevent from being 0
    float currentTime = timer/*millis()*/ - last;

    //Alter circle size
    if (size >= maxSize && DONE != true) { //Once circle has reached maxSize, DONE
      DONE = true;
      //      print("\n DONE");
    } else if (DONE != true && currentTime >= increaseTime) { //If its maximum size is not reached, increase size
      size++;
      last = PApplet.parseInt(timer) /*millis()*/;
    } else if (DONE == true && size != 0 /*|| size > maxSize*/) {
      // size = abs(size-1);
      size--;
    }

    if (NEXT == true) {
      DONE = false;
    }


    float sizeBri = map(size, 0, maxSize, 0, 100);
    colorMode(HSB, 360, 100, 100);
    int colorFlux = PApplet.parseInt(random(-50, 50));

    if (choice == 1) {
      noStroke();
      fill(bright + colorFlux, sizeBri, Brightness, Brightness);
      ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);
    } else if (choice == 2) {
      noStroke();
      fill(bright + colorFlux, sizeBri, Brightness, Brightness);
      ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);
    } else if (choice == 3 || choice == 8) {
      //strokeWeight(1);
      stroke(bright + colorFlux, Saturation, Brightness, 100 - Brightness);
      fill(0, 0, BGbri, Saturation); //Setting last value to 0 makes the circles centres transparent 
      ellipse(posX, posY, size*sizeMultiplier*2, size*sizeMultiplier*2);
    }
  }

  public void setNext(boolean n) {
    NEXT = n;
  }

  public void setRange(int MinPitch, int MaxPitch, int MinDuration, int MaxDuration) {
    minPitch = MinPitch;
    maxPitch = MaxPitch;
    minDuration = MinDuration;
    maxDuration = MaxDuration;
  }

  public void setSize(int SIZE) {
    durationInMS = SIZE;
    maxSize = PApplet.parseInt(map(SIZE, minDuration, maxDuration, 0, 10));
    //  println("SIZE: "+ SIZE + " minD: " + minDuration + " maxD: " + maxDuration + " maxSize: "+maxSize);
  }

  public void setBright(int BRIGHT) {
    //  bright = BRIGHT;
    if (choice == 3) {
      bright = round(map(BRIGHT, 0, maxPitch, 0, 360)); 
      Saturation = round(map(BRIGHT, 0, maxPitch, 0, 100));
      Brightness = round(map(BRIGHT, 0, maxPitch, 0, 70));
    } else {
    bright = round(map(BRIGHT, minPitch, maxPitch, 0, 360)); 
    Saturation = round(map(BRIGHT, minPitch, maxPitch, 0, 100));
    Brightness = round(map(BRIGHT, minPitch, maxPitch, 0, 70));
    }
  }

  public void setSecondPassed(boolean second) {
    secondPassed = second;
  }
}

//Mac
int canX = 1920;
int canY = 1080;

//MovieMaker
int fps = 60;

int loopCounter;
float timer;

boolean first, second;
int backCount = 0;
int BGhue = 0;
int BGsat = 0;
int BGbri = 100;
int colorBright; //graphics brightness variable
int select; //Bckground colour changer and other variables)
//Cicles Variables
Table table;
int dur = 0;
int pit = 0;
PImage img;
char circleKey;
char squigleKey;
int choice = 0;
//char choice;

//Squigle Variables
float check = 0;
char nPoints;
//int nPoints = 1;
float newX = canX/2;
float newY = canY/2;
int input;
boolean pressed;
float move;

float startBang = 1.0f;
float stopBang = 1.0f;

int x =0;
int cueAddress;

int[] comp = new int[2];

int state; //What the Arduino should run

int count; //Prevent screen from fading multiple times

/*---------------CUES---------------*/
int[] cueArray = new int[31];
public void setCues(){
  cueArray[0] = 0;
  cueArray[1] = 68000;
  cueArray[2] = 180000;
  cueArray[3] = 240000;
  cueArray[4] = 300000;
  cueArray[5] = 408000;
  cueArray[6] = 496000;
  cueArray[7] = 564000;
  cueArray[8] = 624000;
  cueArray[9] = 708000;
  cueArray[10] = 768000;
  cueArray[11] = 830000;
  cueArray[12] = 856000;
  cueArray[13] = 916000;
  cueArray[14] = 930000;
  cueArray[15] = 955000;
  cueArray[16] = 1000000;
  cueArray[17] = 1036000;
  cueArray[18] = 1100000;
  cueArray[19] = 1176000;
  cueArray[20] = 1216000;
}
/*---------------CUES---------------*/ 
class archClass{

	float xStartPos, yStartPos, xEndPos, yEndPos, size;
	int extraHeight;
	int minPitch1, minPitch2, maxPitch1, maxPitch2, pitch1, pitch2;
	int [] pitchCompare1 = new int [2];
	int [] pitchCompare2 = new int [2];
	int colourGlide = 1;
	boolean NEXT1, NEXT2;
	int radius1, radius2;
	int alpha1 = 100;
	int alpha2 = 100;
	int transparency = 2;
	reverbRings reverb1;
	reverbRings reverb2;
	int [] xStartPosition = new int[2];
	int [] xEndPosition = new int[2];
	int [] yStartPosition = new int[2];
	int [] yEndPosition = new int[2];
	int movementCounter = 0;
	

	//Constructor
	archClass(int iXStartPos, int iYStartPos, int iXEndPos, int iYEndPos, int iSize){
		xStartPos = iXStartPos;
		yStartPos = iYStartPos;
		xEndPos = iXEndPos;
		yEndPos = iYEndPos;

		size = iSize;

		reverb1 = new reverbRings(xStartPos,yStartPos);
		reverb2 = new reverbRings(xEndPos,yEndPos);

		yStartPosition[1] = iYStartPos;
		yEndPosition[1] = iYEndPos;

	}


public void drawArch(){

	extraHeight = PApplet.parseInt(random(0,50));

	movementCounter++;
	if(movementCounter >= 30){
		movementCounter = 0;
	xStartPosition[1] = xStartPosition[0];
	xStartPosition[0] = PApplet.parseInt(random(0,100));
	xEndPosition[1] = xEndPosition[0];
	xEndPosition[0] = PApplet.parseInt(random(0,100));

	yStartPosition[0] = PApplet.parseInt(random(-1,1));
	yEndPosition[0] = PApplet.parseInt(random(-1,1));
	}

	if (xStartPosition[0] > xStartPosition[1]){
		xStartPos+= 0.1f;
		if(xStartPos >= canX/3 + 10){
			xStartPos = canX/3 + 10;
		}
	} else if(xStartPosition[0] < xStartPosition[1]){
		xStartPos-= 0.1f;
		if(xStartPos <= canX/3 - 10){
			xStartPos = canX/3 - 10;
		}
	}

	if (xEndPosition[0] > xEndPosition[1]){
		xEndPos += 0.1f;
		if(xEndPos >= canX*2/3 + 10){
			xEndPos = canX*2/3 + 10;
		}
	} else if(xEndPosition[0] < xEndPosition[1]){
		xEndPos -= 0.1f;
		if(xEndPos <= canX*2/3 - 10){
			xEndPos = canX*2/3 - 10;
		}
	}

		yStartPos += yStartPosition[1] + yStartPosition[0];
		if(yStartPos >= yStartPosition[1] + 10){
			yStartPos = yStartPosition[1] + 10;
		}
	

		yEndPos += yEndPosition[1] + yEndPosition[0];
		if(yEndPos >= yEndPosition[1] + 10){
			yEndPos = yEndPosition[1] + 10;
		}

	colorMode(HSB,360,100,100,100);
	float midPoint = xEndPos - (xEndPos-xStartPos)/2;

	if(pitchCompare1[0] > pitchCompare1[1]){
		pitch1 -= colourGlide;
		if(pitch1 <= 0){
			pitch1 = 360;
		}
	} else if (pitchCompare1[0] < pitchCompare1[1]){
		pitch1 += colourGlide;
		if(pitch1 >= 360){
			pitch1 = 0;
		}
	}

	if(pitchCompare2[0] > pitchCompare2[1]){
		pitch2 -= colourGlide;
		if(pitch2 <= 0){
			pitch2 = 360;
		}
	} else if (pitchCompare2[0] < pitchCompare2[1]){
		pitch2 += colourGlide;
		if(pitch2 >= 360){
			pitch2 = 0;
		}
	}

	// int bri1 = int(map(pitch1,0,360,0,100));
	// int bri2 = int(map(pitch1,0,360,0,100));
	// int sat1 = int(map(pitch1,0,360,0,100));
	// int sat2 = int(map(pitch1,0,360,0,100));

	int bri1 = 70;
	int bri2 = 70;
	int sat1 = 70;
	int sat2 = 70;	

	//drawArch for first circle
	noStroke();
	fill(pitch1,bri1,sat1,transparency);
	beginShape();
	curveVertex(xStartPos, yStartPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xEndPos,yEndPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape(CLOSE);
	noStroke();
	fill(pitch1,bri1,sat1,transparency);
	beginShape();
	curveVertex(xEndPos, yEndPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xStartPos,yStartPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape();


	noStroke();
	fill(pitch2,bri2,sat2,transparency);
	beginShape();
	curveVertex(xEndPos, yEndPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xStartPos,yStartPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape();
	noStroke();
	fill(pitch2,bri2,sat2,transparency);
	beginShape();
	curveVertex(xStartPos, yStartPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xEndPos,yEndPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape(CLOSE);

		//Draw circles
	fill(pitch1,bri1,sat1);
	ellipse(xStartPos, yStartPos, size, size);

	//End Circle
	fill(pitch2,bri2,sat2);
	ellipse(xEndPos, yEndPos, size, size);


	// if(NEXT1 == true || alpha1 != 0){
	// 	reverb1.drawRings();
	// }
	// if(NEXT2 == true || alpha2 != 0){
	// 	reverb2.drawRings();
	// }

}

class reverbRings{

float xPos, yPos;
int r = 0;
int alpha = 100;

	//Constructor
	reverbRings(float iXPos, float iYPos){
		xPos = iXPos;
		yPos = iYPos;
	}

	public void drawRings(){
	r += 2;
    alpha -= 1;

    if (alpha <= 0) {
        r = 0;
        alpha = 100;
    }

    stroke(0, 0, 0, alpha);
    fill(0, 0, 0, 0);
    beginShape();
    for (int i = 0; i < r; i++) {
      float x = cos(radians(i*360/r))*r;
      float y = sin(radians(i*360/r))*r;
      vertex(x+xPos, y+yPos);
    }
    endShape(CLOSE);
	}

}

public void reverbRings(int xPos, int yPos, int r, int alpha){

}

public void setRange(int MinPitch1, int MaxPitch1, int MinPitch2, int MaxPitch2) {
    minPitch1 = MinPitch1;
    maxPitch1 = MaxPitch1;
    minPitch2 = MinPitch2;
    maxPitch2 = MaxPitch2;
    
  }

public void getPitch(int inPitch1, int inPitch2){

	 if(NEXT1 == true){ pitchCompare1[1] = pitchCompare1[0];
	}
	if(NEXT2 == true){	pitchCompare2[1] = pitchCompare2[0];
	}
	 pitchCompare1[0] = PApplet.parseInt(map(inPitch1,minPitch1,maxPitch1,0,360));
	 pitchCompare2[0] = PApplet.parseInt(map(inPitch2,minPitch2,maxPitch2,0,360));
}

public void getNext(boolean Next1, boolean Next2){
	NEXT1 = Next1;
	NEXT2 = Next2;
}


}
class Singer {

  //Initialise Arrays to store elements for each singer
  int[] pitch = new int[0];
  int[] duration = new int[0];
  int singerNo;
  int z = 0;
  int x = 0;
  int k;
  int retPitch;
  int retDuration;
  float millis;
  //Timer variables
  int last;
  int seconds;
  int[] secondArray = new int[2];
  boolean secondPassed;
  boolean NEXT;

  //Load CSV file
  Table table = loadTable("CSV.csv", "header");
  TableRow row;
  int rowNo = table.getRowCount();

  //Constructor
  Singer(int iSingerNo) {
    singerNo = iSingerNo;
  } 

  //Count the number of elements in the CSV file for each singer
  public void count() {
    for (TableRow row : table.rows ()) {
      if (row.getInt("Singer") == singerNo) {
        pitch = append(pitch, /*2 **/ row.getInt("Pitch"));
        duration = append(duration, /*2 **/ row.getInt("Duration"));
      }
    }
  }

  //Measure time passed and send new values from the arrays
  public void timer() {
    if (z < duration.length - 1) {
      //Initialise counters
      millis = millis() - last;
      seconds = round(millis/1000);

      //Move last value down the array
      secondArray[1] = secondArray[0];
      secondArray[0] = seconds;

      //Determine whether a second has passed
      if (secondArray[0] > secondArray[1]) {
        secondPassed = true;
      } else if (secondArray[0] <= secondArray [1]) {
        secondPassed = false;
      }

      if (seconds == duration[z]) {//If the duration of the note has been reached, send new data
        NEXT = true;
        last = millis();
        z++; // Increase array address
      } else {
        NEXT = false;
      }
    } else {
      println("END OF FILE");
    }
  }

  //Returns the current value under 'Pitch' in the CSV file
  public int getPitch() {
    if (/*z < rowNo/4 && */NEXT == true) {// 4 = number of singers at the moment
      retPitch = pitch[z];
    }
    //     print("\n Singer " + singerNo + " PITCH: ", retPitch);
    return retPitch;
  }

  //Returns the current value under 'Duration' in the CSV file
  public int getDuration() {
    if (/*z < rowNo/4 &&*/ NEXT == true) {
      retDuration = duration[z];
    }
    //      print(" DURATION: ", retDuration);
    return retDuration;
  }

  public boolean getSecondPassed() {
    return secondPassed;
  }

  public void printInfo() {
    if (NEXT == true) {
      println("\n Singer " + singerNo + " PITCH: " + retPitch + " DURATION: " + retDuration);
    }
  }
}

class reverbRings {

  int xPos;
  int yPos;
  int r; //radius
  int alpha;
  boolean reverbGo = false;

  //Constructor
  reverbRings(int iXPos, int iYPos, int iR, int iAlpha) {
    xPos = iXPos;
    yPos = iYPos;
    r = iR;
    alpha = iAlpha;
  }

  public void drawRings(boolean reverb) {

    if (reverb == true) {
      reverbGo = true;
    }

    if (reverbGo == true) {
      r += 2;
      alpha -= 1;

      if (alpha <= 0) {
        r = 0;
        alpha = 100;
        reverbGo = false;
      }
    }

    stroke(0, 0, 0, alpha);
    fill(0, 0, 0, 0);
    beginShape();
    for (int i = 0; i < r; i++) {
      float x = cos(radians(i*360/r))*r;
      float y = sin(radians(i*360/r))*r;
      vertex(x+xPos, y+yPos);
    }
    endShape(CLOSE);
  }
}

class squigleClass {

  float posX;
  float posY;
  int iPoints = 1;
  int points;
  int count = 0;

  float[] xArray;
  float[] yArray;
  float[] newXArray;
  float[] newYArray;
  float xDirection;
  float yDirection;
  float randMove;
  int curve = 20;
  int divide = 16;
  int randomDiameter;
  int lowerD;
  int noteON;

  boolean m;
  boolean n;
  boolean b;

  //Set max and mins
  int minPitch;
  int maxPitch;
  int minDuration;
  int maxDuration;

  //Check whether the number of points received is greater or larger than the last value
  int[] numberOfPoints;

  //Variables to signify which array was last edited
  boolean largerUsed;
  boolean smallerUsed;

  //Constructor
  squigleClass(float iPosX, float iPosY) {
    posX = iPosX;
    posY = iPosY;

    //Initialise arrays
    xArray = new float[iPoints +1];
    yArray = new float[iPoints +1];
    newXArray = new float[iPoints +1];
    newYArray = new float[iPoints +1];
    numberOfPoints = new int[2];

    xDirection = posX; 
    yDirection = posY;
  }

  public void calcShape(int inputPoints, int lvl, int restartX, int restartY) {
    //    println("inputPoints: ", inputPoints);
    points = round(map(inputPoints, minDuration, maxDuration, 10, 70)); //Make the chain longer
    noteON = lvl;
    numberOfPoints[1] = numberOfPoints[0];
    numberOfPoints[0] = points;
    //After ever 100 counts, randomise movement
    if (count == 1) {
      //Each object is given a random direction
      randMove = round(random(0, 3));
      divide = round(random(2, 16));
      curve = round(random(2, 10));
      randomDiameter =  round(random(10, 20));
      lowerD = randomDiameter - 2;
    }

    if (alphaDONE == true) {
      //Restart the starting positions
      xDirection = restartX;
      yDirection = restartY;

      //Clear arrays of previous point locations
      resetArrays();
    }

    //Calculate the direction the 'head' will be moving in
    if (noteON == 1) {
      //Random number to slightly move the hovering circle
      float p = random(lowerD, randomDiameter);
      xDirection += cos(TWO_PI*count/10)*p; 
      yDirection += sin(TWO_PI*count/10)*p;
    } else if (noteON == 0) {

      if (randMove ==0) {
        float p = random(-5, 5);
        //      xDirection += sin(TWO_PI*count/10)*count + p;
        //      yDirection += 2;
        xDirection += cos((TWO_PI/divide)*count/10)*curve; 
        yDirection += sin((TWO_PI/divide)*count/10)*curve;
      } else if (randMove ==1) {
        float p = random(-5, 5);
        //      xDirection += sin(TWO_PI*count/10)*count + p;
        //      yDirection -= 2;  
        xDirection -= cos((TWO_PI/divide)*count/10)*curve; 
        yDirection += sin((TWO_PI/divide)*count/10)*curve;
      } else if (randMove ==2) {
        float p = random(-5, 5);
        //      xDirection += 2;
        //      yDirection += sin(TWO_PI*count/10)*count + p;
        xDirection += cos((TWO_PI/divide)*count/10)*curve; 
        yDirection -= sin((TWO_PI/divide)*count/10)*curve;
      } else if (randMove ==3) {
        float p = random(-5, 5);
        //      xDirection -= 2;
        //      yDirection += sin(TWO_PI*count/10)*count + p;
        xDirection -= cos((TWO_PI/divide)*count/10)*curve; 
        yDirection -= sin((TWO_PI/divide)*count/10)*curve;
      }
    }

    //Determine whether the array needs extending or shrinking
    if (numberOfPoints[0] > numberOfPoints[1]) {
      largerArray();
    } else if (numberOfPoints[0] < numberOfPoints[1]) {
      smallerArray();
    } else {
      if (largerUsed == true) {
        standardLargeArray();
      } else if (smallerUsed == true) {
        standardSmallArray();
      } else {
        standardLargeArray();
      }
    }

    //Restart counter after 10
    if (count == 100) {
      count = 1;
    } else {
      count++;
    }
  }

  //Function that increases the size of the array and stores values
  public void largerArray() {
    //Increase number of points in array

      //If the last array used was the smaller one, copy data to new array
    if (smallerUsed == true) {
      xArray = new float[points +1]; 
      yArray = new float[points +1]; 
      //Copy data from smaller array into new larger ones
      arrayCopy(newXArray, 0, xArray, 0, numberOfPoints[1]); 
      arrayCopy(newYArray, 0, yArray, 0, numberOfPoints[1]);

      //If a load of new points have been added, make them equal to the last point with a value thats not 0
      for (int i=numberOfPoints[1]; i<points; i++) {
        if (numberOfPoints[1]>0) {
          xArray[i] = xArray[(numberOfPoints[1]-1)];
          yArray[i] = yArray[(numberOfPoints[1]-1)];
        } else {
          xArray[i] = xArray[numberOfPoints[1]];
          yArray[i] = yArray[numberOfPoints[1]];
        }
      }
    } else {
      //Create two buffer arrays used to temporarly store data
      float[] bufferXArray = new float[numberOfPoints[1]]; //Size of the previous number of points
      float[] bufferYArray = new float[numberOfPoints[1]]; 

      //Copy the 'newArray' to a 'bufferArray'
      for (int i=0; i<numberOfPoints[1]; i++) {
        bufferXArray[i] = xArray[i]; 
        bufferYArray[i] = yArray[i];
      }

      //Format 'newArray' with less elements
      xArray = new float[points +1]; 
      yArray = new float[points +1]; 

      //Copy old data into the formatted array but with 1 less element
      arrayCopy(bufferXArray, 0, xArray, 0, numberOfPoints[1]); 
      arrayCopy(bufferYArray, 0, yArray, 0, numberOfPoints[1]);

      //If a load of new points have been added, make them equal to the last point with a value thats not 0
      for (int i=numberOfPoints[1]; i<points; i++) {
        if (numberOfPoints[1] > 0) {
          xArray[i] = xArray[(numberOfPoints[1]-1)];
          yArray[i] = yArray[(numberOfPoints[1]-1)];
        } else {
          xArray[i] = xArray[numberOfPoints[1]];
          yArray[i] = yArray[numberOfPoints[1]];
        }
      }
    }

    //Save the previous positions of the 'head' along the array
    for (int i = 0; i<points; i++) {
      xArray[points-i] = xArray[points-(i+1)];
      yArray[points-i] = yArray[points-(i+1)];
    }
    //Calculate new 'Head' position
    xArray[0] = xDirection; 
    yArray[0] = yDirection; 

    //State which array was last used
    largerUsed = true; 
    smallerUsed = false;
  }

  //Function that shrinks the array and stores new values
  public void smallerArray() {
    //If last array used was the larger one copy old data to new array
    if (largerUsed == true) {
      //Create new arrays with new 'points value'
      newXArray = new float[points +1]; 
      newYArray = new float[points +1]; 

      //Fill with almost all data from old array
      arrayCopy(xArray, 0, newXArray, 0, points); 
      arrayCopy(yArray, 0, newYArray, 0, points);
    } else {  
      //Create two buffer arrays used to temporarly store data
      float[] bufferXArray = new float[points+1]; 
      float[] bufferYArray = new float[points+1]; 
      //Copy the 'newArray' to a 'bufferArray'
      for (int i=0; i<points; i++) {
        bufferXArray[i] = newXArray[i]; 
        bufferYArray[i] = newYArray[i];
      }
      //Format 'newArray' with less elements
      newXArray = new float[points +1]; 
      newYArray = new float[points +1]; 

      //Copy old data into the formatted array but with 1 less element
      arrayCopy(bufferXArray, 0, newXArray, 0, points); 
      arrayCopy(bufferYArray, 0, newYArray, 0, points);
    }

    //Save the previous positions of the 'head' along the array
    for (int i = 0; i< points; i++) {
      newXArray[points-i] = newXArray[points-(i+1)]; 
      newYArray[points-i] = newYArray[points-(i+1)];
    }

    //Calculate 'Head' position
    newXArray[0] = xDirection; 
    newYArray[0] = yDirection;

    //State which array was last used
    smallerUsed = true; 
    largerUsed = false;
  }

  //Function that updates the array ones it has grown
  public void standardLargeArray() {
    for (int i = 0; i<points; i++) {
      xArray[points-i] = xArray[points-(i+1)]; 
      yArray[points-i] = yArray[points-(i+1)];
    }
    //Calculate 'Head' position
    xArray[0] = xDirection; 
    yArray[0] = yDirection;
  }

  //Function that updates the array ones it has shrunk
  public void standardSmallArray() {
    for (int i = 0; i<points; i++) {
      newXArray[points-i] = newXArray[points-(i+1)]; 
      newYArray[points-i] = newYArray[points-(i+1)];
    }
    //Calculate 'Head' position
    newXArray[0] = xDirection; 
    newYArray[0] = yDirection;
  }

  //THIS ONES PRETTY SICK BRO with black background
  public void drawShape() {
    int xColour = round(map(xDirection, 0, canX, 0, 360));
    if (colorBright == 1) {
      colorMode(HSB, 360);
    } else if (colorBright == 2) {
      colorMode(HSB, 360, 100, 100, 100);
    }
    //  println("colorBright ", colorBright);
    if (choice == 4) {
      //      map(xDirection, 0, canX, 0, 360);
      //      map(yDirection, 0, canX, 0, 360);
      stroke(/*xDirection*/ xColour, /*yDirection*/ 100, 100);
      strokeWeight(2);
      fill(0, 0, 0, 0);
      beginShape(); 
      if (largerUsed == true) {
        for (int i=0; i<xArray.length; i++) {
          curveVertex(xArray[i], yArray[i]);
        }
      } else if (smallerUsed == true) {
        for (int x=0; x<newXArray.length; x++) {
          curveVertex(newXArray[x], newYArray[x]);
        }
      } else {
        for (int i=0; i<xArray.length; i++) {
          curveVertex(xArray[i], yArray[i]);
        }
      }
      endShape();

      //Fading Rectangles
      colorMode(HSB, 360, 100, 100, 100);
      noStroke();
      fill(BGhue, BGsat, BGbri, 5);
      rect(random((0-canX/4), canX), random((0-canY/4), canY), canX/4, canY/4);
    } else if (choice == 5) {
      //Must define the colorMode once here and again at rectangels to prevent rectagles being black
      if (colorBright == 1) {
        colorMode(HSB, 360);
      } else if (colorBright == 2) {
        colorMode(HSB, 360, 100, 100, 100);
      }
      backCount = 0;
      //  int xColour = round(map(xDirection, 0, canX, 0, 360));
      noStroke();
      //stroke(xColour, xColour, 100); 
      //strokeWeight(2);
      fill(xColour, 100, 100, 50);
      beginShape(); 
      if (largerUsed == true) {
        for (int i=0; i<xArray.length; i++) {
          curveVertex(xArray[i], yArray[i]);
        }
      } else if (smallerUsed == true) {
        for (int x=0; x<newXArray.length; x++) {
          curveVertex(newXArray[x], newYArray[x]);
        }
      } else {
        for (int i=0; i<xArray.length; i++) {
          curveVertex(xArray[i], yArray[i]);
        }
      }
      endShape();

      //Fading Rectangles
      colorMode(HSB, 360, 100, 100, 100);
      noStroke();
      fill(BGhue, BGsat, BGbri, 5);
      rect(random((0-canX/4), canX), random((0-canY/4), canY), canX/4, canY/4);
    }
  }

  public void resetArrays() {
    for (int i=0; i<xArray.length; i++) {
      xArray[i] = xDirection;
      yArray[i] = yDirection;
    }
    for (int i=0; i<newXArray.length; i++) {
      newXArray[i] = xDirection;
      newYArray[i] = yDirection;
    }
  }

  /*These are currently not being used */
  public float getPosX() {
    return xArray[0];
  }

  public float getPosY() {
    return yArray[0];
  }

  public void edgeCheck() {
    if (xDirection <= 0) {
      xDirection = 0;
    } else if (yDirection <= 0) {
      yDirection = 0;
    } else if ( xDirection >= canX)
    {
      xDirection = canX;
    } else if (yDirection >= canY) {
      yDirection = canY;
    }

    //        //Calculate whether the points have 'gone through a wall'
    //     if(xDirection > canX){
    //      xDirection -= canX; 
    //     } else if (xDirection < 0){
    //      xDirection += canX; 
    //     }
    //     
    //     if(yDirection > canY){
    //       yDirection -= canY;
    //     } else if (yDirection < 0){
    //       yDirection += canY;
    //     }
  }

  public void setRange(int MinPitch, int MaxPitch, int MinDuration, int MaxDuration) {
    minPitch = MinPitch;
    maxPitch = MaxPitch;
    minDuration = MinDuration;
    maxDuration = MaxDuration;
  }
}

//Text file reader
class textFileReader {
  String[] text;
  String file; 
  int [][] singerInfo;
  int[] secondArray = new int[2]; // place to compare seconds values
  int x = 0;
  int z = 0;
  int seconds;
  boolean secondPassed;
  boolean NEXT;
  int retPitch;
  int retDuration;

  int maxPitch;
  int maxDuration;
  int minPitch = 10000; //Large values to compare to
  int minDuration = 10000;

  int h = 0;

  int val; //Flag sent by Arduino
  int waitingCount = 0;

  //Constructor
  textFileReader(String iFile) {
    file = iFile;
  }

  public void read() {
    text = loadStrings(file); 
    //    println("text: ", text.length);
    singerInfo = new int[3][text.length]; //1.Start time 2.Frequency 3.Note duration ms
    for (int i=0; i< (text.length/3); i++) {
      for (int j=0; j<3; j++) {
        singerInfo[j][i] = PApplet.parseInt(text[x]);
        x++;
      }
    }
  }


  //Measure time passed and send new values from the arrays
  public void timer(int TAG) {
    if (z < text.length/3 - 1) {
      //      println("Length: ", text.length);
      //      println("Millis: "+millis()+" Next Millis: " + singerInfo[0][z+1] + " SecondPasses: " + secondPassed);
      //Initialise counters
      //      millis = millis() - last;

      seconds = round(timer /*millis()*//1000);

      //Move last value down the array
      secondArray[1] = secondArray[0];
      secondArray[0] = seconds;

      //Determine whether a second has passed
      if (secondArray[0] > secondArray[1]) {
        secondPassed = true;
      } else if (secondArray[0] <= secondArray [1]) {
        secondPassed = false;
      }

      if (timer /*millis()*/ >= singerInfo[0][z+1]) {
        NEXT = true;
        //last = millis();
        z++; // Increase array address
      } else {
        NEXT = false;
      }
    } else {
      println("END OF FILE: ",TAG);
    }

    //sendToArduino(TAG);
  }

  public void sendToArduino(int inTAG) {
    //Send data to arduino when new data is needed
    if (NEXT == true) {

      println("TAG: "+inTAG+" pitch: "+singerInfo[1][z]+" duration: "+singerInfo[2][z]+" state: "+state);
      String tagS = str(inTAG);
      String pitchS = str(singerInfo[1][z]);
      String durationS = str(singerInfo[2][z]);
      String stateS = str(state); //Takes global variable 'state'

      while (val != 1) {
        port.write(""+tagS+","+pitchS+","+durationS+","+stateS);
        //println("Waiting...");
        val = port.read();
        waitingCount++;
        println("waitingCount: ",waitingCount);
        if (waitingCount >=20) {//break out if there is an error
          val = 1;
          waitingCount = 0;
        }
        if (val == 1) {
          break;
        }
      }
      val = port.read();
    }
  }

  public void rangeCalc() { //Calculates the maximum & minimum pitch and duration within the text file
    //Max Pitch
    // println("text.Length",text.length/3); // Divide 3 as file contains ALL the information
    for (int i=0; i<text.length/3; i++) {
      // println("Every Pitch: "+singerInfo[1][i]+"["+i+"]");
      if (singerInfo[1][i] > maxPitch) {
        maxPitch = singerInfo[1][i];
      }
      //Min Pitch
      if (singerInfo[1][i] < minPitch) {
        minPitch = singerInfo[1][i];
      }
      //Max Duration
      if (singerInfo[2][i] > maxDuration) {
        maxDuration = singerInfo[2][i];
      }
      //Min Duration
      if (singerInfo[2][i] < minDuration)
      {
        minDuration = singerInfo[2][i];
      }
    }  
    println("(File) maxPitch: "+ maxPitch + " maxDuration: "+maxDuration+ " minPitch: "+minPitch + " length: "+text.length);
  }

  public int getMinPitch() {
    return minPitch;
  }

  public int getMaxPitch() {
    return maxPitch;
  }

  public int getMinDuration() {
    return minDuration;
  }

  public int getMaxDuration() {
    return maxDuration;
  }

  //Returns the current value under 'Pitch' in the CSV file
  public int getPitch() {    
    if (NEXT == true) {      
      retPitch = singerInfo[1][z];
    }
    return retPitch;
  }

  //Returns the current value under 'Duration' in the CSV file
  public int getDuration() {
    if (NEXT == true) {
      retDuration = singerInfo[2][z];
      //      println("retDuration: "+retDuration+" minDuration: " + minDuration + " maxDuration: "+maxDuration);
    }
    return retDuration;
  }

  public boolean getNext() {
    return NEXT;
  }

  public int getLvl() {
    if (millis() >= (singerInfo[0][z] + singerInfo[2][z])) {
      return 0;
    } else
      return 1;
  }

  public int getNextStartTime() {
    return singerInfo[0][z+1];
  }

  public boolean getSecondPassed() {
    return secondPassed;
  }

  public void printFile(String iPart) {
    String part = iPart;
    for (int i=0; i< (text.length/3); i++) {
      println(" " + part+ " " + singerInfo[0][i] + "  " + singerInfo[1][i] + "  " + singerInfo[2][i]);
    }
    println("x: ", x);
  }
}

//void getTextLength(){
// return text.length; 
//}

//void toArduino() {
//  port.write("<");
//  port.write(singerInfo); 
//  port.write(">");
//}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
