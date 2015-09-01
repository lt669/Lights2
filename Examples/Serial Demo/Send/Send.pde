import processing.serial.*;
Serial port;
float brightness = 0;
int i = 0;
int sensorReading;

void setup()
{
  //size (500, 500);
  port = new Serial(this, "/dev/tty.usbmodem641", 9600); 
  port.bufferUntil('\n');
}

void draw() {

  port.write(mouseX);
  println("Processing: ", mouseX);
  
//  sensorReading = port.read();
//  println("Arduino: ", sensorReading);
  
  //  for (i = 0; i < 2; i++){
  //   port.clear();
  //   port.write(i); 
  //   delay(500);
  //   print("",i);
  //  }
}

void serialEvent (Serial port) {
  sensorReading = int(port.readStringUntil('\n'));
//  if (sensorReading != null) {
//    sensorReading=trim(sensorReading);
//  }

  println("Arduino: ", sensorReading);
}



//Look for serial event
//void serialEvent (Serial port){
// brightness = float(port.readStrginUntil('\n'); 
//}

