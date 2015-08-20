class Singer {

  //Initialise Arrays to store elements for each singer
  int[] pitch = new int[0];
  int[] duration = new int[0];
  int singerNo;
  int z = 0;
  int x = 0;
  int k;
  int retPitch;
  int retDuration;
  float millis;
  //Timer variables
  int last;
  int seconds;
  int[] secondArray = new int[2];
  boolean secondPassed;
  boolean NEXT;

  //Load CSV file
  Table table = loadTable("CSV.csv", "header");
  TableRow row;
  int rowNo = table.getRowCount();

  //Constructor
  Singer(int iSingerNo) {
    singerNo = iSingerNo;
  } 

  //Count the number of elements in the CSV file for each singer
  void count() {
    for (TableRow row : table.rows ()) {
      if (row.getInt("Singer") == singerNo) {
        pitch = append(pitch, /*2 **/ row.getInt("Pitch"));
        duration = append(duration, /*2 **/ row.getInt("Duration"));
      }
    }
  }

  //Measure time passed and send new values from the arrays
  void timer() {
    if (z < duration.length - 1) {
      //Initialise counters
      millis = millis() - last;
      seconds = round(millis/1000);

      //Move last value down the array
      secondArray[1] = secondArray[0];
      secondArray[0] = seconds;

      //Determine whether a second has passed
      if (secondArray[0] > secondArray[1]) {
        secondPassed = true;
      } else if (secondArray[0] <= secondArray [1]) {
        secondPassed = false;
      }

      if (seconds == duration[z]) {//If the duration of the note has been reached, send new data
        NEXT = true;
        last = millis();
        z++; // Increase array address
      } else {
        NEXT = false;
      }
    } else {
      println("END OF FILE");
    }
  }

  //Returns the current value under 'Pitch' in the CSV file
  int getPitch() {
    if (/*z < rowNo/4 && */NEXT == true) {// 4 = number of singers at the moment
      retPitch = pitch[z];
    }
    //     print("\n Singer " + singerNo + " PITCH: ", retPitch);
    return retPitch;
  }

  //Returns the current value under 'Duration' in the CSV file
  int getDuration() {
    if (/*z < rowNo/4 &&*/ NEXT == true) {
      retDuration = duration[z];
    }
    //      print(" DURATION: ", retDuration);
    return retDuration;
  }

  boolean getSecondPassed() {
    return secondPassed;
  }

  void printInfo() {
    if (NEXT == true) {
      println("\n Singer " + singerNo + " PITCH: " + retPitch + " DURATION: " + retDuration);
    }
  }
}

