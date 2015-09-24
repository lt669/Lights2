import processing.video.*;
Movie myMovie;
import ddf.minim.*;
import processing.serial.*;
Serial port;

Minim minim;
AudioPlayer player;

int val;

textFileReader PART1;
textFileReader PART2;
textFileReader PART3;
textFileReader PART4;
textFileReader PART5;
textFileReader PART6;

int state = 1; //Always send 1 to arduino
int count = 0;

void setup() {
  size(50, 50);
  fill(255,0,0);
  rect(0,0,50,50);
  // myMovie = new Movie(this, "processingMovie30fps.mov");
  // myMovie.play();

  //Initialise Port to send serial data to arduino
  port = new Serial(this, "/dev/cu.usbmodem641", 9600); 
  port.bufferUntil('\n');


  minim = new Minim(this);
  //Mac
  player = minim.loadFile("/Users/Lewis/Desktop/music(verb).mp3");
  player.play();

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

void draw() {
  if(count <= 0){
  player.rewind();
} else {
 // image(myMovie, 0, 0);

    val = port.read();
    //val = 1;
    if(val == 1){
    PART1.timer(1, val);
   // delay(100);
    PART2.timer(2, val);
   // delay(100);
    PART3.timer(3, val);
   // delay(100);
    PART4.timer(4, val);
   // delay(100);
    PART5.timer(5, val);
   // delay(100);
    PART6.timer(6, val);
   // delay(100);
    }
 }
}

void mousePressed(){
  count++;
}

void movieEvent(Movie m) {
  m.read();
}
