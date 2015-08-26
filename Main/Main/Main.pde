import org.puredata.processing.PureData;
import ddf.minim.*;
import ddf.minim.analysis.*;

//Actually want to merge with PGraphics

//import processing.sound.*;
//SoundFile file;

//Playing Audio File
Minim minim;
AudioPlayer player;

//Shared Variables

//Office Screen
//int canX = 1650;
//int canY = 600;

//Mac
int canX = 1600;
int canY = 900;

int squigleCanX = canX;
int squigleCanY = canY;

boolean first, second;
boolean backGroundChange;
int BGhue = 0;
int BGsat = 0;
int BGbri = 100;
int colorBright; //graphics brightness variable
int select; //Background colour changer and other variables)

//Cicles Variables
Table table;
int dur = 0;
int pit = 0;
PImage img;
char circleKey;
char squigleKey;
int choice = 0;
//char choice;
int circles1X;
int circles1Y;
int circles2X;
int circles2Y;
int circles3X;
int circles3Y;

//Squigle Variables
float check = 0;
char nPoints;
//int nPoints = 1;
float newX = canX/2;
float newY = canY/2;
int input;
boolean pressed;
float move;

int canInc = 25;
int canOriginX;
int canOriginY;

int squigles1X, squigles1Y;
int squigles2X, squigles2Y;
int squigles3X, squigles3Y;
int squigles4X, squigles4Y;

//PD variables
float startBang = 1.0;
float stopBang = 1.0;

int x =0;

int moveCanvas;

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
PGraphics Circles1;
PGraphics Circles2;
PGraphics Circles3;
PGraphics Squigles;
PGraphics Squigles1;
PGraphics Squigles2;
PGraphics Squigles3;


void setup() {

  //Create PGraphics
  Circles = createGraphics(canX, canY);
  Circles1 = createGraphics(canX, canY);
  Circles2 = createGraphics(canX, canY);
  Circles3 = createGraphics(canX, canY);
  Squigles = createGraphics(squigleCanX, squigleCanY);
  Squigles1 = createGraphics(canX, canY);
  Squigles2 = createGraphics(canX, canY);
  Squigles3 = createGraphics(canX, canY);

  minim = new Minim(this);
  //PC
  //  player = minim.loadFile("C:/Users/lt669/Desktop/music/music(1).mp3");
  //  player.play();

  player = minim.loadFile("/Users/Lewis/Desktop/music(verb).mp3");
  player.play();


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

  //Circle Objects
  singer1 = new Cir(canX/4, canY/4, 0, 0);
  singer2 = new Cir(canX/2, canY/4, 0, 0);
  singer3 = new Cir(canX*3/4, canY/4, 0, 0);
  singer4 = new Cir(canX/4, canY*3/4, 0, 0);
  singer5 = new Cir(canX/2, canY*3/4, 0, 0);
  singer6 = new Cir(canX*3/4, canY*3/4, 0, 0);

  //Squigle Objects
  sq1 = new squigleClass(newX, newY);
  sq2 = new squigleClass(canX*3/4, canY*3/4);
  sq3 = new squigleClass(canX*3/4, canY/4);
  sq4 = new squigleClass(canX/4, canY*3/4);
  sq5 = new squigleClass(canX*3/4, canY/4);
  sq6 = new squigleClass(canX/4, canY*3/4);

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
  //pd.sendFloat("bang", startBang);



  size(canX, canY, OPENGL);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);
}

