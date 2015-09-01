int i= 0;
int j = 0;
boolean increase = false;

int startTime;
int frequency;
int duration;
int counter;

void setup(){
  Serial.begin(9600); 
  //Serial.write(number);
  // Serial.clear();

}

void loop(){
}

void serialEvent(){
//  Serial.println("Event Called");

  while(Serial.available()){

    int input = Serial.read();
   // Serial.println(input);
    if(input == 'A'){
      Serial.println("GOT A");
      //Collect the data
      startTime = Serial.read();
      frequency = Serial.read();
      duration = Serial.read();
      counter = Serial.read();
      Serial.println("startTime: "+startTime);
            Serial.println("frequency: "+frequency);
    }
  //  Serial.println(counter);
  }
}









