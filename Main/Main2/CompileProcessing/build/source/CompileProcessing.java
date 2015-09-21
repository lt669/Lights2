import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 
import ddf.minim.*; 
import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class CompileProcessing extends PApplet {


Movie myMovie;


Serial port;

Minim minim;
AudioPlayer player;

textFileReader PART1;
textFileReader PART2;
textFileReader PART3;
textFileReader PART4;
textFileReader PART5;
textFileReader PART6;

int state = 1; //Always send 1 to arduino
int count = 0;

public void setup() {
  size(20, 20);
  // myMovie = new Movie(this, "processingMovie30fps.mov");
  // myMovie.play();

  //Initialise Port to send serial data to arduino
  port = new Serial(this, "/dev/cu.usbmodem641", 9600); 
  port.bufferUntil('\n');


  minim = new Minim(this);
  //Mac
  // player = minim.loadFile("/Users/Lewis/Desktop/music(verb).mp3");
  // player.play();

  PART1 = new textFileReader("Part1.txt");
  PART2 = new textFileReader("Part2.txt");
  PART3 = new textFileReader("Part3.txt");
  PART4 = new textFileReader("Part4.txt");
  PART5 = new textFileReader("Part5.txt");
  PART6 = new textFileReader("Part6.txt");

  //Read Data from .txt files
  PART1.read();
  PART2.read();
  PART3.read();
  PART4.read();
  PART5.read();
  PART6.read();

  //frameRate(30);
}

public void draw() {
  if(count > 0){
 // image(myMovie, 0, 0);

  PART1.timer(1);
  PART2.timer(2);
  PART3.timer(3);
  PART4.timer(4);
  PART5.timer(5);
  PART6.timer(6);
 }
}

public void mousePressed(){
  count++;
}

public void movieEvent(Movie m) {
  m.read();
}
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
  int waitingCount = 0;

  //Constructor
  textFileReader(String iFile) {
    file = iFile;
  }

  public void read() {
    text = loadStrings(file); 
    //    println("text: ", text.length);
    singerInfo = new int[3][text.length]; //1.Start time 2.Frequency 3.Note duration ms
    for (int i=0; i< (text.length/3); i++) {
      for (int j=0; j<3; j++) {
        singerInfo[j][i] = PApplet.parseInt(text[x]);
        x++;
      }
    }
  }


  //Measure time passed and send new values from the arrays
  public void timer(int TAG) {
    if (z < text.length/3 - 1) {
      //      println("Length: ", text.length);
      //      println("Millis: "+millis()+" Next Millis: " + singerInfo[0][z+1] + " SecondPasses: " + secondPassed);
      //Initialise counters
      //      millis = millis() - last;

      seconds = round(millis()/1000);

      //Move last value down the array
      secondArray[1] = secondArray[0];
      secondArray[0] = seconds;

      //Determine whether a second has passed
      if (secondArray[0] > secondArray[1]){
        secondPassed = true;
      } else if (secondArray[0] <= secondArray [1]) {
        secondPassed = false;
      }

      if (millis() >= singerInfo[0][z+1]) {
        NEXT = true;
        //last = millis();
        z++; // Increase array address
        sendToArduino(TAG);
      } else {
        NEXT = false;
      }
    } else {
      println("END OF FILE: ",TAG);
    }
  }

  public void sendToArduino(int inTAG) {
    //Send data to arduino when new data is needed
    if (NEXT == true) {

      println("TAG: "+inTAG+" pitch: "+singerInfo[1][z]+" duration: "+singerInfo[2][z]+" state: "+state);
      String tagS = str(inTAG);
      String pitchS = str(singerInfo[1][z]);
      String durationS = str(singerInfo[2][z]);
      String stateS = str(state); //Takes global variable 'state'

      while (val != 1) {
        port.write(""+tagS+","+pitchS+","+durationS+","+stateS);
        println("Waiting...",waitingCount);
        val = port.read();
        waitingCount++;
        // println("waitingCount: ",waitingCount);
        if (waitingCount >=200) {//break out if there is an error
          val = 1;
          waitingCount = 0;
        }
        if (val == 1) {
          //waitingCount = 0;
          waitingCount = 0;
          println("Val = ",val);
          port.clear(); //Clear the buffer
          break;
        }
      }
      val = port.read();
    }
  }

  public void rangeCalc() { //Calculates the maximum & minimum pitch and duration within the text file
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

  public int getMinPitch() {
    return minPitch;
  }

  public int getMaxPitch() {
    return maxPitch;
  }

  public int getMinDuration() {
    return minDuration;
  }

  public int getMaxDuration() {
    return maxDuration;
  }

  //Returns the current value under 'Pitch' in the CSV file
  public int getPitch() {    
    if (NEXT == true) {      
      retPitch = singerInfo[1][z];
    }
    return retPitch;
  }

  //Returns the current value under 'Duration' in the CSV file
  public int getDuration() {
    if (NEXT == true) {
      retDuration = singerInfo[2][z];
      //      println("retDuration: "+retDuration+" minDuration: " + minDuration + " maxDuration: "+maxDuration);
    }
    return retDuration;
  }

  public boolean getNext() {
    return NEXT;
  }

  public int getLvl() {
    if (millis() >= (singerInfo[0][z] + singerInfo[2][z])) {
      return 0;
    } else
      return 1;
  }

  public int getNextStartTime() {
    return singerInfo[0][z+1];
  }

  public boolean getSecondPassed() {
    return secondPassed;
  }

  public void printFile(String iPart) {
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

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CompileProcessing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
