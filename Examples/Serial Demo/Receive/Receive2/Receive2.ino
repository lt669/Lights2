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
int h;

void setup() {
  Serial.begin(9600);
  Serial.write(1);//Send valuse to establish contact
}

void loop() {

  /*-----------DUMMY PROGRAM-----------*/
  if (Serial.available()) {
    Serial.print("incomingInt: ");

    while (Serial.available() > 0) {
      incomingInt = Serial.read() - 48;
      // incomingChar = String(Serial.read());
      Serial.println(incomingInt);

      if (incomingInt == -1) {// -1 indicates start of data group
        h = 0;
        Serial.println("h = 0");
      } else if (incomingInt == -2) {// -2 to seperate the data in the group
        h++;
        Serial.println("h++");
      } else if (incomingInt == -3) {// -3 to end data group and print data
        Serial.println("Print please");//Test
        Serial.println(in[0]);
        Serial.println(in[1]);
        Serial.println(in[2]);
      }
      else {
        in[h] = incomingInt;
      }
    }
  }
  /*-----------DUMMY PROGRAM-----------*/

}


void serialEvent() {
  //  incoming = Serial.read();
  //
  ////Check to see if this is brand new set of data
  //if(incoming == 'y'){//y = new bunch of data
  //  Serial.write('g');// g = go, send next byte of data
  //
  //}else if (incoming == 'n'){//n = still sending related data
  //
  //}



}

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

















