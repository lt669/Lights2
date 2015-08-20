import ddf.minim.*;
import ddf.minim.analysis.*;

//import processing.sound.*;
AudioInput player;


Minim minim;
//AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
float rad = 70;
int canX = 800;
int canY = 400;
int x;
int y;
float i;
int check = 0;
float ranX;
float ranY; 
float ranBackR;
float ranBackG;
float ranBackB;
PImage img;
int maxSize = 200;
int minSize;

void setup(){
 // player = new AudioInput(this, 0);
  
  size(canX, canY);
  minim = new Minim(this);
 // player = minim.loadFile("/Users/Lewis/Music/Gramatik - The Age Of Reason (320kbps)/04 Gramatik - Pardon My French.mp3");
 // meta = player.getMetaData();
  player = minim.getLineIn(Minim.STEREO, 2048);
  beat = new BeatDetect();
  //player.loop();
  //player.play();
  background(-1);
  noCursor();
  beat.setSensitivity(10);
 // img = loadImage("/Users/Lewis/Pictures/2015/NoorCrop.jpeg");
}



void draw(){
  
 //Detect beat
  beat.detect(player.mix);
  
  if(beat.isOnset()){
    check = 1;
    print("BEAT");
  }
  if (check == 1){
    float col = 255 * 50/i;
    background(ranBackR, ranBackG, ranBackB);
    fill(col, 154, col, 20);
    ellipse(ranX, ranY, abs(i), abs(i));
    //image(img, ranX, ranY, i, i);
    i = i + 10;
   }
   
   if (i >= maxSize){
     check = 0;
   }
   
   if (check == 0){
    i = 0;
    ranX = random(0, canX - 200);
    ranY = random(0, canY - 200);
    ranBackR = random(0, 255);
    ranBackG = random(0, 255);
    ranBackB = random(0, 255);
   }

}




//void Checking(){
//    if (check == 1){
//      i = 50;
//      do{
//        redraw();
//      }while (check == 1 && i>0);
//      check = 0;
//    } 
// }
