

void setup(){
  size(600, 400);
  background(0);
}

void draw(){
  smooth();
  noStroke();
  fill(255,0,0);
  ellipse(100,100,95,95);
  filter( BLUR, 6 );
  stroke(0);
  fill(255,255,0);
  ellipse(100,100,90,90);
}

