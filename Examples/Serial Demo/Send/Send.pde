import processing.serial.*;
Serial port;

int first = 5;
int second = 7;

int val;
boolean NEXT = false;

void setup()
{
  //size (500, 500);
  port = new Serial(this, "/dev/tty.usbmodem641", 9600); 
  port.bufferUntil('\n');
}

void draw() {
 // int val = port.read();

  //Establish contact
  if (NEXT == true) {
    port.write(first);
    //val = char(port.read());
  }
}

void mousePressed() {
  NEXT = true;
  println("Pressed");
}
void mouseReleased() {
  NEXT = false;
}

//void establishContact() {
//  while (Serial.available () <= 0) {
//    Serial.println("B");   // send a capital A
//  }
//}

//void serialEvent (Serial port) {
//  sensorReading = int(port.readStringUntil('\n'));
////  if (sensorReading != null) {
////    sensorReading=trim(sensorReading);
////  }
//
//  println("Arduino: ", sensorReading);
//}

