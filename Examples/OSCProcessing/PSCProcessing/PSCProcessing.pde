import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int firstValue;
int secondValue;
int thirdValue;

void setup() {
  colorMode(HSB, 360, 100, 100, 100);
  size(400, 400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);

  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
}

void draw() {
  background(-1);

  thirdValue = firstValue + secondValue;
  
  drawRect(firstValue, 100, 200, 50, 100);
  drawRect(secondValue, 300, 200, 50, 100);


  drawRect(firstValue, 200, 300, 100, 50);
  drawRect(secondValue, 200, 300, 100, 50);
  
  drawRect(thirdValue, 200, 100, 50, 100);
}

void drawRect(int col, int xPos, int yPos, int size, int t) {

  float recColor = map(col, 0, 127, 0, 360);
  rectMode(CENTER);
  noStroke();
  fill(recColor, 50, 50, t);
  rect(xPos, yPos, size, size);
}


void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/second")==true) {
    secondValue = theOscMessage.get(0).intValue();
  }

  if (theOscMessage.checkAddrPattern("/first")==true) {
    if (theOscMessage.checkTypetag("i")) {

      firstValue = theOscMessage.get(0).intValue(); 
      println(" values: "+firstValue);
      return;
    }
  }
}

