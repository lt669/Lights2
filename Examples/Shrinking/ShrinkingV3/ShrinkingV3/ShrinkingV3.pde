int canX = 700;
int canY = 800;
boolean NEXT;
int count;
Quad Q1;
Quad Q2;

void setup() {
  size(canX, canY);


  //noLoop();
}

void draw() {
  //background(-1);
  if (NEXT == true) { 
    if (count == 0) {
      Q1 = new Quad(canX/4, canY/2, 100);
      Q2 = new Quad(canX*3/4, canY/2, 100);
    }
    count++;

    Q1.doQuad();
    Q2.doQuad();
  }
  //Q1.printArray();
}

void mousePressed() {
  redraw();
  NEXT = true;
}

void mouseReleased() {
  NEXT = false;
  count = 0;
}

