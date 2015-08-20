class Ball {

  int posX;
  int posY;
  int size;
  color col;
  float incX;
  float incY;
  boolean fail;

  //Constructor
  Ball(int iPosX, int iPosY, int iSize, float iIncX, float iIncY) {

    posX = iPosX;
    posY = iPosY;
    size = iSize;
    incX = iIncX;
    incY = iIncY;
  }

  void drawBall() {
    fill(0, 0, 255);
    ellipse(posX, posY, size, size);
  }

  void moveBall() {


    if (posX >= RightPad.getX() && posX <= RightPad.getX() + (incX + 1)) {
      if (posY <= RightPad.getY() + 25 && posY >= RightPad.getY() - 25) {
        incX = -incX;
      }
    } else if (posX <= LeftPad.getX() && posX >= LeftPad.getX() - (incX -1)) {
      if (posY <= RightPad.getY() + 25 && posY >= RightPad.getY() - 25) {
        incX = -incX;
      }
    }
    else{
    }
    
       //Check if ball collides top or bottom
    if (posY < 0 || posY > canY) {
      incY = -incY;
    } else if (posX < LeftPad.getX() - 25) {
      fail = true;
    } else {
      fail = false;
    }
    
    posX += incX;
    posY += incY;
  }

  boolean getFail() {
    return fail;
  }

  int getY() {
    return posY;
  }

  //Reset the ball once compter has scored
  void reset() {
    posX = canX/2;
    posY = canY/2;
  }
} 

