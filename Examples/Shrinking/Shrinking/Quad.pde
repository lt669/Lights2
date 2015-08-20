class Quad {

  int xPos, yPos;
  int xSize, ySize;
  int chooseStart = 0; //Start at 2 to keep starting square in place
  int elements = 1;
  int[][] shapesArray = new int[elements][8];
  int i = 0;
  int e = 0;

  //Array addresses
  int xPosition = 0;
  int yPosition = 1;
  int sizeX = 2;
  int sizeY = 3;
  int Hue = 4;
  int Saturation = 5;
  int Brightness = 6;
  int Choose = 7;


  //Constructor
  Quad(int iXPos, int iYPos, int iSize) {
    xPos = iXPos;
    yPos = iYPos;
    xSize = ySize = iSize;

    //Set initial conditions in array
    shapesArray[e][xPosition] = xPos;
    shapesArray[e][yPosition] = yPos;
    shapesArray[e][sizeX] = xSize;
    shapesArray[e][sizeY] = ySize;
  }

  void drawQuad() {
    
    //Set randomised colours
    colorMode(HSB, 360, 100, 100, 100);
    int hue = round(random(0, 360));
    int sat = round(random(0, 100));
    int bri = round(random(0, 100));
    int alpha = 100; //round(random(0, 100));

    //Store varying elements into array
    shapesArray[e][Hue] = hue;
    shapesArray[e][Saturation] = sat;
    shapesArray[e][Brightness] = bri;
    shapesArray[e][Choose] = chooseStart;

    //Loop through array and draw all new shapes
    for (int x=0; x<shapesArray.length; x++) { 
      noStroke();
      fill(shapesArray[x][Hue], shapesArray[x][Saturation], shapesArray[x][Brightness],alpha);
      rect(shapesArray[x][xPosition], shapesArray[x][yPosition], shapesArray[x][sizeX], shapesArray[x][sizeY]);
    }

    //Create buffer array
    int[][] bufferArray = new int[shapesArray.length][8];

    //Copy stuff into the buffer array
    for (int x=0; x<shapesArray.length; x++) {
      for (int i=0; i<8; i++) {
        bufferArray[x][i] = shapesArray[x][i];
      }
    }

    //Reformat the shapesArray and add an element
    shapesArray = new int[e+2][8];

    //Copy elements back into shapesArray
    for (int x=0; x<bufferArray.length; x++) {
      for (int i=0; i<8; i++) {
        shapesArray[x][i] = bufferArray[x][i];
      }
    }

    //Calculate new size of the shapes
    for (i=0; i<shapesArray.length - 1; i++) { 
      if (shapesArray[i][sizeX] == 0) {
        //Do nothing
      } else {
        shapesArray[i][sizeX] -= 1;
      }

      if (shapesArray[i][sizeY] == 0) {
        //Do nothing
      } else {
        shapesArray[i][sizeY] -= 1;
      }
    }

    //Random size varioables
    xSize = round(random(20, 50));
    ySize = round(random(20, 50));

    //Calculate size of the NEW shape
    shapesArray[e+1][sizeX] = xSize;
    shapesArray[e+1][sizeY] = ySize;
  
    //Randomly selects where to start drawing the rectagles
    chooseStart = round(random(0, 1));
    shapesArray[e+1][Choose] = chooseStart;


    //Calculate the new position of all the shapes
    for (i=0; i<shapesArray.length - 1; i++) {
      if (shapesArray[i+1][Choose] == 0) {
        //Change the xPosition
        shapesArray[i+1][xPosition] = shapesArray[i][xPosition] + shapesArray[i][sizeX];
        shapesArray[i+1][yPosition] = shapesArray[i][yPosition];
      } else if (shapesArray[i+1][Choose] == 1) {
        //Change the yPosition
        shapesArray[i+1][yPosition] = shapesArray[i][yPosition] + shapesArray[i][sizeY];
        shapesArray[i+1][xPosition] = shapesArray[i][xPosition];
      } else {//Keeps first square in place
      }
    }

//    if (chooseStart == 0) {
//      shapesArray[e+1][xPosition] = shapesArray[e][xPosition] + shapesArray[e][sizeX];
//    } else if (chooseStart == 1) {
//      shapesArray[e+1][yPosition] = shapesArray[e][yPosition] + shapesArray[e][sizeY];
//    }

    e++;

    for (i=0; i<shapesArray.length; i++) {
     // println("i: "+i+" xPos: "+shapesArray[i][xPosition]+" yPos: "+shapesArray[i][yPosition]+" xSize: "+shapesArray[i][sizeX]+" ySize: "+shapesArray[i][sizeY]+" Choose: "+ shapesArray[i][Choose]);
    }
  }
}

