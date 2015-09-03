import processing.serial.*;
Serial port;


int val = 0;
boolean NEXT = false;
int received = 1;
int var;
int[] in = new int[3];
int h;
int count = 0;

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
    if (count == 0) {//Prevent from triggering multiple times per click
      val = 0;
      //Random values
      int first = int(random(2, 8));
      int second = int(random(2, 8));
      int third = int(random(2, 8));

      //Convert to a string
      String firstS = str(first);
      String secondS = str(second);
      String thirdS = str(third);

      println(""+first+","+second+","+third);

      while (val != 1) {
        port.write(""+firstS+", "+secondS+", "+thirdS);
        val = port.read();
        println("Loop Val:", val);
        if (val == 1) {
          println("val: ", val);
          break;
        }
      }
      //val = port.read();
      println("FIRST VAL: ", val);
      count++;
    }
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
  count = 0;
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

