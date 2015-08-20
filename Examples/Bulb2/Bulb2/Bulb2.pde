int canX = 1600;
int canY = 600;
boolean glow = false;

bulbClass bulb1;
bulbClass bulb2;
bulbClass bulb3;

void setup() {
  size(canX, canY);
  bulb1 = new bulbClass(canX/4, 0);
  bulb2 = new bulbClass(canX*2/4, 0);
  bulb3 = new bulbClass(canX*3/4, 0);
}

void draw() {
  background(0);

  //  if (glow == false) {
  //    runBulb();   
  //    fill(0,0,0,230);
  //    rect(0,0,canX,canY);
  //  } 
  // 
  //  if (glow == true) {
  //    runBulb();
  //    fill(255,255,255,100);
  //    rect(0,0,canX,canY);
  //  }

  runBulb();
}

void mousePressed() {
  glow = true;
  println("PRESSED");
}

void mouseReleased() {
  glow = false;
  println("RELEASED");
  bulb1.setArmLength();
  bulb2.setArmLength();
  bulb3.setArmLength();
}


void runBulb() {

  bulb1.swing(10);
  bulb1.glow();
  bulb2.swing(200);
  bulb2.glow();
  bulb3.swing(300);
  bulb3.glow();
}

