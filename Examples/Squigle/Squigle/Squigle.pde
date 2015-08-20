
int canX = 1200;
int canY = 800;
float check = 0;
int nPoints = 1;
float newX = canX/2;
float newY = canY/2;
int input;
boolean pressed;
float move;

squigleClass sq1;
squigleClass sq2;
squigleClass sq3;
squigleClass sq4;

void setup() {
  // noLoop();
  size(canX, canY);
  background(0);

  sq1 = new squigleClass(newX, newY, 10);
  sq2 = new squigleClass(canX*3/4, canY*3/4, 5);
  sq3 = new squigleClass(canX*3/4, canY/4, 10);
  sq4 = new squigleClass(canX/4, canY*3/4, 30);
}


void draw() {
  pointsCalc(); 
  background(0);

  sq1.calcShape(nPoints);
  sq1.edgeCheck();
  sq1.drawShape();

  sq2.calcShape(nPoints);
  sq2.drawShape();
  sq2.edgeCheck();
  
  sq3.calcShape(nPoints);
  sq3.drawShape();
  sq3.edgeCheck();
  
  sq4.calcShape(nPoints);
  sq4.drawShape();
  sq4.edgeCheck();
}

void mousePressed() {
  check = 1;
  //move = round(random(0,30));
}

void mouseReleased() {
  check = 0;
}

void keyPressed() {
  pressed = true;
}

void keyReleased() {
  pressed = false;
}

void pointsCalc() {

  if (pressed == true) {
    nPoints = Character.digit(key, 10);
    // println("\nnPoints:",nPoints);
  } else if (pressed == false) {
    nPoints = 0;
  } else {
    nPoints = nPoints;
  }
}

//  
//  if (key == 'w') {
//    check = 1;
//  } else if (key == 's') {
//    check = 0;
//  } else if (key == 'i'){
//   nPoints = +1;
//  }

//  print("\n Points:", nPoints);

