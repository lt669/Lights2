import processing.video.*;
Movie myMovie;
import ddf.minim.*;

textFileReader PART1;
textFileReader PART2;
textFileReader PART3;
textFileReader PART4;
textFileReader PART5;
textFileReader PART6;

void setup() {
  size(1920, 1080);
  myMovie = new Movie(this, "processingMovie30fps.mov");
  myMovie.play();

  //Initialise Port to send serial data to arduino
  port = new Serial(this, "/dev/cu.usbmodem411", 9600); 
  port.bufferUntil('\n');

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

  frameRate(30);
}

void draw() {
  image(myMovie, 0, 0);

  PART1.timer(1);
  PART2.timer(2);
  PART3.timer(3);
  PART4.timer(4);
  PART5.timer(5);
  PART6.timer(6);
}

void movieEvent(Movie m) {
  m.read();
}
