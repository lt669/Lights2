import processing.serial.*;
Serial port;
float brightness = 0;
int i = 0;

void setup()
{
 //size (500, 500);
 port = new Serial(this, "/dev/tty.usbmodem411", 9600); 
 port.bufferUntil('\n');
}

void draw(){
  for (i = 0; i < 2; i++){
   port.clear();
   port.write(i); 
   delay(500);
   print("",i);
  }
}


//Look for serial event
//void serialEvent (Serial port){
// brightness = float(port.readStrginUntil('\n'); 
//}
