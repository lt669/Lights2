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

/*------------------------------Set Cues------------------------------*/
void setCues(){
  cueArray[0] = 0;
  cueArray[1] = 68000;
  cueArray[2] = 180000;
  cueArray[3] = 240000;
  cueArray[4] = 300000;
  cueArray[5] = 408000;
  cueArray[6] = 496000;
  cueArray[7] = 564000;
  cueArray[8] = 624000;
  cueArray[9] = 708000;
  cueArray[10] = 768000;
  cueArray[11] = 830000;
  cueArray[12] = 856000;
  cueArray[13] = 916000;
  cueArray[14] = 930000;
  cueArray[25] = 955000;
  cueArray[26] = 1000000;
  cueArray[27] = 1036000;
  cueArray[28] = 1100000;
  cueArray[29] = 1140000;
  cueArray[30] = 1216000;
}
/*------------------------------Set Cues------------------------------*/

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
void setLargeAddresses(){
  int address = 15;
  int z;
  for(z = 0; z<6; z++){
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

void setIncrement(){
  for(int i = 0;i<12;i++){
    increment[i] = 1;
  }
}

void setSmallAddresses(){

  //Must manually set adresses to skip out 101 - 104

  redArray[5] = 85;
  greenArray[5] = 86;
  blueArray[5] = 87;
  whiteArray[5] = 88;

  redArray[6] = 89;
  greenArray[6] = 90;
  blueArray[6] = 91;
  whiteArray[6] = 92;

  redArray[7] = 93;
  greenArray[7] = 94;
  blueArray[7] = 95;
  whiteArray[7] = 96;

  redArray[8] = 97;
  greenArray[8] = 98;
  blueArray[8] = 99;
  whiteArray[8] = 100;

  redArray[9] = 105;
  greenArray[9] = 106;
  blueArray[9] = 107;
  whiteArray[9] = 108;

  redArray[10] = 109;
  greenArray[10] = 110;
  blueArray[10] = 111;
  whiteArray[10] = 112;

  // int address = 85;
  // int z;
  // for(z = 6; z<12 ; z++){
  // redArray[z] = address;
  // greenArray[z] = address + 1;
  // blueArray[z] = address + 2;
  // whiteArray[z] = address + 3;

  // address += 4;

  // }
}
/*------------------------------Set Addresses------------------------------*/



/*------------------------------HSB to RGB Functions------------------------------*/

void RGBShift(int rgb[3], int rgbCompare[3]) {
  //Shift previous RGB values to another array
  rgb[0] = rgbCompare[0];
  rgb[1] = rgbCompare[1];
  rgb[2] = rgbCompare[2];
}

void mapHSB(int freq, int count, int count2/*, int HUE[14], int SAT[14], int BRI[14]*/) {
  //Maps
    hue[count] = (int)map(freq, minPitch[count2], maxPitch[count2], 0, 360);
    int tempSat =  (int)map(freq, minPitch[count2], maxPitch[count2], 0, 100 /*100*/);
    int tempBri = (int)map(freq, minPitch[count2], maxPitch[count2], 0, 70 /*70*/);

    sat[count] =  map(tempSat, 0, 360, 0, 360 /*100*/);
    bri[count] =  map(tempBri, 0, 360, 0, 360 /*70*/);


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
