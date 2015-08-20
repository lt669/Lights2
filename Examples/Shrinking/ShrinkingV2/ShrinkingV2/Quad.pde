class Quad {

  int xPos, yPos;
  int xSize, ySize;
  int chooseStart = 0; //Start at 2 to keep starting square in place
  int elements = 1;
  int[][] shapesArray = new int[elements][8];
  int i = 0;
  int e = 0;

  int right = 0;
  int down = 1;
  int left = 2;
  int up = 3;

  int movement = right;
  boolean reChoose = false;


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

  void doQuad() {
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

    drawQuad(); //Draw all previously calculated shapes
    extendArray(); // Add an extra element to the array
    //    println("\nStart Movement", movement);
    calcSize(); //Calculate the size of all the shapes
    chooseDirection(); // Calculate how the next shape will be drawn
    println("movement: ", movement);
    //Black marker where next starting point is
    fill(0, 0, 0);
    rect(shapesArray[e+1][xPosition], shapesArray[e+1][yPosition], 7, 5);
    calcPosition(); //Test to see whether the shape can be drawn in this direction
    println("movement2: ", movement);
    //    print("\nreChoose: ", reChoose);
    if (reChoose == true) {
      println("Rechoosing");
      if(movement == 0){
        movement += 2;
      }else{
      movement -= 2; //Draw in the same direction again
      }
      println("new Movment: ", movement);
      chooseDirection(); //Draw new shape in same as previous direction
    }


    //GREEN marker where next starting point is
    fill(0, 255, 0);
    rect(shapesArray[e+1][xPosition], shapesArray[e+1][yPosition], 5, 7);
    //  shapesArray[e+1][Choose] = movement-1;

    if (shapesArray[e+1][Choose] == -1) {
      shapesArray[e+1][Choose] = 3;
    }
    //    print(" - End Movement ", movement);
    e++; //Increment number of elements in array

    for (i=0; i<shapesArray.length; i++) {
      // println("i: "+i+" xPos: "+shapesArray[i][xPosition]+" yPos: "+shapesArray[i][yPosition]+" xSize: "+shapesArray[i][sizeX]+" ySize: "+shapesArray[i][sizeY]+" Choose: "+ shapesArray[i][Choose]);
    }
  }


  void drawQuad() {
    //Loop through array and draw all new shapes
    for (int x=0; x<shapesArray.length; x++) { 
      noStroke();
      fill(shapesArray[x][Hue], shapesArray[x][Saturation], shapesArray[x][Brightness]);
      rect(shapesArray[x][xPosition], shapesArray[x][yPosition], shapesArray[x][sizeX], shapesArray[x][sizeY]);
    }
    //Draw red mark at starting point
    stroke(0);
    fill(360, 100, 100);
    rect(shapesArray[e][xPosition], shapesArray[e][yPosition], 5, 5);
  }

  void extendArray() {
    //Create buffer array
    int[][] bufferArray = new int[shapesArray.length][8];

    //Copy stuff into the buffer array
    for (int x=0; x<shapesArray.length; x++) {
      for (int i=0; i<8; i++) {
        bufferArray[x][i] = shapesArray[x][i];
      }
    }

    //Reformat the shapesArray and add an element
    shapesArray = new int[e+2][8]; // +2 as we need 1 extra element, and array adresses start at 0, but declaring the size starts at 1

    //Copy elements back into shapesArray
    for (int x=0; x<bufferArray.length; x++) {
      for (int i=0; i<8; i++) {
        shapesArray[x][i] = bufferArray[x][i];
      }
    }
  }

  void calcSize() {
    //Calculate new size of the previously drawn shapes
    for (i=0; i<shapesArray.length - 1; i++) { 
      //Alter size in X direction
      if (shapesArray[i][sizeX] == 0) {
        //Do nothing, eventually delete the information from the array
      } else if (shapesArray[i][Choose] == left) {//This is due to the size of the shape being inverted
        shapesArray[i][sizeX] -= 1; //Changed from '+' to '-'
      } else {
        shapesArray[i][sizeX] -= 1;
      }
      //Alter size in Y direction
      if (shapesArray[i][sizeY] == 0) {
        //Do nothing
      } else if (shapesArray[i][Choose] == up) {//This is due to the size of the shape being inverted
        shapesArray[i][sizeY] -= 1; //Changed from '+' to '-'
      } else {
        shapesArray[i][sizeY] -= 1;
      }
    }

    //Random size varioables
    xSize = round(random(20, 25));
    ySize = round(random(20, 25));

    //Calculate size of the NEW shape
    shapesArray[e+1][sizeX] = xSize;
    shapesArray[e+1][sizeY] = ySize;

    //Calculate where the pervious shapes will be drawn
    for (i=0; i<shapesArray.length-1; i++) {
      //Calculae new xPosition
      if (shapesArray[i][xPosition] > canX/2) {
        shapesArray[i][xPosition] -= 1;
      } else if (shapesArray[i][xPosition] < canX/2) {
        shapesArray[i][xPosition] += 1;
      }

      //Calculae new yPosition
      if (shapesArray[i][yPosition] > canY/2) {
        shapesArray[i][yPosition] -= 1;
      } else if (shapesArray[i][yPosition] < canY/2) {
        shapesArray[i][yPosition] += 1;
      }
    }
  }

  void chooseDirection() {
    //Decide where the starting point of the shape will be based on whether it will fit
    if (movement == right) {
      Right();
    } else if (movement == down) {
      Down();
    } else if (movement == left) {
      Left();
    } else if (movement == up) {
      Up();
    }
  }

  void calcPosition() {
    reChoose = false;

//    for (i=0; i<shapesArray.length; i++) {
//      println("x "+shapesArray[i][xPosition]+" -> "+(shapesArray[i][xPosition]+shapesArray[i][sizeX])+" y "+shapesArray[i][yPosition]);
//    }

    //For the current shape, check whether any of the pixles within the shape fall within the area of any of the other shapes
    for (int y = shapesArray[e+1][yPosition]; y< (shapesArray[e+1][yPosition]+shapesArray[e+1][sizeY]); y++) {
      for (int x = shapesArray[e+1][xPosition]; x< (shapesArray[e+1][xPosition]+shapesArray[e+1][sizeX]); x++) {
        for (int i=0; i<shapesArray.length - 1; i++) {  //Dont check against itself
          //  for (int i=shapesArray.length-1; i > 0; i--) {  //Dont check against itself
          if (x > shapesArray[i][xPosition] && x < shapesArray[i][xPosition] + shapesArray[i][sizeX] && y > shapesArray[i][yPosition] && y < shapesArray[i][yPosition] + shapesArray[i][sizeY]) {
            //   if (shapesArray[e+1][xPosition] + shapesArray[e+1][sizeX] >= shapesArray[i][xPosition] && shapesArray[e+1][xPosition] + shapesArray[e+1][sizeX] <= shapesArray[i][xPosition] + shapesArray[i][sizeX] && shapesArray[e+1][yPosition] + shapesArray[e+1][sizeY] >= shapesArray[i][yPosition] && shapesArray[e+1][yPosition] + shapesArray[e+1][sizeY] <= shapesArray[i][yPosition] + shapesArray[i][sizeY]) {
            reChoose = true; //Choose a different direction
            //Debugging rectangle
            stroke(330, 34, 100);
            fill(360, 100, 100);
            rect(x, y, 1, 1);
            // println("X collision");
            //println("["+i+"/"+e+"]: "+ shapesArray[i][xPosition] +"," +shapesArray[i][yPosition] + "->" + (shapesArray[i][xPosition]+shapesArray[i][sizeX]) +"," + (shapesArray[i][yPosition]+shapesArray[i][sizeY]) + " - " + shapesArray[e][xPosition] + "," + shapesArray[e][yPosition] + "->" + (shapesArray[e][xPosition]+shapesArray[e][sizeX]) + "," + (shapesArray[e][yPosition]+shapesArray[e][sizeY]));
            //  println("x: " + x + " y: " + y);
          }
        }
      }
      //
      //      if (shapesArray[e+1][yPosition] + shapesArray[e+1][sizeY] >= shapesArray[i][yPosition] && shapesArray[e+1][yPosition] + shapesArray[e+1][sizeY] <= shapesArray[i][yPosition] + shapesArray[i][sizeY]) { 
      //        movement -= 1; //Draw in the same direction again
      //        println("Y collision");
      //      }
    }
    if (movement <= -1) {
      movement = up;
    } else {
      movement += 1;
    }
    if (movement == 4) {
      //Start from the begining
      movement = right;
    }
  }

  void printArray() {
    println("");
    for (int i=0; i<shapesArray.length-1; i++) {//Might need to +1
      println(""+i+" x: "+shapesArray[i][xPosition]+" y: " +shapesArray[i][yPosition]+" xEnd: " +(shapesArray[i][xPosition]+shapesArray[i][sizeX])+" yEnd: "+(shapesArray[i][yPosition]+shapesArray[i][sizeY] + " Choose: "+ shapesArray[i][Choose]));
    }
  }


  void Right() {
    println("Drawing Right");
    if (movement == right) {
      shapesArray[e+1][xPosition] = shapesArray[e][xPosition] + shapesArray[e][sizeX];
      shapesArray[e+1][yPosition] = shapesArray[e][yPosition];
    } else if (shapesArray[e][Choose] == up) {
      shapesArray[e+1][xPosition] = shapesArray[e][xPosition];
      shapesArray[e+1][yPosition] = shapesArray[e][yPosition] + shapesArray[e][sizeY];
    }
  }

  void Down() {
    println("Drawing Down");
    if (shapesArray[e][Choose] == 1) {
      shapesArray[e+1][xPosition] = shapesArray[e][xPosition] - shapesArray[e+1][sizeX] ;
      shapesArray[e+1][yPosition] = shapesArray[e][yPosition];
    } else {    
      shapesArray[e+1][xPosition] = shapesArray[e][xPosition];
      shapesArray[e+1][yPosition] = shapesArray[e][yPosition] + shapesArray[e][sizeY];
    }
  }

  void Left() {
    //If the previous movement was also left
    //    if (shapesArray[e][Choose] == 2)
    if (movement == 2) {
      println("Drawing Left");
      shapesArray[e+1][xPosition] = shapesArray[e][xPosition] - shapesArray[e+1][sizeX] ;
      shapesArray[e+1][yPosition] = shapesArray[e][yPosition];
      //Draw ANOTHER
      fill(0);
      ellipse(shapesArray[e+1][xPosition], shapesArray[e+1][yPosition], 5, 5);
    }
    //    shapesArray[e+1][xPosition] = shapesArray[e][xPosition];
    //    shapesArray[e+1][yPosition] = shapesArray[e][yPosition];
    //    //    shapesArray[e+1][sizeX] = -(shapesArray[e][sizeX]); //THIS MAY NOT BE CORRECT
    //    //    shapesArray[e+1][sizeY] = -(shapesArray[e][sizeY]);
    //
    //    shapesArray[e+1][sizeX] = shapesArray[e+1][sizeX] - (shapesArray[e+1][sizeX])*2;
    //    shapesArray[e+1][sizeY] = shapesArray[e+1][sizeY];// - (shapesArray[e+1][sizeY])*2;
  }

  void Up() {
    println("Drawing Up");
    if (shapesArray[e][Choose] == up) {
      shapesArray[e+1][xPosition] = shapesArray[e][xPosition];
      shapesArray[e+1][yPosition] = shapesArray[e][yPosition] + shapesArray[e][sizeY];
//      shapesArray[e+1][sizeX] = shapesArray[e+1][sizeX];// - (shapesArray[e+1][sizeX])*2;
//      shapesArray[e+1][sizeY] = shapesArray[e+1][sizeY] - (shapesArray[e+1][sizeY])*2;
    } else {
      shapesArray[e+1][xPosition] = shapesArray[e][xPosition];
      shapesArray[e+1][yPosition] = shapesArray[e][yPosition] - shapesArray[e+1][sizeY] ;// + shapesArray[e][sizeY]; // THIS SIGN MIGHT NEED CHANGING
//      shapesArray[e+1][sizeX] = shapesArray[e+1][sizeX];// - (shapesArray[e+1][sizeX])*2;
//      shapesArray[e+1][sizeY] = shapesArray[e+1][sizeY] - (shapesArray[e+1][sizeY])*2;
    }
  }
}

