//class Singer {
//
//  //Initialise Arrays to store elements for each singer
//  int[] pitch = new int[0];
//  int[] duration = new int[0];
//  int singerNo;
//  int z = 0;
//  int x = 0;
//  int k;
//  int retPitch;
//  int retDuration;
//
//  //Load CSV file
//  Table table = loadTable("CSV.csv", "header");
//  TableRow row;
//  int rowNo = table.getRowCount();
//
//  //Constructor
//  Singer(int iSingerNo) {
//    singerNo = iSingerNo;
//  } 
//
//  //Used to reset the array if necessary
//  void arrayReset() {
//    for (k=0; k < rowNo/4; k++) {
//      pitch[k] = 0;
//      duration[k] = 0;
//    }
//  }
//
//  //Count the number of elements in the CSV file for each singer
//  void count() {
//    for (TableRow row : table.rows ()) {
//      if (row.getInt("Singer") == singerNo) {
//        pitch = append(pitch, 2 * row.getInt("Pitch"));
//        duration = append(duration, 2 * row.getInt("Duration"));
//      }
//    }
//  }
//
//  void printResult() {
//    for (int i=0; i < rowNo/4; i++) {
//      pit = pitch[i];
//      dur = duration[i];
//      print("\n Singer:" + singerNo + " Pitch:" + pit + " Duration:" + dur);
//    }
//  }
//
//  //  boolean finish(){
//  //   if (TableRow row == table.rows()){
//  //    return boolean FINISHED true;
//  //   } 
//  //  }
//
//  int getPitch() {
//    if (z < rowNo/4) {
//      retPitch = pitch[z];
//      z++;
//    }
//    print("\n Singer" + singerNo + " PITCH: ", retPitch);
//    return retPitch;
//  }
//
//  int getDuration() {
//    if (x < rowNo/4) {
//      retDuration = duration[x];
//      x++;
//    }
//    print(" DURATION: ", retDuration);
//    return retDuration;
//  }
//}

