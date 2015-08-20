class PaddleLeft {
  float posY;
  float posX;
  int inc = 5;
  color col;

  //Constructor
  PaddleLeft(float iPosX, float iPosY) {
    posX = iPosX;
    posY = iPosY;
  }

  void drawPad() {
    if (check == 1) {
      if (keyCode == UP) {
        inc = -10;
      } else if (keyCode == DOWN) {
        inc = 10;
      } else {
        inc = 0;
      }
    } else if (check == 0) {
      inc = 0;
    }

    posY += inc;
    rectMode(CENTER);
    fill(255, 0, 0);
    rect(posX, posY, 10, 50);

    //Prevent paddels from leaving screen
    if (posY < 0) {
      posY = 0;
    } else if (posY > canY) {
      posY = canY;
    }
  }

  void setY(float Y) {
    posY = Y;
  }

  float getX() {
    return posX;
  }

  float getY() {
    return posY;
  }
}

