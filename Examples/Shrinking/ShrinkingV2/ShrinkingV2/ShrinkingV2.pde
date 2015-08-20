int canX = 700;
int canY = 800;

Quad Q1;

void setup(){
  size(canX, canY);
  
  Q1 = new Quad(canX/2, canY/2, 100);
  //noLoop();
}

void draw(){
  background(-1);
  Q1.doQuad();
  //Q1.printArray();
  
}

void mousePressed(){
 redraw(); 
}
