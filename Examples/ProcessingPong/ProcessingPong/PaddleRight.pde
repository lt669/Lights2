class PaddleRight {

  float posY;
  float posX; 

  //Constructor
  PaddleRight(float iPosX, float iPosY) {
    posX = iPosX;
    posY = iPosY;
  }

  void drawPad() {
    posY = ball.getY();
    rectMode(CENTER);
    fill(255, 0, 0);
    rect(posX, posY, 10, 50);
  }

  float getX() {
    return posX;
  }

  float getY() {
    return posY;
  }
}

