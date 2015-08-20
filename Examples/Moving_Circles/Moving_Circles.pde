import processing.serial.*;
Serial port;

int i = 0;
int j = 0;
int k = 0;
int a = 0;

int canX = 700;
int canY = 700;

int x;
int y;
int newX;
int newY;

int contact;


//Create number of objects bassed on the Circle class

Circle ball1;
Circle ball2;
Circle ball3;

void setup() {
  port = new Serial(this, "/dev/tty.usbmodem411", 9600);
  port.bufferUntil('\n');
  
  size(canX, canY);
  
  ball1 = new Circle(100, 100, 10,6 , 50, 500);
  
  //establishContact();
}

void draw() {
  background(102);
  ball1.move();
  ball1.display();
  ball1.collideDrift(x,y);
}

class Circle{
 // Local Variables to this class
  int xLen;
  int yLen;
  int moveX;
  int moveY;
  int x;
  int y;
  int b = 0;
  int c = 0;
  int x1;
  int x2;
  int y1;
  int y2;

  
  //Constructor
  Circle(int initXLen, int initYLen, int initMoveY, int initMoveX, int initX, int initY){
   xLen = initXLen;
   yLen = initYLen;
   moveX = initMoveX;
   moveY = initMoveY;
   x = initX;
   y = initY; 
  }
  
  void display() {
    stroke(255);
    fill(x, y, x);
    ellipse(x, y, xLen, yLen); 
  }
  
  void move(){
      
    if (x <= 0) {
      b = 1;
    } else if (x >= canX) {
      b = 0;
    }
    
    if (y <= 0) {
      c = 1;
    } else if (y >= canY) {
      c = 0;
    }
    
    if (b == 1) {
      x = x + moveX;
    } else if (b == 0) {
      x = x - moveX;
    }
    
     if (c == 1) {
      y = y + moveY;
    } else if (c == 0) {
      y = y - moveY;
    }    
    
    //CIRCLE CIRCUMFRENCE
//    edgeXLeft = x - xLen;
//    edgeXRight = x + xLen;
//    edgeYTop = y - yLen;
//    edgeYBot = y + yLen;
    
  }
  
//void establishContact() {
//  while (Serial.available() <= 0) {
//    Serial.print('A');   // send a capital A
//    delay(300);
//  }
//}
  
  void collideDrift(int x, int y){
    
    Serial.write(x);
    delay(10);
    Serial.write(y);
    
  }
  
  void collideAbs(){
    int del = 0;
// if (x <= 0 || x >= canX || y == 0 || y == canY){
//  print("FUCK");
//  port.write("0");
// } 

  if (y <= 0 ){
   port.write(0); 
   delay(del);
  }
  else if (y >= canY){
   port.write(1);
   delay(del); 
  }
  else if (x <= 0){
   port.write(2);
   delay(del); 
  }
  else if (x >= canX){
   port.write(3); 
   delay(del);
  }
  else{
   port.write(4); 
  }

}
  
  void collision() {
  
   x1 = x - moveX;
   x2 = x + moveX;
   y1 = y - moveY;
   y2 = y + moveY;
  
  //Collision range
 if (abs(ball1.y - ball2.y) <= ball1.moveY){
  c = 0;
 }
 // Finish this bit
} 
  
}

//class colVal {
//  int edgeXLeft;
//  int edgeXRight;
//  int edgeYTop;
//  int edgeYBot;
//  
//  colCal(int edgeXLeft, int edgeXRight, int edgeYTop, int edgeYBot){
//    this.edgeXLeft = edgeXLeft;
//    this.edgeXRight = edgeXRight;
//    this.edgeYTop = edgeYTop;
//    this. edgeYBot = edgeYBot;
//  }
//}




//void glowRecMouse() {
//
//  stroke(255);
//  fill(mouseX/2, mouseY/2, mouseX/2);
//  ellipse(mouseX, mouseY, 100, 100);
//}
//
//void glowRec() {
//
//  stroke(255);
//  fill(i, j, k);
//  rect(100, 100, 250, 100); 
//
//
//  if (i == 255) {
//    a = 1;
//  } else if (i == 0) {
//    a = 0;
//  } else {
//    // Fuck all
//  }
//
//  if (a == 1 ) {
//    i--;
//    j--;
//    k--;
//  }
//
//  if (a == 0) {
//    i = i + 5;
//    j = j + 3;
//    k = k = 1;
//  }
//}

