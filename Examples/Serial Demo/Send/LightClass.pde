class lightClass {
  int blinkRate;
  int currentLED = 1;
  int LED1;
  int LED2;
  String DONE;
  int val = 0;
  int count;
  int TAG;
  int brightness;

  //Constructor
  lightClass(int iTAG, int iBlinkRate, int Led1, int Led2, int iBrightness) {
    TAG = iTAG;
    blinkRate = iBlinkRate;
    LED1 = Led1;
    LED2 = Led2;
    brightness = iBrightness;
  }

  void sendData() {
    val = 0;
    
    int ran = int(random(3));
    if (ran == 0) {
      LED1 = 3;
    } else if (ran == 1) {
      LED1 = 5;
    } else if (ran == 2) {
      LED1 = 6;
    }

    println("TAG: "+TAG+ " VAL: ", val);
    //    if (count >= blinkRate) {
    //      currentLED++;
    //      count = 0;
    //      if (currentLED >LED2) {
    //        currentLED = LED1;
    //        println("CHANGE LED");
    //      }
    //    } 

    currentLED = LED1;

    //count++;


    String LightON = str(currentLED);
    String BRI = str(brightness);

    println("TAG: "+TAG+ " Current LED: "+ currentLED+" BRI: "+BRI+" Count: "+count);

    while (val != 1) {
      port.write(""+TAG+","+LightON+","+BRI);
      val = port.read();
      println("TAG: "+TAG+ " Loop Val:", val);
      if (val == 1) {
        break;
      }
    }
    val = port.read();
    println("TAG: "+TAG+ " Final Val: ", val);
  }
}

