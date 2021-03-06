//#include <DMXSerial.h>
//
//#include <SoftwareSerial.h>

#include <DmxMaster.h>

int i = 0;
int j = 0;
boolean increase = false;

int startTime;
int frequency;
int duration;
int counter;
boolean firstContact = false;
int incomingInt;
String incomingChar;
int in[3];
int light1[2];
int light2[2];
String charReader[10];
int h;
int count;


void setup() {

  Serial.begin(9600);
  Serial.write(1);//Send value to establish contact

  //LED OUTPUTS
  pinMode(7, OUTPUT);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
}

void loop() {
  /*-----------SERIAL DUMMY PROGRAM-----------*/
  if (Serial.available()) {
     Serial.println("incomingInt: ");

     while (Serial.available() >= 2) {// wait for 3 ints to arrive
       in[0] = Serial.parseInt();
       in[1] = Serial.parseInt();
       //in[2] = Serial.parseInt();
  
       //      Serial.write(in[0]);
       //      Serial.write(in[1]);
       //      Serial.write(in[2]);
       Serial.write(1);
       count = 0;
     }
  
  
   //}
   //Turn all off
   if (count == 0) {
     digitalWrite(7, LOW);
     digitalWrite(2, LOW);
     digitalWrite(3, LOW);
     digitalWrite(4, LOW);
     digitalWrite(5, LOW);
     digitalWrite(6, LOW);
   }
   count++;
  
   //Light appropriate outputs
   digitalWrite(in[0], HIGH);
   //digitalWrite(in[1], HIGH);
   //digitalWrite(in[2], HIGH);
 }
}

  //Serial.read();//Flush buffer

  /*-----------SERIAL DUMMY PROGRAM-----------*/

  /*-----------BRIGHTNESS DUMMY PROGRAM-----------*/
//  while (Serial.available() >= 5) {// wait for 3 ints to arrive (Keep having to change this?)
//    in[0] = Serial.parseInt();
//    in[1] = Serial.parseInt();
//    in[2] = Serial.parseInt();
//
//    Serial.println("in[0]: "+in[0]);
//    Serial.println("in[1]: "+in[1]);
//    Serial.println("in[2]: "+in[2]);
//
//    //      Serial.write(in[0]);
//    //      Serial.write(in[1]);
//    //      Serial.write(in[2]);
//
//    digitalWrite(7, LOW);
//    digitalWrite(2, LOW);
//    digitalWrite(3, LOW);
//    digitalWrite(4, LOW);
//    digitalWrite(5, LOW);
//    digitalWrite(6, LOW);
//
//    if (in[0] == 1) {
//      light1[0] = in[1];
//      light1[1] = in[2];
//    } else if (in[0] == 2) {
//      light2[0] = in[1];
//      light2[1] = in[2];
//    }
//    Serial.write(1);
//  }
//
//
//
//  analogWrite(light1[0], light1[1]);
//  analogWrite(light2[0], light2[1]);


  //Light appropriate outputs
  //  analogWrite(3, in[0]);
  //  analogWrite(5, in[1]);
  //  analogWrite(6, in[2]);

  /*-----------BRIGHTNESS DUMMY PROGRAM-----------*/

  /*-----------DMX DUMMY PROGRAM-----------*/

//  int hTiltL1, vTiltL1, speelL1, redL1, blueL1, greenL1
//  int hTiltL2, vTiltL2, speelL2, redL2, blueL2, greenL2
//  int hTiltL3, vTiltL3, speelL3, redL3, blueL3, greenL3
//  int hTiltL4, vTiltL4, speelL4, redL4, blueL4, greenL4
//  int hTiltL5, vTiltL5, speelL5, redL5, blueL5, greenL5
//  int hTiltL6, vTiltL6, speelL6, redL6, blueL6, greenL6
//  int hTiltL7, vTiltL7, speelL7, redL7, blueL7, greenL7
//  int hTiltL8, vTiltL8, speelL8, redL8, blueL8, greenL8
//
//  int fre1, fre2, fre3, fre4, fre5, fre6;
//  int dur1, dur2, dur3, dur5, dur5, dur6;

   // while (Serial.available() >= 3) {// wait for 3 ints to arrive (Keep having to change this?)
   //   in[0] = Serial.parseInt();
   //   in[1] = Serial.parseInt();
   //   in[2] = Serial.parseInt();

   //   Serial.write(1);
   // }
  
