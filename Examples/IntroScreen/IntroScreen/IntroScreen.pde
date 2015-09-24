int canX = 2048;
int canY = 768;

 // int canX = 2048;
 // int canY = 600;
boolean glow = false;
int timeRunning;
int totalTimeRunning;
int last;
int minutesLeft = 4; 
int fontSize = 50;
int bulbArmLength;
int loopCounter;
boolean DONE;

bulbClass bulb1;

PFont f;
PFont f2;

void setup() {
  f = createFont("Arial", 128, true);
  f2 = createFont("Arial", 68, true);
  size(canX, canY);
  bulb1 = new bulbClass(canX/4, 0);
  frameRate(25);
  DONE = false;
}

void draw() {
  background(0);
  runBulb();
  timer();
  export();
}

void runBulb() {
  textFont(f2);
  fill(255);
  text("Hearing The Past", canX/2 + 240, canY/4);
  text("St Mary's Abbey Reconstructed", canX/2 + 20, canY/4 + 90);
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
  if(timeRunning < 5000*60 + 1000){
    saveFrame("/Users/Lewis/Developer/FinalVideos/BulbVideo/sketch-#######.png");
  }
  else{
    println("Done Recording");
  }
}

void timer() {

  timeRunning = ((loopCounter/25)*1000)-last;
  totalTimeRunning = (loopCounter/25)*1000;

  // timeRunning = millis() - last;

  int secondsLeft = (60000 - timeRunning)/1000;
  if (secondsLeft < 0 && minutesLeft != 0) {
    //last = millis(); 
    last = totalTimeRunning;
    minutesLeft -= 1;
  }

  int timeRemaining = 300000 - totalTimeRunning; /*millis();*/ /* (minutesLeft*10000)+(secondsLeft*1000) */

  bulbArmLength = int(map(timeRemaining, 0, 300000, 0, canY - 160));
  if(bulbArmLength <= 0){
    bulbArmLength = 0;
  }
  //bulbArmLength = int(map(timeRemaining, 300000,0, canY, 0));

  int startPos = canX*3/4+100;

  //colorMode(HSB, 360, 100, 100, 100);
  textFont(f, fontSize);
  fill(255, 255, 255, 100);
  if(secondsLeft <= 0 && minutesLeft <= 0 && totalTimeRunning >= 300000){
    textFont(f2);
    fill(255);
    text("Ready To Begin", canX/2+ 270, canY/2 + 50);
    DONE = true;
  } else {
  if (secondsLeft < 10) {
    textFont(f);
    fill(255);
    // text("Time Remaining - "+(minutesLeft) + ":0" + secondsLeft +"", canX/2, canY/2 + 80);
    text(""+(minutesLeft) + ":0" + secondsLeft +"", canX*3/4 - 140, canY/2 + 80);
  } else {
    textFont(f);
    fill(255);
    // text("Time Remaining - "+(minutesLeft) + ":" + secondsLeft +"", canX/2, canY/2 + 80);
    text(""+(minutesLeft) + ":" + secondsLeft +"", canX*3/4 - 140, canY/2 + 80);
  }
}
  loopCounter++;
}

