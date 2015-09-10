class reverbRings {

  int xPos;
  int yPos;
  int r; //radius
  int alpha;
  boolean reverbGo = false;

  //Constructor
  reverbRings(int iXPos, int iYPos, int iR, int iAlpha) {
    xPos = iXPos;
    yPos = iYPos;
    r = iR;
    alpha = iAlpha;
  }

  void drawRings(boolean reverb) {

    if (reverb == true) {
      reverbGo = true;
    }

    if (reverbGo == true) {
      r += 2;
      alpha -= 1;

      if (alpha <= 0) {
        r = 0;
        alpha = 100;
        reverbGo = false;
      }
    }

    stroke(0, 0, 0, alpha);
    fill(0, 0, 0, 0);
    beginShape();
    for (int i = 0; i < r; i++) {
      float x = cos(radians(i*360/r))*r;
      float y = sin(radians(i*360/r))*r;
      vertex(x+xPos, y+yPos);
    }
    endShape(CLOSE);
  }
}

