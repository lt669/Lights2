int hit = 0;
//Serial port;
boolean firstContact = false;
int serialCount = 0;
int[] serialInArray = new int[2];

void setup()
{
//  port = new Serial(this, "/dev/tty.usbmodem641", 9600); 
  Serial.begin(9600);
  pinMode(11, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(6, OUTPUT);
}

void loop(){

  //wait untill arduino receives input
  while (Serial.available() == 0);
  serialEvent(); 
}

void serialEvent(){
  
  int inByte = myPort.read();
  if (firstContact == false){
   if(inByte == 'A'){
    port.clear();
    firstContact == true;
    port.write('A');
   } 
  }
  else{
   serialInArray[serialCount] = inByte;
   serialCount++;
    
    if (serialCount > 1){
      rightBright = serialInArray[0];
      botBright = serialInArray[1];
      
      //Request new readings
      port.write('A');
      serialCount = 0;
    }
    
  }
  
  
}

void digitalSerial(){
    
  int val = Serial.read();  
  int del = 100;
  
  if(val == 0){
    digitalWrite(11, HIGH);
    digitalWrite(10, LOW);
    digitalWrite(9, LOW);
    digitalWrite(6, LOW);
    delay(del);
  }
  else if(val == 1){
   digitalWrite(11, LOW);
   digitalWrite(10, LOW);
   digitalWrite(9, LOW);
   digitalWrite(6, HIGH);
   delay(del);
  }
  else if (val == 2){
   digitalWrite(11, LOW);
   digitalWrite(10, LOW);
   digitalWrite(9, HIGH);
   digitalWrite(6, LOW);
   delay(del);
  }
  else if (val == 3){
   digitalWrite(11, LOW);
   digitalWrite(10, HIGH);
   digitalWrite(9, LOW);
   digitalWrite(6, LOW);
   delay(del);
  }
  else{
    digitalWrite(11, LOW);
    digitalWrite(10, LOW);
    digitalWrite(9, LOW);
    digitalWrite(6, LOW);
  }
}

//void serialEvent(Serial port){
//  port.read();
//  println("FUCK:",port);
//}


