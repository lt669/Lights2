#include <DmxSimple.h>

//#include <DmxMaster.h>

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
String charReader[10];
int h;
int count;


void setup() {
  
  Serial.begin(9600);
  Serial.write(1);//Send valuse to establish contact

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
  //    Serial.print("incomingInt: ");

  while (Serial.available() >= 0) {// wait for 3 ints to arrive
    in[0] = Serial.parseInt();
    //in[1] = Serial.parseInt();
    //in[2] = Serial.parseInt();

    //      Serial.write(in[0]);
    //      Serial.write(in[1]);
    //      Serial.write(in[2]);
    Serial.write(1);
    count = 0;
  }


  }
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

  //Serial.read();//Flush buffer

  /*-----------SERIAL DUMMY PROGRAM-----------*/

  /*-----------BRIGHTNESS DUMMY PROGRAM-----------*/
  //  while (Serial.available() >= 3) {// wait for 3 ints to arrive (Keep having to change this?)
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

  /*-----------BRIGHTNESS DUMMY PROGRAM-----------*/

  /*-----------DMX DUMMY PROGRAM-----------*/
  
//  while (Serial.available() >= 3) {// wait for 3 ints to arrive (Keep having to change this?)
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
//  DMXSimple.write(channel1, in[0]);
//  DMXSimple.write(channel2, in[1]);
//  DMXSimple.write(channel3, in[2]);
  
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
}


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

















