int i= 0;
int j = 0;
boolean increase = false;

int startTime;
int frequency;
int duration;
int counter;
int gt;

void setup(){
  Serial.begin(9600); 
  //Serial.write(number);
  // Serial.clear();

}

//void loop(){
//}


unsigned int integerValue=0;  // Max value is 65535
char incomingByte;
 
void loop() {
 
//  if (Serial.available() &gt, 0) {   // something came across serial
//    integerValue = 0;         // throw away previous integerValue
//    while(1) {            // force into a loop until 'n' is received
//      incomingByte = Serial.read();
//      if (incomingByte == '\n') break;   // exit the while(1), we're done receiving
//      if (incomingByte == -1) continue;  // if no characters are in the buffer read() returns -1
//      integerValue *= 10;  // shift left 1 decimal place
//      // convert ASCII to integer, add, and shift left 1 decimal place
//      integerValue = ((incomingByte - 48) + integerValue);
//    }
//    Serial.println(integerValue);   // Do something with the value
//  }
}

void serialEvent(){
  int incoming = Serial.read();
  Serial.println(incoming);
}

//void serialEvent(){
//  //  Serial.println("Event Called");
//  Serial.flush();
//  while(Serial.available()){
//
//
//    //    input = myPort.readStringUntil('\n');
//    //    //make sure our data isn't empty before continuing
//    //    if (input != null) {
//    //      //trim whitespace and formatting characters (like carriage return)
//    //      input = trim(input);
//    //      Serial.println(input);
//    //    }
//    char buffer[] = {' ',' ',' ',' ',' ',' '};
//    int input = Serial.read();
//    // Serial.println(input);
//    if(input == 'A'){
//      //Serial.println("Got Data");
//      //Collect the data
//      
//      Serial.readBytesUntil('n',buffer,6);
//      int startTime = atoi(buffer);
//      Serial.println(startTime);
//      
////      startTime = Serial.read();
////
////      frequency = Serial.read();
////
////      duration = Serial.read();
////
////      counter = Serial.read();
//      
////      Serial.println("startTime: "+startTime);
////      Serial.println("frequency: "+frequency);
//      //  Serial.write('D');
//    }
//    //  Serial.println(counter);
//  }
//}













