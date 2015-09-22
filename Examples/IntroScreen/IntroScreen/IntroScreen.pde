int canX = 2048;
int canY = 768;

// int canX = 1200;
// int canY = 200;
boolean glow = false;
int timeRunning;
int last;
int minutesLeft = 4; 
int fontSize = 50;
int bulbArmLength;
int loopCounter;

bulbClass bulb1;

PFont f;

void setup() {
  f = createFont("Arial", 16, true);
  size(canX, canY);
  bulb1 = new bulbClass(canX/4, 0);
  frameRate(30);
}

void draw() {
  background(0);
  runBulb();
  timer();
  export();
}

void runBulb() {
  bulb1.swing(bulbArmLength);
  bulb1.glow();
}

void mousePressed() {
  //glow = true;
}

void mouseReleased() {
  //glow = false;
  //bulb1.setArmLength();
}

void export(){
  if(timeRunning < 5000*60 + 5000){
    saveFrame("/Users/Lewis/Desktop/IntroVideo2/sketch-#######.png");
  }
  else{
    println("Done Recording");
  }
}

void timer() {

  timeRunning = (loopCounter/30)*1000;

  // timeRunning = millis() - last;

  int secondsLeft = (60000 - timeRunning)/1000;
  if (secondsLeft < 0) {
    //last = millis(); 
    minutesLeft -= 1;
  }

  int timeRemaining = 300000 - timeRunning; /*millis();*/ /* (minutesLeft*10000)+(secondsLeft*1000) */

  bulbArmLength = int(map(timeRemaining, 0, 300000, 0, canY - 160));
  //bulbArmLength = int(map(timeRemaining, 300000,0, canY, 0));

  int startPos = canX*3/4+100;

  //colorMode(HSB, 360, 100, 100, 100);
  textFont(f, fontSize);
  fill(255, 255, 255, 100);
  if (secondsLeft < 10) {
    text("Time Remaining - "+(minutesLeft) + ":0" + secondsLeft +"", canX/2, canY/2);
  } else {
    text("Time Remaining - "+(minutesLeft) + ":" + secondsLeft +"", canX/2, canY/2);
  }
  loopCounter++;
}

