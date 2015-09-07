import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import org.puredata.processing.PureData; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 
import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Main extends PApplet {





Serial port;

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

//Mac
int canX = 800;
int canY = 400;

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

int[] comp = new int[2];

int state; //What the Arduino should run


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

//Singer s1;
//Singer s2;
//Singer s3;
//Singer s4;

textFileReader PART1;
textFileReader PART2;
textFileReader PART3;
textFileReader PART4;
textFileReader PART5;
textFileReader PART6;

PureData pd;

PGraphics Circles;
PGraphics Squigles;

int alpha;
boolean alphaDONE;
boolean just;
float graphicChooser;
boolean fadedDONE;

public void setup() {

  //Initialise Port to send serial data to arduino
  // port = new Serial(this, "/dev/tty.usbmodem441", 9600); 
  // port.bufferUntil('\n');

  //Create PGraphics
  Circles = createGraphics(canX, canY);
  //Squigles = createGraphics(squigleCanX, squigleCanY);

  minim = new Minim(this);
  //PC
  //  player = minim.loadFile("C:/Users/lt669/Desktop/music/music(verb).mp3");
  //  player.play();

  //Mac
  player = minim.loadFile("/Users/Lewis/Desktop/music(verb).mp3");
  player.play();



  //  file = new SoundFile(this, "C:/Users/lt669/Desktop/music/music(verb).mp3");
  //  file.play();

  //Setup PD patch
  //  pd = new PureData(this, 44100, 0, 2); //6 outputs
  //  //  pd.openPatch("/Users/Lewis/Developer/Lights_Project/Lights/Main/Main/patch.pd");  
  //  pd.openPatch("patch.pd");
  //  pd.start();



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

  //Send start bang to PD
  // pd.sendFloat("bang",startBang);

  size(canX, canY);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);
}

public void draw() {
  colorMode(HSB, 360, 100, 100, 100);

  if (alphaDONE == true) {
    background(BGhue, BGsat, BGbri);
  }

  if (choice < 4) {
    //Fades out parts of the screen
    noStroke();
    fill(BGhue, BGsat, BGbri, 10);
    rect(random((0-canX/4), canX), random((0-canY/4), canY), canX/4, canY/4);
  } else if (choice == 4 || choice == 5) {
    //    noStroke();
    //    fill(BGhue, BGsat, BGbri, 5);
    //    rect(0, 0, canX, canY);
  } else {
    background(BGhue, BGsat, BGbri);
  }

  PART1.timer(/*'A'*/);
//  PART2.timer();
//  PART3.timer();
//  PART4.timer();
//  PART5.timer();
//  PART6.timer();

  graphicChoice();
  runCircleClass();
  runSquigleClass();
  //writeToArduino();

  //runRectangles();



  //  if (check == 1) {
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
      graphicChooser += 1 /* round(random(1, 7))*/;
      if (graphicChooser > 7) {
        graphicChooser = 1;
      }
    }

    if (alphaDONE == true) {
      alpha -= 1;
    }

    if (alpha < 0) {
      fadedDONE = true;
      alphaDONE = false;
      alpha = -2;
    }

    //    println("just: ", just);
    //    println("Alpha: ", alpha);
    //    println("FadedDONE: ",fadedDONE);

    //println("Choice: "+choice+" Select: "+select+" BGbri: "+BGbri);

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

  //println("graphicChooser: "+graphicChooser+" choice: "+choice+ " select: "+select);

  //Run PD function
  //PD();
}

public void mousePressed() {
  just = true;
  check = 1;
  redraw();
  //port.write('A');
  //  pd.sendFloat("stopBang",stopBang);
}

public void mouseReleased() {
  check = 0;
}

