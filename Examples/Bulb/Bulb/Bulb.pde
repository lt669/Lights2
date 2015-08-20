PImage img;
int x = 300;
int y = 200;
int max = 10;
boolean done = false;
int i = 0;
int canX = 900;
int canY = 600;
boolean glow;

void setup() {
  size(canX, canY, P3D);

  imageMode(CENTER);
  img = loadImage("/Users/Lewis/Developer/Lights_Project/Lights/Examples/Bulb/Bulb/Bulb_cutV2.png");
  //Dimensions 2448 x 3264
}

void draw() {
  float pos = 0.05;

if(glow == true){
  smooth();
  noStroke();
  fill(255, 50, 0);
  ellipse(x, y+25, 120, 120);
  
  filter( BLUR, 3 );
//  stroke(0);
//  fill(255, 255, 0);
//  ellipse(x, y, i, i);
  i += 5;
}
  if (glow == false) {
    i=0;
    noStroke();
    rectMode(CORNER);
    fill(255,255,255,5);
    rect(0,0,canX,canY);
    
  } 
  //translate(x,y);
  rotate(HALF_PI);
  image(img, 0, 0, 2448*pos, 3264*pos);
}

void mousePressed(){
 glow = true; 
}

void mouseReleased(){
 glow = false; 
}