//  //Sort incoming data
//   if (in[0] == 1) {
//      fre1 = in[1];
//      dur1 = in[2];
//    } else if (in[0] == 2) {
//      fre2 = in[1];
//      dur2 = in[2];
//    } else if (in[0] == 2) {
//      fre3 = in[1];
//      dur3 = in[2];
//    } else if (in[0] == 2) {
//      fre4 = in[1];
//      dur4 = in[2];
//    } else if (in[0] == 2) {
//      fre5 = in[1];
//      dur5 = in[2];
//    } else if (in[0] == 2) {
//      fre6 = in[1];
//      dur6 = in[2];
//    } 

   //Light appropriate outputs
 //  DmxMaster.write(7, in[0]);
//   DMXSimple.write(channel2, in[1]);
//   DMXSimple.write(channel3, in[2]);

  /*-----------DMX DUMMY PROGRAM-----------*/


  /*-----------DUMMY PROGRAM-----------*/
  //  if (Serial.available()) {
  //    Serial.print("incomingChar: ");
  //
  //    while (Serial.available() > 0) {
  //      charReader[i] = Serial.read();
  //      i++;
  //      incomingChar = Serial.read(); // If it's single bit it can be used for if statements, maybe?
  //      Serial.println(incomingChar);
  //      if (incomingChar == '-1') {// -1 indicates start of data group
  //        h = 0;
  //        Serial.println("h = 0");
  //      } else if (incomingChar == '-2') {// -2 to seperate the data in the group
  //        h++;
  //        Serial.println("h++");
  //      } else if (incomingChar == '-3') {// -3 to end data group and print data
  //        Serial.println("Print please");//Test
  //        Serial.println(in[0]);
  //        Serial.println(in[1]);
  //        Serial.println(in[2]);
  //      }
  //      else {
  //        //while(Serial.available() > 0){
  //        stoa
  //        in[h] = incomingChar;
  //        //}
  //      }
  //    }
  //  }
  /*-----------DUMMY PROGRAM-----------*/

  //  Serial.write(1);
//}


//void serialEvent()  {
//   while (Serial.available() >= 4) {// wait for 3 ints to arrive
//    in[0] = Serial.parseInt();
//    in[1] = Serial.parseInt();
//    in[2] = Serial.parseInt();
//
//    //      Serial.write(in[0]);
//    //      Serial.write(in[1]);
//    //      Serial.write(in[2]);
//    Serial.write(1);
//  }
//
//  //Light appropriate outputs
//  analogWrite(3, in[0]);
//  analogWrite(5, in[1]);
//  analogWrite(6, in[2]);

//}

//// Serial.println(incoming);
////delay(1000);
//Serial.write(1);
//Serial.print(",");
//Serial.write(incoming);
//Serial.print("|");
//}

//void serialEvent(){
//  Serial.println("EVENT");
//  int input = Serial.read();//Read data in
//  Serial.println(input);//Print data to screen
//  Serial.write('x');//Send 'flag' to processing



//
//  input = Serial.readStringUntil('\n');
//
//  if (input != null) {
//  //trim whitespace and formatting characters (like carriage return)
//  input = trim(input);
//  Serial.println(input);
//
//  while(Serial.available()){
//    char input = Serial.read();
//    if(firstContact == false){
//      if(input == "B"){
//        Serial.flush();
//        firstContact = true;
//        Serial.write("B");
//        Serial.println("Contact");
//      }
//      else {
//        Serial.println(input);
//        Serial.write("A");
//      }
//
//      Serial.readBytesUntil('n',buffer,6);
//      int startTime = atoi(buffer);
//      Serial.println(startTime);


//      startTime = Serial.read();
//
//      frequency = Serial.read();
//
//      duration = Serial.read();
//
//      counter = Serial.read();

//      Serial.println("startTime: "+startTime);
//      Serial.println("frequency: "+frequency);
//  Serial.write('D');

//  Serial.println(counter);
//  }
//}

