void draw() {
  colorMode(HSB, 360, 100, 100);
  background(BGhue, BGsat, BGbri);
  //  if (backCount == 0) {
  //    colorMode(HSB, 360, 100, 100);
  //    background(360);
  //    // println("BG: ", BGCol);
  //  }
  //  backCount++;

  //  if (pressed == true) {
  //    background(BGhue, BGsat, BGbri);
  //  }
  //
  //  if (choice < 4 || choice == 6) {
  //    //Fades out parts of the screen
  //    noStroke();
  //    fill(BGhue, BGsat, BGbri, 10);
  //    rect(random((0-canX/4), canX), random((0-canY/4), canY), canX/4, canY/4);
  //  } else if (choice == 7 || choice == 8) {
  //    noStroke();
  //    fill(BGhue, BGsat, BGbri, 5);
  //    rect(0, 0, canX, canY);
  //  } else {
  //    background(BGhue, BGsat, BGbri);
  //  }

  PART1.timer();
  PART2.timer();
  PART3.timer();
  PART4.timer();
  PART5.timer();
  PART6.timer();

  //Draw all Circles  canvas' onto a main Circle canvas
  //  Circles.beginDraw();
  //  Circles.colorMode(HSB, 360, 100, 100);
  //  Circles.background(BGhue, BGsat, BGbri);
  //  Circles.endDraw();
  //  image(Circles, 0, 0);




  moveCanvas();
  if (choice < 4) {
    runCircleClass();
  }
  if (choice > 3) {
    runSquigleClass();
  }

  //  Circles.beginDraw();
  //  
  //  Circles.colorMode(HSB,360,100,100);
  //  Circles.noStroke();
  //  Circles.fill(BGhue, BGsat, BGbri, 10);
  //  Circles.rect(random((0-canX/4), canX), random((0-canY/4), canY), canX/4, canY/4);
  //  runCircleClass();
  //  Circles.endDraw();

  //image(Circles, 0, 0);

  //Depending on which key is pressed, select an object
  //  Circles.beginDraw();
  //  background(-1);
  //  runCircleClass();
  //  Circles.endDraw();
  //
  //  Squigles.beginDraw();
  //  runSquigleClass();
  //  //  fill(255);
  //  //  rect(0,0,canX/2,canY/2);
  //  Squigles.endDraw();

  //  if (choice<4) {
  //    image(Circles, 0, x);
  //    x++;
  //  } else {
  //    image(Squigles, canX/2, canY/2);
  //  }
  //Run PD function
  // PD();
}

void mousePressed() {
  check = 1;
  redraw();
  //  pd.sendFloat("stopBang",stopBang);
}

void mouseReleased() {
  check = 0;
}

