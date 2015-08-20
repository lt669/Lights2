import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
int  r = 200;
float rad = 70;
int canX = 600;
int canY = 400;
int x;
int y;
int i = 50;


void setup(){
  size(canX, canY);
  minim = new Minim(this);
  player = minim.loadFile("/Users/Lewis/Music/Gramatik - The Age Of Reason (320kbps)/04 Gramatik - Pardon My French.mp3");
  meta = player.getMetaData();
  beat = new BeatDetect();
  player.loop();
  //player.play();
  background(-1);
  noCursor();
}

void draw(){

  float ranX = random(0, canX);
  float ranY = random(0, canY);
  
  //Detect beat
  beat.detect(player.mix);
  
  if(beat.isOnset()){
    check = 1;
    }
    
  if (check == 1){
    i = 50;
    do{
    background(-1);
    int col = 255 * 50/i;
    fill(col, col, col);
    ellipse(ranX, ranY, i, i);
    i--;
    }while (check == 1 && i>0)
    
    check = 0;
  }
  
  
}

void sizeCalc {
 
 
  
}
