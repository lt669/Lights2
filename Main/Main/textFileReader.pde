//Text file reader
class textFileReader {
  String[] text;
  String file; 
  int [][] singerInfo;
  int[] secondArray = new int[2]; // place to compare seconds values
  int x = 0;
  int z = 0;
  int seconds;
  boolean secondPassed;
  boolean NEXT;
  int retPitch;
  int retDuration;

  int maxPitch;
  int maxDuration;
  int minPitch = 10000; //Large values to compare to
  int minDuration = 10000;

  int h = 0;

  int val; //Flag sent by Arduino

  //Constructor
  textFileReader(String iFile) {
    file = iFile;
  }

  void read() {
    text = loadStrings(file); 
    //    println("text: ", text.length);
    singerInfo = new int[3][text.length]; //1.Start time 2.Frequency 3.Note duration ms
    for (int i=0; i< (text.length/3); i++) {
      for (int j=0; j<3; j++) {
        singerInfo[j][i] = int(text[x]);
        x++;
      }
    }
  }


  //Measure time passed and send new values from the arrays
  void timer(int TAG) {
    if (z < text.length - 1) {
      //      println("Length: ", text.length);
      //      println("Millis: "+millis()+" Next Millis: " + singerInfo[0][z+1] + " SecondPasses: " + secondPassed);
      //Initialise counters
      //      millis = millis() - last;

      seconds = round(millis()/1000);

      //Move last value down the array
      secondArray[1] = secondArray[0];
      secondArray[0] = seconds;

      //Determine whether a second has passed
      if (secondArray[0] > secondArray[1]) {
        secondPassed = true;
      } else if (secondArray[0] <= secondArray [1]) {
        secondPassed = false;
      }

      if (millis() >= singerInfo[0][z+1]) {
        NEXT = true;
        //last = millis();
        z++; // Increase array address
      } else {
        NEXT = false;
      }
    } else {
      println("END OF FILE");
    }
    
    sendToArduino(TAG);
    
  }
  
  void sendToArduino(int inTAG){
    //Send data to arduino when new data is needed
    if(NEXT == true){

      println("TAG: "+inTAG+" pitch: "+singerInfo[1][z]+" duration: "+singerInfo[2][z]+" state: "+state);
      String tagS = str(inTAG);
      String pitchS = str(singerInfo[1][z]);
      String durationS = str(singerInfo[2][z]);
      String stateS = str(state); //Takes global variable 'state'

      while(val != 1){
      port.write(""+tagS+","+pitchS+","+durationS+","+stateS);
      println("Waiting...");
      val = port.read();
      if(val == 1){
        break;
      }
      }
      val = port.read();
    }
  }

  void rangeCalc() { //Calculates the maximum & minimum pitch and duration within the text file
    //Max Pitch
    // println("text.Length",text.length/3); // Divide 3 as file contains ALL the information
    for (int i=0; i<text.length/3; i++) {
      // println("Every Pitch: "+singerInfo[1][i]+"["+i+"]");
      if (singerInfo[1][i] > maxPitch) {
        maxPitch = singerInfo[1][i];
      }
      //Min Pitch
      if (singerInfo[1][i] < minPitch) {
        minPitch = singerInfo[1][i];
      }
      //Max Duration
      if (singerInfo[2][i] > maxDuration) {
        maxDuration = singerInfo[2][i];
      }
      //Min Duration
      if (singerInfo[2][i] < minDuration)
      {
        minDuration = singerInfo[2][i];
      }
    }  
    println("(File) maxPitch: "+ maxPitch + " maxDuration: "+maxDuration+ " minPitch: "+minPitch + " length: "+text.length);
  }

  int getMinPitch() {
    return minPitch;
  }

  int getMaxPitch() {
    return maxPitch;
  }

  int getMinDuration() {
    return minDuration;
  }

  int getMaxDuration() {
    return maxDuration;
  }

  //Returns the current value under 'Pitch' in the CSV file
  int getPitch() {    
    if (NEXT == true) {      
      retPitch = singerInfo[1][z];
    }
    return retPitch;
  }

  //Returns the current value under 'Duration' in the CSV file
  int getDuration() {
    if (NEXT == true) {
      retDuration = singerInfo[2][z];
      //      println("retDuration: "+retDuration+" minDuration: " + minDuration + " maxDuration: "+maxDuration);
    }
    return retDuration;
  }

  boolean getNext() {
    return NEXT;
  }

  int getLvl() {
    if (millis() >= (singerInfo[0][z] + singerInfo[2][z])) {
      return 0;
    } else
      return 1;
  }

  int getNextStartTime() {
    return singerInfo[0][z+1];
  }

  boolean getSecondPassed() {
    return secondPassed;
  }

  void printFile(String iPart) {
    String part = iPart;
    for (int i=0; i< (text.length/3); i++) {
      println(" " + part+ " " + singerInfo[0][i] + "  " + singerInfo[1][i] + "  " + singerInfo[2][i]);
    }
    println("x: ", x);
  }
}

//void getTextLength(){
// return text.length; 
//}

//void toArduino() {
//  port.write("<");
//  port.write(singerInfo); 
//  port.write(">");
//}

