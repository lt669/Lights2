Table table;
int canX = 900;
int canY = 600;
int dur = 0;
int pit = 0;
PImage img;
char pressedKey;

Cir singer1;
Cir singer2;
Cir singer3;
Cir singer4;

Singer s1;
Singer s2;
Singer s3;
Singer s4;

void setup() {
  
  //frameRate(30);

  //Setup screen
  background(-1);
  size(canX, canY);

  //Initialise new objects
  s1 = new Singer(1);
  s2 = new Singer(2);
  s3 = new Singer(3);
  s4 = new Singer(4);

  //Count number of elements for each singer
  s1.count();
  s2.count();
  s3.count();
  s4.count();

  //Print results
  //  s1.printResult();
  //  s2.printResult();
  //  s3.printResult(); 
  //  s4.printResult();

  singer1 = new Cir(canX/4, canY/4, 0, 0);
  singer2 = new Cir(canX*3/4, canY/4, 0, 0);
  singer3 = new Cir(canX/4, canY*3/4, 0, 0);
  singer4 = new Cir(canX*3/4, canY*3/4, 0, 0);
}

void draw() {

  //  if(s1.finish() == true){
  //   print("DONE"); 
  //  }
  //  else{

  //Fades out parts of the screen
  noStroke();
  fill(360, 20);
  rect(random(canX), random(canY), canX/4, canY/4);


  if (singer1.getNext() == true) {
    singer1.setBright(s1.getPitch());
    singer1.setSize(s1.getDuration());
  }
  singer1.drawCir();

  if (singer2.getNext() == true) {
    singer2.setBright(s2.getPitch());
    singer2.setSize(s2.getDuration());
  }
  singer2.drawCir();

  if (singer3.getNext() == true) {
    singer3.setBright(s3.getPitch());
    singer3.setSize(s3.getDuration());
  }
  singer3.drawCir();

  if (singer4.getNext() == true) {
    singer4.setBright(s4.getPitch());
    singer4.setSize(s4.getDuration());
  }
  singer4.drawCir();

  float imgX = random(-5, 5);
  float imgY = random(-5, 5);
  
//  saveFrame("#.png");
//  background(-1);
//  img = loadImage("#.png");
//  image(img, 1, 1);

  //}
}

//void keyPressed() {
//  if (key == 'w') {
//    singer1.drawCir
//  }
//}

 void keyPressed(){
   pressedKey = key;
  }

