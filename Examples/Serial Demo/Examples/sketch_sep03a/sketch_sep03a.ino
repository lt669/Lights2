int  serIn; //var that will hold the bytes in read from the serialBuffer

void setup() {
  Serial.begin(9600);
 
}

//auto go_to_the_line function
//void printNewLine() {
//  Serial.print(13, BYTE);
//  Serial.print(10, BYTE);
//}


void loop () {
  //simple feedback from Arduino  Serial.println("Hello World"); 
  
  // only if there are bytes in the serial buffer execute the following code
  if(Serial.available()) {    
    //inform that Arduino heard you saying something
    Serial.print("Arduino heard you say: ");
    
    //keep reading and printing from serial untill there are bytes in the serial buffer
     while (Serial.available()>0){
        serIn = Serial.read();  //read Serial        
        Serial.print(serIn);  //prints the character just read
     }
     
    //the serial buffer is over just go to the line (or pass your favorite stop char)               
    Serial.println();
  }
  
  //slows down the visualization in the terminal
  delay(1000);
}
