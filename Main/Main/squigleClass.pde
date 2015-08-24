class squigleClass {

  float posX;
  float posY;
  int iPoints = 1;
  int points;
  int count = 0;

  float[] xArray;
  float[] yArray;
  float[] newXArray;
  float[] newYArray;
  float xDirection;
  float yDirection;
  float randMove;
  int curve = 20;
  int divide = 16;
  int randomDiameter;
  int lowerD;
  int noteON;

  boolean m;
  boolean n;
  boolean b;

  //Set max and mins
  int minPitch;
  int maxPitch;
  int minDuration;
  int maxDuration;

  //Check whether the number of points received is greater or larger than the last value
  int[] numberOfPoints;

  //Variables to signify which array was last edited
  boolean largerUsed;
  boolean smallerUsed;

  //Constructor
  squigleClass(float iPosX, float iPosY) {
    posX = iPosX;
    posY = iPosY;

    //Initialise arrays
    xArray = new float[iPoints +1];
    yArray = new float[iPoints +1];
    newXArray = new float[iPoints +1];
    newYArray = new float[iPoints +1];
    numberOfPoints = new int[2];

    xDirection = posX; 
    yDirection = posY;
  }

  void calcShape(int inputPoints, int lvl) {
    //    println("inputPoints: ", inputPoints);
    points = round(map(inputPoints, minDuration, maxDuration, 10, 70)); //Make the chain longer
    noteON = lvl;
    numberOfPoints[1] = numberOfPoints[0];
    numberOfPoints[0] = points;
    //After ever 100 counts, randomise movement
    if (count == 1) {
      //Each object is given a random direction
      randMove = round(random(0, 3));
      divide = round(random(2, 16));
      curve = round(random(2, 10));
      randomDiameter =  round(random(10, 20));
      lowerD = randomDiameter - 2;
    }

    //Calculate the direction the 'head' will be moving in
    if (noteON == 0) {
      //Random number to slightly move the hovering circle
      float p = random(lowerD, randomDiameter);
      xDirection += cos(TWO_PI*count/10)*p; 
      yDirection += sin(TWO_PI*count/10)*p;
    } else if (noteON == 1) {

      if (randMove ==0) {
        float p = random(-5, 5);
        //      xDirection += sin(TWO_PI*count/10)*count + p;
        //      yDirection += 2;
        xDirection += cos((TWO_PI/divide)*count/10)*curve; 
        yDirection += sin((TWO_PI/divide)*count/10)*curve;
      } else if (randMove ==1) {
        float p = random(-5, 5);
        //      xDirection += sin(TWO_PI*count/10)*count + p;
        //      yDirection -= 2;  
        xDirection -= cos((TWO_PI/divide)*count/10)*curve; 
        yDirection += sin((TWO_PI/divide)*count/10)*curve;
      } else if (randMove ==2) {
        float p = random(-5, 5);
        //      xDirection += 2;
        //      yDirection += sin(TWO_PI*count/10)*count + p;
        xDirection += cos((TWO_PI/divide)*count/10)*curve; 
        yDirection -= sin((TWO_PI/divide)*count/10)*curve;
      } else if (randMove ==3) {
        float p = random(-5, 5);
        //      xDirection -= 2;
        //      yDirection += sin(TWO_PI*count/10)*count + p;
        xDirection -= cos((TWO_PI/divide)*count/10)*curve; 
        yDirection -= sin((TWO_PI/divide)*count/10)*curve;
      }
    }

    //Determine whether the array needs extending or shrinking
    if (numberOfPoints[0] > numberOfPoints[1]) {
      largerArray();
    } else if (numberOfPoints[0] < numberOfPoints[1]) {
      smallerArray();
    } else {
      if (largerUsed == true) {
        standardLargeArray();
      } else if (smallerUsed == true) {
        standardSmallArray();
      } else {
        standardLargeArray();
      }
    }

    //Restart counter after 10
    if (count == 100) {
      count = 1;
    } else {
      count++;
    }
  }

  //Function that increases the size of the array and stores values
  void largerArray() {
    //Increase number of points in array

      //If the last array used was the smaller one, copy data to new array
    if (smallerUsed == true) {
      xArray = new float[points +1]; 
      yArray = new float[points +1]; 
      //Copy data from smaller array into new larger ones
      arrayCopy(newXArray, 0, xArray, 0, numberOfPoints[1]); 
      arrayCopy(newYArray, 0, yArray, 0, numberOfPoints[1]);

      //If a load of new points have been added, make them equal to the last point with a value thats not 0
      for (int i=numberOfPoints[1]; i<points; i++) {
        if (numberOfPoints[1]>0) {
          xArray[i] = xArray[(numberOfPoints[1]-1)];
          yArray[i] = yArray[(numberOfPoints[1]-1)];
        } else {
          xArray[i] = xArray[numberOfPoints[1]];
          yArray[i] = yArray[numberOfPoints[1]];
        }
      }
    } else {
      //Create two buffer arrays used to temporarly store data
      float[] bufferXArray = new float[numberOfPoints[1]]; //Size of the previous number of points
      float[] bufferYArray = new float[numberOfPoints[1]]; 

      //Copy the 'newArray' to a 'bufferArray'
      for (int i=0; i<numberOfPoints[1]; i++) {
        bufferXArray[i] = xArray[i]; 
        bufferYArray[i] = yArray[i];
      }

      //Format 'newArray' with less elements
      xArray = new float[points +1]; 
      yArray = new float[points +1]; 

      //Copy old data into the formatted array but with 1 less element
      arrayCopy(bufferXArray, 0, xArray, 0, numberOfPoints[1]); 
      arrayCopy(bufferYArray, 0, yArray, 0, numberOfPoints[1]);

      //If a load of new points have been added, make them equal to the last point with a value thats not 0
      for (int i=numberOfPoints[1]; i<points; i++) {
        if (numberOfPoints[1] > 0) {
          xArray[i] = xArray[(numberOfPoints[1]-1)];
          yArray[i] = yArray[(numberOfPoints[1]-1)];
        } else {
          xArray[i] = xArray[numberOfPoints[1]];
          yArray[i] = yArray[numberOfPoints[1]];
        }
      }
    }

    //Save the previous positions of the 'head' along the array
    for (int i = 0; i<points; i++) {
      xArray[points-i] = xArray[points-(i+1)];
      yArray[points-i] = yArray[points-(i+1)];
    }
    //Calculate new 'Head' position
    xArray[0] = xDirection; 
    yArray[0] = yDirection; 

    //State which array was last used
    largerUsed = true; 
    smallerUsed = false;
  }

  //Function that shrinks the array and stores new values
  void smallerArray() {
    //If last array used was the larger one copy old data to new array
    if (largerUsed == true) {
      //Create new arrays with new 'points value'
      newXArray = new float[points +1]; 
      newYArray = new float[points +1]; 

      //Fill with almost all data from old array
      arrayCopy(xArray, 0, newXArray, 0, points); 
      arrayCopy(yArray, 0, newYArray, 0, points);
    } else {  
      //Create two buffer arrays used to temporarly store data
      float[] bufferXArray = new float[points+1]; 
      float[] bufferYArray = new float[points+1]; 
      //Copy the 'newArray' to a 'bufferArray'
      for (int i=0; i<points; i++) {
        bufferXArray[i] = newXArray[i]; 
        bufferYArray[i] = newYArray[i];
      }
      //Format 'newArray' with less elements
      newXArray = new float[points +1]; 
      newYArray = new float[points +1]; 

      //Copy old data into the formatted array but with 1 less element
      arrayCopy(bufferXArray, 0, newXArray, 0, points); 
      arrayCopy(bufferYArray, 0, newYArray, 0, points);
    }

    //Save the previous positions of the 'head' along the array
    for (int i = 0; i< points; i++) {
      newXArray[points-i] = newXArray[points-(i+1)]; 
      newYArray[points-i] = newYArray[points-(i+1)];
    }

    //Calculate 'Head' position
    newXArray[0] = xDirection; 
    newYArray[0] = yDirection;

    //State which array was last used
    smallerUsed = true; 
    largerUsed = false;
  }

  //Function that updates the array ones it has grown
  void standardLargeArray() {
    for (int i = 0; i<points; i++) {
      xArray[points-i] = xArray[points-(i+1)]; 
      yArray[points-i] = yArray[points-(i+1)];
    }
    //Calculate 'Head' position
    xArray[0] = xDirection; 
    yArray[0] = yDirection;
  }

  //Function that updates the array ones it has shrunk
  void standardSmallArray() {
    for (int i = 0; i<points; i++) {
      newXArray[points-i] = newXArray[points-(i+1)]; 
      newYArray[points-i] = newYArray[points-(i+1)];
    }
    //Calculate 'Head' position
    newXArray[0] = xDirection; 
    newYArray[0] = yDirection;
  }

  //THIS ONES PRETTY SICK BRO with black background
  void drawShape() {
    if (colorBright == 1) {
      colorMode(HSB, 360);
    } else if (colorBright == 2) {
      colorMode(HSB, 360, 100, 100);
    }
    if (choice == 4 || squigles1Y > 0 - canY && squigles1Y < canY) {
      Squigles1.beginDraw();
      if (colorBright == 1) {
        Squigles1.colorMode(HSB, 360);
      } else if (colorBright == 2) {
        Squigles1.colorMode(HSB, 360, 100, 100);
      }
      Squigles1.stroke(xDirection, yDirection, 100);
      Squigles1.strokeWeight(2);
      Squigles1.beginShape(); 
      if (largerUsed == true) {
        for (int i=0; i<xArray.length; i++) {
          Squigles1.curveVertex(xArray[i], yArray[i]);
        }
      } else if (smallerUsed == true) {
        for (int x=0; x<newXArray.length; x++) {
          Squigles1.curveVertex(newXArray[x], newYArray[x]);
        }
      } else {
        for (int i=0; i<xArray.length; i++) {
          Squigles1.curveVertex(xArray[i], yArray[i]);
        }
      }
      Squigles1.endShape();
      Squigles1.endDraw();
      image(Squigles1, squigles1X, squigles1Y);
    } else if (choice == 5) {
      if (colorBright == 1) {
        Squigles2.colorMode(HSB, 360);
      } else if (colorBright == 2) {
        Squigles2.colorMode(HSB, 360, 100, 100);
      }
      Squigles2.beginDraw();
      backCount = 0;
      int xColour = round(map(xDirection, 0, canX, 0, 360));
      Squigles2.stroke(xColour, xColour, 100); 
      Squigles2.strokeWeight(2);
      // fill(xDirection,yDirection,100);
      Squigles2.beginShape(); 
      if (largerUsed == true) {
        for (int i=0; i<xArray.length; i++) {
          Squigles2.curveVertex(xArray[i], yArray[i]);
        }
      } else if (smallerUsed == true) {
        for (int x=0; x<newXArray.length; x++) {
          Squigles2.curveVertex(newXArray[x], newYArray[x]);
        }
      } else {
        for (int i=0; i<xArray.length; i++) {
          Squigles2.curveVertex(xArray[i], yArray[i]);
        }
      }
      Squigles2.endShape();
      Squigles2.endDraw();
      image(Squigles2, squigles2X, squigles2Y);
    } else if (choice == 6 || choice == 8) {
      Squigles3.beginDraw();
      if (colorBright == 1) {
        Squigles3.colorMode(HSB, 360);
      } else if (colorBright == 2) {
        Squigles3.colorMode(HSB, 360, 100, 100);
      }
      backCount = 0;
      int xColour = round(map(xDirection, 0, canX, 0, 360));
      Squigles3.noStroke();
      //stroke(xColour, xColour, 100); 
      //strokeWeight(2);
      Squigles3.fill(xColour, 100, 100, 50);
      Squigles3.beginShape(); 
      if (largerUsed == true) {
        for (int i=0; i<xArray.length; i++) {
          Squigles3.curveVertex(xArray[i], yArray[i]);
        }
      } else if (smallerUsed == true) {
        for (int x=0; x<newXArray.length; x++) {
          Squigles3.curveVertex(newXArray[x], newYArray[x]);
        }
      } else {
        for (int i=0; i<xArray.length; i++) {
          Squigles3.curveVertex(xArray[i], yArray[i]);
        }
      }
      Squigles3.endShape();
      Squigles3.endDraw();
      image(Squigles3, squigles3X, squigles3Y);
    }
  }

  /*These are currently not being used */
  float getPosX() {
    return xArray[0];
  }

  float getPosY() {
    return yArray[0];
  }

  void edgeCheck() {
    if (xDirection <= 0) {
      xDirection = 0;
    } else if (yDirection <= 0) {
      yDirection = 0;
    } else if ( xDirection >= squigleCanX)
    {
      xDirection = squigleCanX;
    } else if (yDirection >= squigleCanY) {
      yDirection = squigleCanY;
    }

    //        //Calculate whether the points have 'gone through a wall'
    //     if(xDirection > canX){
    //      xDirection -= canX; 
    //     } else if (xDirection < 0){
    //      xDirection += canX; 
    //     }
    //     
    //     if(yDirection > canY){
    //       yDirection -= canY;
    //     } else if (yDirection < 0){
    //       yDirection += canY;
    //     }
  }

  void setRange(int MinPitch, int MaxPitch, int MinDuration, int MaxDuration) {
    minPitch = MinPitch;
    maxPitch = MaxPitch;
    minDuration = MinDuration;
    maxDuration = MaxDuration;
  }
}

