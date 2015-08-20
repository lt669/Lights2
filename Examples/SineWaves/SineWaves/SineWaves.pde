/*
Code written using example from https://processing.org/examples/sinewave.html
 Edited by Lewis Thresh
 23/07/2015
 */

int canX = 1200;
int canY = 800;

Sine sine1;
Sine sine2;

void setup() {

  size(canX, canY);
  background(-1);
  sine1 = new Sine(75, 250, canX/2 + 25, canY/2 + 25);
  sine2 = new Sine(50, 150, canX/2 + 25, canY/2 - 25);

}

void draw() {
  background(255);
  sine1.calcWave();
  sine1.drawWave();
  sine2.calcWave();
  sine2.drawWave();
  centerEllipse();
   noStroke();
  fill(0);
  rect(canX/4,canY/4,10,10);
  
  stroke(0);
  line(canX/2, canY/2, canX/2 + 25, sine1.getY());
}

void centerEllipse(){
 
 noStroke();
 fill(100);
 ellipse(canX/2, canY/2, 50, 50);
 
 
  
}




