class lightClass {
int blinkRate;
int currentLED = 0;
int LED1;
int LED2;
String DONE;
int val = 1;

  //Constructor
  lightClass(int iBlinkRate, int Led1, int Led2) {
    blinkRate = iBlinkRate;
    LED1 = Led1;
    LED2 = Led2;
  }

  void sendData() {
    println("VAL: ",val);
    currentLED++;
    if(currentLED >LED2){
     currentLED = LED1;
    println("IN LOOP"); 
    }
    
    println("Current LED: ",currentLED);
    
    String LightON = str(currentLED);
    
    while (val != 1) {
      port.write(LightON);
      val = port.read();
      println("Loop Val:", val);
      if (val == 1) {
        println("val: ", val);
        break;
      }
    }
    val = port.read();
    println("PASSED LOOP");
  }
}