void keyPressed() {
  println("choice: ", choice);
  select = Character.digit(key, 10);
  backGroundChange = true;
  if (select == 1) {
    choice++;
  } else if (select == 2) {
    choice--;
  } else if (select == 3) { //Black BG, flat colours
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
  pressed = true;
  //  println("Select", select);
  //  println("Choice: ", choice);
}

void keyReleased() {
  pressed = false;
  backGroundChange = false;
}

void runCircleClass() {

  // background(-1);

  singer1.setBright(PART1.getPitch());
  singer1.setSize(PART1.getDuration());
  singer1.setSecondPassed(PART1.getSecondPassed());
  singer1.setNext(PART1.getNext());
  singer1.drawCir();

  singer2.setBright(PART2.getPitch());
  singer2.setSize(PART2.getDuration());
  singer2.setSecondPassed(PART2.getSecondPassed());
  singer2.setNext(PART2.getNext());
  singer2.drawCir();

  singer3.setBright(PART3.getPitch());
  singer3.setSize(PART3.getDuration());
  singer3.setSecondPassed(PART3.getSecondPassed());
  singer3.setNext(PART3.getNext());
  singer3.drawCir();

  singer4.setBright(PART4.getPitch());
  singer4.setSize(PART4.getDuration());
  singer4.setSecondPassed(PART4.getSecondPassed());
  singer4.setNext(PART4.getNext());
  singer4.drawCir();

  singer5.setBright(PART5.getPitch());
  singer5.setSize(PART5.getDuration());
  singer5.setSecondPassed(PART5.getSecondPassed());
  singer5.setNext(PART5.getNext());
  singer5.drawCir();

  singer6.setBright(PART6.getPitch());
  singer6.setSize(PART6.getDuration());
  singer6.setSecondPassed(PART6.getSecondPassed());
  singer6.setNext(PART6.getNext());
  singer6.drawCir();

  //  float imgX = random(-5, 5);
  //  float imgY = random(-5, 5);
}

void runSquigleClass() {

  sq1.calcShape(PART1.getDuration(), PART1.getLvl());
  sq1.edgeCheck();
  sq1.drawShape();

  sq2.calcShape(PART2.getDuration(), PART2.getLvl());
  sq2.drawShape();
  sq2.edgeCheck();

  sq3.calcShape(PART3.getDuration(), PART3.getLvl());
  sq3.drawShape();
  sq3.edgeCheck();

  sq4.calcShape(PART4.getDuration(), PART4.getLvl());
  sq4.drawShape();
  sq4.edgeCheck();

  sq5.calcShape(PART5.getDuration(), PART5.getLvl());
  sq5.drawShape();
  sq5.edgeCheck();

  sq6.calcShape(PART6.getDuration(), PART6.getLvl());
  sq6.drawShape();
  sq6.edgeCheck();
}

void moveCanvas() {
  //Initialise canvas locations
  circles1X = circles1X;
  circles1Y = circles1Y;
  circles2X = circles1X;
  circles2Y = circles1Y + canY;
  circles3X = circles1X;
  circles3Y = circles1Y + 2*canY;

  squigles1X = circles1X - canX;
  squigles1Y = circles1Y;
  squigles2X = squigles1X;
  squigles2Y = squigles1Y + canY;
  squigles3X = squigles1X;
  squigles3Y = squigles1Y + 2*canY;
  squigles4X = squigles4X;
  squigles4Y = squigles4Y + 3*canY;

  if (choice == 1) {
    println("circles1Y: ", circles1Y);
    moveYCoordinates(circles1Y);
    moveXCoordinates(circles1X);
  } else if (choice == 2) {
    println("circles2Y: ", circles2Y);
    moveYCoordinates(circles2Y);
    moveXCoordinates(circles2X);
  } else if (choice == 3) {
    println("circles3Y: ", circles3Y);
    moveYCoordinates(circles3Y);
    moveXCoordinates(circles3X);
  } else if (choice == 4) {
    moveYCoordinates(squigles1Y);
    moveXCoordinates(squigles1X);
  } else if (choice == 5) {
    moveYCoordinates(squigles2Y);
    moveXCoordinates(squigles2X);
  } else if (choice == 6) {
    moveYCoordinates(squigles3Y);
    moveXCoordinates(squigles3X);
  }
}

void moveYCoordinates(int type) {
  if (type < 0) {
    circles1Y += canInc;
  } else if (type > 0) {
    circles1Y -= canInc;
  } else {
  }
}

void moveXCoordinates(int type) {
  if (type < 0) {
    circles1X += canInc;
  } else if (type > 0) {
    circles1X -= canInc;
  } else {
  }
}

void PD() {

  pd.sendFloat("frequency1", (float)PART1.getPitch());
  pd.sendFloat("lvl1", PART1.getLvl());

  //  pd.sendFloat("frequency2", (float)PART2.getPitch());
  //  pd.sendFloat("lvl2", PART2.getLvl());
  //
  //  pd.sendFloat("frequency3", (float)PART3.getPitch());
  //  pd.sendFloat("lvl3", PART3.getLvl());
  //
  //  pd.sendFloat("frequency4", (float)PART4.getPitch());
  //  pd.sendFloat("lvl4", PART4.getLvl());
  //
  //  pd.sendFloat("frequency5", (float)PART5.getPitch());
  //  pd.sendFloat("lvl5", PART5.getLvl());
  //
  pd.sendFloat("frequency6", (float)PART6.getPitch());
  pd.sendFloat("lvl6", PART6.getLvl());
}

