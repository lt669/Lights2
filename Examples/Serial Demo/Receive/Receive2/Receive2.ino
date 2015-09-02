int i= 0;
int j = 0;
boolean increase = false;

int startTime;
int frequency;
int duration;
int counter;
boolean firstContact = false;

void setup(){
  Serial.begin(9600); 
  Serial.write('z');//Send valuse to establish contact
}

void loop() {
 // Serial.write(1);
}

void serialEvent(){
  int incoming = Serial.read();
  Serial.println(incoming);
}

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

















