import processing.serial.*;
Serial port;

int first = 5;
int second = 7;

int val;
boolean NEXT = false;
int received = 1;
int var;
int[] in = new int[3];
int h;

void setup()
{
  //Mac
  //  port = new Serial(this, "/dev/tty.usbmodem641", 9600); 

  //PC
  port = new Serial(this, "COM4", 9600); 
  port.bufferUntil('\n');

  println("Initial Receive", received);
}

void draw() {

  /*-----------DUMMY PROGRAM-----------*/
  if (NEXT == true) {
//    port.write(-1);//-1 starts data group
//    port.write(5);
//    port.write(-2);//-2 seperates data
//    port.write(7);
//    port.write(-2);
//    port.write(9);
//    port.write(-3);//-3 ends data group and prints
    
    port.write("1,2,3");
    
    val = port.read()-48;
    println(val);
    
  } else if (port.available() > 0) {
    //NOWT
    }
  }

  /*-----------DUMMY PROGRAM-----------*/


  /*-----------DUMMY PROGRAM-----------*/
  //  if (NEXT == true) {
  //    port.write('y');//Tell Arduino we are sending brand new data
  //    while (1==1) { //Keep reading the port untill Arduino asks for data
  //      incoming = port.read();
  //      if (incoming == 'g') {//Break out of loop if Arduino asks for data
  //        break;
  //      }
  //    }
  //  port.write(singerInfo[0][z]);//Send start time
  //  }
  /*-----------DUMMY PROGRAM-----------*/

  //  if (NEXT == true) {
  //    if (received == 1) {
  //      port.write(first);
  //      //received = 0;
  //      println();
  //    } else if (received == -1) {
  //      received = 0;
  //    } else {
  //      println("Received: ", received);
  //    }
  //  }



//void serialEvent(Serial port) {
//  println("EVENT");
//  String myString = port.readStringUntil(124); //the ascii value of the "|" character
//  if (myString != null ) {
//    myString = trim(myString); //remove whitespace around our values
//    int inputs[] = int(split(myString, ','));
//    //now assign your values in processing
//    if (inputs.length == 2) {
//      received = inputs[0];
//      var = inputs[1];
//    }
//  }
//  //  received = port.read(); 
//  //  println("Received Event: ", received);
//  println("Var: ", var);
//}

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

