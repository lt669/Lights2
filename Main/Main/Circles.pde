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

  int durationInMS;

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
    
    //New Size Altering Algorithm
    float increaseTime = durationInMS/(maxSize + 1);
    float currentTime = millis() - last;

    //Alter circle size
    if (size == maxSize && DONE != true) { //Once circle has reached maxSize, DONE
      DONE = true;
      //      print("\n DONE");
    } else if (DONE != true && currentTime >= increaseTime) { //If its maximum size is not reached, increase size
      size++;
      last = millis();
    } else if (DONE == true && size != 0 || size > maxSize) {
      // size = abs(size-1);
      size--;
    }

    if(NEXT == true){
      DONE = false;
    }

    
    float sizeBri = map(size, 0, maxSize, 0, 100);
    colorMode(HSB, 360, 100, 100);

    if (choice == 1) {
      noStroke();
      fill(bright, sizeBri, Brightness, Brightness);
      ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);
    } else if (choice == 2) {
      noStroke();
      fill(bright, sizeBri, Brightness, Brightness);
      ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);
    } else if (choice == 3 || choice == 8) {
      stroke(bright, Saturation, Brightness, 100 - Brightness);
      fill(0, 0, BGbri, Saturation); //Setting last value to 0 makes the circles centres transparent 
      ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);
    }
  }

  void setNext(boolean n) {
    NEXT = n;
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

