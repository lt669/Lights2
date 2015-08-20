int canX = 600;
int canY = 400;
//color col;
void setup() {

  size(canX, canY);
  background(-1);
}

void draw() {

  // drawRec(canX/4,canY/4, 50, color(194,59,34));
  // drawRec(canX/4,canY*3/4, 50, color(255,179,71));
  // drawRec(canX*3/4,canY/4, 50, color(174,198,207));
  // drawRec(canX*3/4,canY*3/4, 50, color(119,158,203));


  //colorMode(RGB,255,255,255);
  //fill(30,144,255);
  //rect(0,0,200,200);
  //
  //
  //colorMode(HSB,360,100,100);
  //fill(210,50,50);
  //rect(200,0,200,200);
  
  
  fill(100);
  beginShape();
  curveVertex(canX/4, canY/4);
  curveVertex(canX*3/4, canY/4);
  curveVertex(canX*3/4, canY*3/4);
  curveVertex(canX/4, canY*3/4);
  curveVertex(canX/4, canY/4);
  endShape();
}



void drawRec(int posX, int posY, int size, color col) {
  stroke(0);
  fill(col);
  rect(posX, posY, size, size);
}

void drawMultiRec(int posX, int posY, int size, color col) {
  stroke(0);
  fill(col);
  rect(posX, posY, size, size);
}

