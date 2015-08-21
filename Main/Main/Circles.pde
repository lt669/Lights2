//Class for drawing a randomly moving, size changing circle

class Cir {
  int posX;
  int posY;
  int maxSize;
  int size = 0;
  int bright;
  boolean DONE;
  boolean NEXT;
  boolean durationTime;
  boolean secondPassed;
  int durationMod;
  int durationCounter = 0;
  int last = 0;
  int millis;
  int seconds;
  int[] secondArray = new int[2]; // place to compair seconds values
  float Saturation;
  float Brightness;

  //Range Variables
  int minPitch;
  int maxPitch;
  int minDuration;
  int maxDuration;

  int movement;
  int sizeMultiplier;

  boolean w;

  //Constructor
  Cir(int iPosX, int iPosY, int iSize, int iBright) {
    posX = iPosX;
    posY = iPosY;
    maxSize = iSize;
    bright = iBright;
  }

  void drawCir() {

    float incX = 0;
    float incY = 0;

    if (select == 3 || select == 4) {
      movement = 2;
      sizeMultiplier = 1;
      incX = random(-(size*sizeMultiplier)*movement, (size*sizeMultiplier)*movement);
      incY = random(-(size*sizeMultiplier)*movement, (size*sizeMultiplier)*movement);
    } else if (select == 5) {
      movement = 1;
      sizeMultiplier = 1;
      incX = random(-(size)*movement, size*movement);
      incY = random(-(size)*movement, size*movement);
    } else if (select == 6) {
      int randomMovement = round(random(3));

      if (randomMovement == 0) {
        incX = size*sizeMultiplier;
        incY = size*sizeMultiplier;
      } else if (randomMovement == 1) {
        incX = -size*sizeMultiplier;
        incY = size*sizeMultiplier;
      } else if (randomMovement == 2) {
        incX = size*sizeMultiplier;
        incY = -size*sizeMultiplier;
      } else if (randomMovement == 3) {
        incX = -size*sizeMultiplier;
        incY = -size*sizeMultiplier;
      }
    }

    //Random movement variables


    //Update position
    posX += incX;
    posY += incY;

    //Wrap around canvas
    if (posX <= 0) {
      posX += canX;
    } else if (posX == canX) {
      posX -= canX;
    }

    if (posY <= 0) {
      posY += canY;
    } else if (posY >= canY) {
      posY -= canY;
    }

    //Alter circle size
    if (size == maxSize && DONE != true) { //Once circle has reached maxSize, DONE
      DONE = true;
      //      print("\n DONE");
    } else if (DONE != true && secondPassed == true) { //If its maximum size is not reached, increase size
      size++;
    } else if (DONE == true && size != 0 || size > maxSize) {
      // size = abs(size-1);
      size--;
    }

    //Check if ready for the next value in the array
    if (size <= 0 && DONE == true) {//Once circle has shurnk, get the next value
      NEXT = true;
      DONE = false;
      //print("\n NEXT");
    } else {
      NEXT = false;
    }

    //  println("DONE: "+DONE+ " size: "+size+" maxSize: "+maxSize);
    //Draw Line
    //  stroke(250,250,250);
    //  line(canX/2,canY/2,posX,posY);

    // Draw ellipse
    //  bright = 360 * 12/(bright+1);

    //        stroke(255);
    //        fill(255);
    //        ellipse(posX, posY, size, size);
    //        filter(BLUR, 1);

    //  if(bright == 255*12){
    //    size = 0;
    //  }

    if (choice == 1) {
      colorMode(HSB, 360, 100, 100);

      //      println("bright: " + bright + " - Saturation: " + Saturation + " - Brightness: " + Brightness);

      // stroke(bright,Saturation, Brightness);
      Circles.beginDraw();
      Circles.noStroke();
      Circles.fill(bright, Saturation, Brightness, bright/2);
      Circles.ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);
      Circles.endDraw();
    } else if (choice == 2) {

      colorMode(HSB, 360, 100, 100);
      float invert = 100 - Brightness;
      stroke(0, 0, bright);
      fill(0, bright, bright, invert);
      ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);

      //      bright = round(map(bright, 0, 360, 0, 255));
      //      println("bight: ",bright);
      //      colorMode(RGB,255,255,255);
      //      stroke(bright, bright, bright);
      //     // stroke((255 - bright),(255 - bright), (255 - bright), (255 - bright));
      //      fill(bright, 0, 0, bright);
      //      ellipse(posX, posY, size*5, size*5);
    } else if (choice == 3 || choice == 8) {
      colorMode(HSB, 360, 100, 100);
      // map(bright, 0, 12, 0, 360);
      stroke(bright, Saturation, Brightness, bright);
      fill(0, 0, BGbri, Saturation); //Setting last value to 0 makes the circles centres transparent 
      ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);
    }

    //  println("DONE: " + DONE + " - Seconds: " + seconds + " - maxSize: " + maxSize + " - Size: " + size + " - Bright: " + bright + " - Saturation: " + Saturation + " - Key: " + pressedKey);
  }

  boolean getNext() {
    return NEXT;
  }

  void setRange(int MinPitch, int MaxPitch, int MinDuration, int MaxDuration) {
    minPitch = MinPitch;
    maxPitch = MaxPitch;
    minDuration = MinDuration;
    maxDuration = MaxDuration;
  }

  void setSize(int SIZE) {
    maxSize = int(map(SIZE, minDuration, maxDuration, 0, 10));
    //  println("SIZE: "+ SIZE + " minD: " + minDuration + " maxD: " + maxDuration + " maxSize: "+maxSize);
  }

  void setBright(int BRIGHT) {
    //  bright = BRIGHT;
    bright = round(map(BRIGHT, minPitch, maxPitch, 0, 360)); 
    Saturation = round(map(BRIGHT, minPitch, maxPitch, 0, 100));
    Brightness = round(map(BRIGHT, minPitch, maxPitch, 0, 70));
  }

  void setSecondPassed(boolean second) {
    secondPassed = second;
  }
}