public void graphicChoice() {
  if (graphicChooser == 1) {
    choice = 1;
    select = 5;
  } else if (graphicChooser == 2) {
    choice = 2;
    select = 3;
  } else if (graphicChooser == 3) {
    choice = 3;
    select = 5;
  } else if (graphicChooser == 4) {
    choice = 4;
    select = 5;
  } else if (graphicChooser == 5) {
    choice = 4;
    select = 4;
  } else if (graphicChooser == 6) {
    choice = 5;
    select = 5;
  } else if (graphicChooser == 7) {
    choice = 5;
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

public void keyPressed() {

  select = Character.digit(key, 10);
  state = select;
  println("Select: ", select);
  if (select == 0) {
    fadedDONE = false;
  }
  //  if (select == 1) {
  //    choice++;
  //  } else if (select == 2) {
  //    choice--;
  //  } else if (select == 3) { //Black BG, flat colours
  //    BGhue = 0;
  //    BGsat = 0;
  //    BGbri = 0;
  //    colorBright = 1;
  //  } else if (select == 4) { //Black BG, bright colours
  //    BGhue = 0;
  //    BGsat = 0;
  //    BGbri = 0;
  //    colorBright = 2;
  //  } else if (select == 5) { //White BG, flat colours
  //    BGhue = 0;
  //    BGsat = 0;
  //    BGbri = 100;
  //    colorBright = 1;
  //  } else if (select == 6) { //White BG, bright colours
  //    BGhue = 0;
  //    BGsat = 0;
  //    BGbri = 100;
  //    colorBright = 2;
  //  }
  pressed = true;
  //  println("Select", select);
  //  println("Choice: ", choice);
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

public void PD() {

  pd.sendFloat("frequency1", (float)PART1.getPitch());
  pd.sendFloat("lvl1", PART1.getLvl());

  pd.sendFloat("frequency2", (float)PART2.getPitch());
  pd.sendFloat("lvl2", PART2.getLvl());

  pd.sendFloat("frequency3", (float)PART3.getPitch());
  pd.sendFloat("lvl3", PART3.getLvl());

  pd.sendFloat("frequency4", (float)PART4.getPitch());
  pd.sendFloat("lvl4", PART4.getLvl());

  pd.sendFloat("frequency5", (float)PART5.getPitch());
  pd.sendFloat("lvl5", PART5.getLvl());

  pd.sendFloat("frequency6", (float)PART6.getPitch());
  pd.sendFloat("lvl6", PART6.getLvl());
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
  int[] secondArray = new int[2]; // place to compair seconds values
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
    float currentTime = millis() - last;

    //Alter circle size
    if (size >= maxSize && DONE != true) { //Once circle has reached maxSize, DONE
      DONE = true;
      //      print("\n DONE");
    } else if (DONE != true && currentTime >= increaseTime) { //If its maximum size is not reached, increase size
      size++;
      last = millis();
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
      strokeWeight(1);
      stroke(bright + colorFlux, Saturation, Brightness, 100 - Brightness);
      fill(0, 0, BGbri, Saturation); //Setting last value to 0 makes the circles centres transparent 
      ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);
    }

    //Send to Arduino
    if(NEXT == true && state == 2){ //State '2' runs 'sameFunction' in Arduino
     //Send colour data to Arduino
    int lightColour = Color.HSBtoRGB(bright, sizeBri,Brightness);

    println("Colour: ",lightColour);

    //Convert to a string
    String lightColourS = str(lightColour);

      // while(val != 1){
      // port.write(""+TAG+","+lightColourS;
      // val = port.read();
      // if(val == 1){
      //   break;
      // }
      // }
      // val = port.read();
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
    bright = round(map(BRIGHT, minPitch, maxPitch, 0, 360)); 
    Saturation = round(map(BRIGHT, minPitch, maxPitch, 0, 100));
    Brightness = round(map(BRIGHT, minPitch, maxPitch, 0, 70));
  }

  public void setSecondPassed(boolean second) {
    secondPassed = second;
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
  public void timer(/*int TAG*/) {
    if (z < text.length - 1) {
      //      println("Length: ", text.length);
      //      println("Millis: "+millis()+" Next Millis: " + singerInfo[0][z+1] + " SecondPasses: " + secondPassed);
      //Initialise counters
      //      millis = millis() - last;

      seconds = round(millis()/1000);

      //Move last value down the array
      secondArray[1] = secondArray[0];
      secondArray[0] = seconds;

      //Determine whether a second has passed
      if (secondArray[0] > secondArray[1]) {
        secondPassed = true;
      } else if (secondArray[0] <= secondArray [1]) {
        secondPassed = false;
      }

      if (millis() >= singerInfo[0][z+1]) {
        NEXT = true;
        //last = millis();
        z++; // Increase array address
      } else {
        NEXT = false;
      }
    } else {
      println("END OF FILE");
    }
    
    //Send data to arduino when new data is needed
    if(NEXT == true && state == 1){
      String pitchS = str(singerInfo[1][i]);
      String durationS = str(singerInfo[2][i]);

      while(val != 1){
      port.write(""+TAG+","+pitchS+","+durationS);
      val = port.read();
      if(val == 1){
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
