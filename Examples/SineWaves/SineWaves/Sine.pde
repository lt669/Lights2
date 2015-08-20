/*
Code written using example from https://processing.org/examples/sinewave.html
 Edited by Lewis Thresh
 23/07/2015
 */

class Sine {
  int waveHeight = 100;
  int waveWidth = 250;
  int xSpacing = 5;
  float amp; //Amplitude of wave
  float freq; //Frequency of wave
  //float[] yValues; //Array to store the height values
  float[] yValues = new float[waveWidth/xSpacing];
  float theta = 0.0; //Starting angle
  int startPosX;
  int startPosY;


  //Constructor
  Sine(int iAmp, int iFreq, int iXStart, int iYStart) {
    amp = iAmp;
    freq = iFreq;
    startPosX = iXStart;
    startPosY = iYStart;
  } 

  void calcWave() {

    float dx = (TWO_PI / freq) * xSpacing; //Value to incremnt X
    theta += 0.02;

    //For every x value, calculate the y value using a sine function
    float x = theta;
    for (int i = 0; i < yValues.length; i++) {
      yValues[i] = sin(x)*amp;
      x += dx;
    }
  }

  void drawWave() {

    noStroke();
    fill(0);
    for (int x = 0; x < yValues.length; x++) {
      ellipse(x*xSpacing + startPosX, (waveHeight/2+yValues[x]) + startPosY, 5, 5);
    }
  }


  float getY() {
    return yValues[0] + startPosY;
  }
}


//  void getDuration(){
//    singer
//  }

