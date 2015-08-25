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
  
  int durationInMS;

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

    //    if (select == 3 || select == 4)
    if (select <= 4) {
      movement = 2;
      sizeMultiplier = 1;
      incX = random(-(size*sizeMultiplier)*movement, (size*sizeMultiplier)*movement);
      incY = random(-(size*sizeMultiplier)*movement, (size*sizeMultiplier)*movement);
    } else if (select == 5) {
      movement = 1;
      sizeMultiplier = 1;
      //      incX = random(-size*movement, size*movement);
      //      incY = random(-size*movement, size*movement);

      incX = random(-(movement/(size+1)), movement/(size+1));
      incY = random(-(movement/(size+1)), movement/(size+1));
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

    //New Alter Circle Size
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
    println("size: "+size+" currentTime: " + currentTime + " increaseTime: "+increaseTime);


    //    //Alter circle size
    //    if (size == maxSize && DONE != true) { //Once circle has reached maxSize, DONE
    //      DONE = true;
    //      //      print("\n DONE");
    //    } else if (DONE != true && secondPassed == true) { //If its maximum size is not reached, increase size
    //      size++;
    //    } else if (DONE == true && size != 0 || size > maxSize) {
    //      // size = abs(size-1);
    //      size--;
    //    }

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

    if (choice == 1 || circles1Y > 0 - canY && circles1Y < canY  && circles1X > 0 && circles1X < canX) {
      println("Running CIRCLE 1");
      Circles1.beginDraw();
      Circles1.colorMode(HSB, 360, 100, 100, 100);
      if (backGroundChange == true) {
        Circles1.background(0, 0, 100, 0);
      }
      Circles1.smooth();
      Circles1.noStroke();
      Circles1.fill(bright, Saturation, Brightness, bright/2);
      Circles1.ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);
      //Fading Rectangles
      Circles1.noStroke();
      Circles1.fill(BGhue, BGsat, BGbri, 10);
      Circles1.rect(random((0-canX/4), canX), random((0-canY/4), canY), canX/4, canY/4);
      Circles1.endDraw();
      image(Circles1, circles1X, circles1Y);
    }

    float invert = 100 - Brightness;
    if (choice == 2 || circles2Y > 0 - canY && circles2Y < canY && circles2X > 0 && circles2X < canX) {
      println("Running CIRCLE 2");
      Circles2.beginDraw();
      if (backGroundChange == true) {
        Circles2.background(0, 0, 100, 0);
      }
      Circles2.colorMode(HSB, 360, 100, 100);
      Circles2.smooth();
      Circles2.stroke(0, 0, bright);
      Circles2.fill(0, bright, bright, invert);
      Circles2.ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);
      Circles2.endDraw();
      image(Circles2, circles2X, circles2Y);
    }


    //      bright = round(map(bright, 0, 360, 0, 255));
    //      println("bight: ",bright);
    //      colorMode(RGB,255,255,255);
    //      stroke(bright, bright, bright);
    //     // stroke((255 - bright),(255 - bright), (255 - bright), (255 - bright));
    //      fill(bright, 0, 0, bright);
    //      ellipse(posX, posY, size*5, size*5);

    colorMode(HSB, 360, 100, 100);
    if (choice == 3 || circles3Y > 0 - canY && circles3Y < canY) {
      println("Running CIRCLE 3");
      Circles3.beginDraw();
      Circles3.colorMode(HSB, 360, 100, 100, 100);
      if (backGroundChange == true) {
        Circles3.background(0, 0, 100, 0);
      }
      Circles3.smooth();
      Circles3.stroke(bright, Saturation, Brightness, 100 - Brightness);
      println("bright", Brightness);
      Circles3.fill(0, 0, BGbri, Saturation); //Setting last value to 0 makes the circles centres transparent 
      Circles3.ellipse(posX, posY, size*sizeMultiplier, size*sizeMultiplier);
      Circles3.endDraw();

      Circles3.noStroke();
      Circles3.fill(BGhue, BGsat, BGbri, 10);
      Circles3.rect(random((0-canX/4), canX), random((0-canY/4), canY), canX/4, canY/4);
      Circles3.endDraw();
      image(Circles3, circles3X, circles3Y);
    }
  }


  //  println("DONE: " + DONE + " - Seconds: " + seconds + " - maxSize: " + maxSize + " - Size: " + size + " - Bright: " + bright + " - Saturation: " + Saturation + " - Key: " + pressedKey);


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
    durationInMS = SIZE;
    println("durationInMS: ",durationInMS);
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

