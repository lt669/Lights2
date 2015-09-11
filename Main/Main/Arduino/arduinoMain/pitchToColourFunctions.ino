/*
This file contains most of the functions for converting
incoming signals from Processing and converting them to RGB
values. The functions also ensure that the lights slowly change
colour instead of jumping straight to the new RGB colour

All functions written by Lewis Thresh apart from H2R_HSBtoRGB which is
taken from the HSBColor.h file
*/

//#include "RGBVariables.h"
//#include "pitchToColourFunctions.h"

/*------------------------------Set Ranges------------------------------*/
void setRanges(){

  maxDuration[0] = 6500;
  maxDuration[1] = 5250;
  maxDuration[2] = 6000;
  maxDuration[3] = 6000;
  maxDuration[4] = 4250;
  maxDuration[5] = 7000;

  maxPitch[0] = 932;
  maxPitch[1] = 466;
  maxPitch[2] = 698;
  maxPitch[3] = 622;
  maxPitch[4] = 523;
  maxPitch[5] = 155;

  minPitch[0] = 349;
  minPitch[1] = 261;
  minPitch[2] = 261;
  minPitch[3] = 261;
  minPitch[4] = 261;
  minPitch[5] = 87;
}
/*------------------------------Set Ranges------------------------------*/

/*------------------------------Set Addresses------------------------------*/
void setAddresses(){
  int address = 1;
  int z;
  for(z = 0; z<9; z++){
  panArray[z] = address;
  tiltArray[z] = address + 1;
  movementSpeedArray[z] = address + 2;
  redArray[z] = address + 3;
  greenArray[z] = address + 4;
  blueArray[z] = address + 5;
  whiteArray[z] = address + 6;
  dimmerArray[z] = address + 9;
  shutterArray[z] = address + 10;

  address += 14;

  }
}
/*------------------------------Set Addresses------------------------------*/



/*------------------------------HSB to RGB Functions------------------------------*/

void RGBShift(int rgb[3], int rgbCompare[3]) {
  //Shift previous RGB values to another array
  rgb[0] = rgbCompare[0];
  rgb[1] = rgbCompare[1];
  rgb[2] = rgbCompare[2];
}

void mapHSB(int freq, int count, int count2, int HUE[14], int SAT[14], int BRI[14]) {
  //Maps
    HUE[count] = (int)map(freq, minPitch[count2], maxPitch[count2], 0, 360);
    int tempSat =  (int)map(freq, minPitch[count2], maxPitch[count2], 0, 100 /*100*/);
    int tempBri = (int)map(freq, minPitch[count2], maxPitch[count2], 0, 70 /*70*/);

    SAT[count] =  map(tempSat, 0, 360, 0, 360 /*100*/);
    BRI[count] =  map(tempBri, 0, 360, 0, 360 /*70*/);


//  /*-------FOR TESTING ONLY-------*/
//  HUE[count] = (int)map(freq, 0, 255, 0, 360);
//  SAT[count] =  (int)map(freq, 0, 255, 0, 100);
//  BRI[count] = (int)map(freq, 0, 255, 0, 70);
//  /*-------FOR TESTING ONLY-------*/
}
/*------------------------------HSB to RGB Functions------------------------------*/

/*------------------------------CompareRGB Functions------------------------------*/



int compareRed(int initialRed[3], int previousRed[3], int red) {
  if (initialRed[0] > previousRed[0]) {
    red += lightFaderSpeed;
  } else if (initialRed[0] < previousRed[0]) {
    red -= lightFaderSpeed;
  } else {
    red = red;
  }
  return red;
}

int compareGreen(int initialGreen[3], int previousGreen[3], int green) {
  if (initialGreen[1] > previousGreen[1]) {
    green += lightFaderSpeed;
  } else if (initialGreen[1] < previousGreen[1]) {
    green -= lightFaderSpeed;
  } else {
    green = green;
  }
  return green;
}

int compareBlue(int initialBlue[3], int previousBlue[3], int blue) {
  if (initialBlue[2] > previousBlue[2]) {
    blue += lightFaderSpeed;
  } else if (initialBlue[2] > previousBlue[2]) {
    blue -= lightFaderSpeed;
  } else {
    blue = blue;
  }
  return blue;
}

void compareRGB(int rgb[3], int rgbCompare[3], int targetArray[3]) {
  targetArray[0] = compareRed(rgb, rgbCompare, targetArray[0]);
  targetArray[1] = compareGreen(rgb, rgbCompare, targetArray[1]);
  targetArray[2] = compareBlue(rgb, rgbCompare, targetArray[2]);
}
/*------------------------------CompareRGB Functions------------------------------*/
