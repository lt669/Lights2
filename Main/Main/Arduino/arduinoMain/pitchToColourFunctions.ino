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
//  cueArray[0] = 0;
//  cueArray[1] = 68000;
//  cueArray[2] = 180000;
//  cueArray[3] = 240000;
//  cueArray[4] = 300000;
//  cueArray[5] = 408000;
//  cueArray[6] = 496000;
//  cueArray[7] = 564000;
//  cueArray[8] = 624000;
//  cueArray[9] = 708000;
//  cueArray[10] = 768000;
//  cueArray[11] = 830000;
//  cueArray[12] = 856000;
//  cueArray[13] = 916000;
//  cueArray[14] = 930000;
//  cueArray[15] = 955000;
//  cueArray[16] = 1000000;
//  cueArray[17] = 1036000;
//  cueArray[18] = 1100000;
//  cueArray[19] = 1140000;
//  cueArray[20] = 1216000;

  // cueArray[0] = 0;
  // cueArray[1] = 68;
  // cueArray[2] = 180;
  // cueArray[3] = 240;
  // cueArray[4] = 300;
  // cueArray[5] = 408;
  // cueArray[6] = 496;
  // cueArray[7] = 564;
  // cueArray[8] = 624;
  // cueArray[9] = 708;
  // cueArray[10] = 768;
  // cueArray[11] = 830;
  // cueArray[12] = 856;
  // cueArray[13] = 916;
  // cueArray[14] = 930;
  // cueArray[15] = 955;
  // cueArray[16] = 1000;
  // cueArray[17] = 1036;
  // cueArray[18] = 1100;
  // cueArray[19] = 1140;
  // cueArray[20] = 1216;

  cueArray[0] = 0;
  cueArray[1] = 5;
  cueArray[2] = 35;
  cueArray[3] = 40;
  cueArray[4] = 45;
  cueArray[5] = 50;
  cueArray[6] = 55;
  cueArray[7] = 60;
  cueArray[8] = 65;
  cueArray[9] = 70;
 cueArray[10] = 111;
 cueArray[11] = 161;
 cueArray[12] = 166;
 cueArray[13] = 171;
 cueArray[14] = 176;
 cueArray[15] = 201;
 cueArray[16] = 206;
 cueArray[17] = 211;
 cueArray[18] = 216;
 cueArray[19] = 221;
 cueArray[20] = 226;

//  cueArray[0] = 0;
//  cueArray[1] = 1;
//  cueArray[2] = 2;
//  cueArray[3] = 3;
//  cueArray[4] = 4;
//  cueArray[5] = 5;
//  cueArray[6] = 6;
//  cueArray[7] = 7;
//  cueArray[8] = 8;
//  cueArray[9] = 9;
//  cueArray[10] = 10;
//  cueArray[11] = 11;
//  cueArray[12] = 12;
//  cueArray[13] = 13;
//  cueArray[14] = 14;
//  cueArray[15] = 15;
//  cueArray[16] = 16;
//  cueArray[17] = 17;
//  cueArray[18] = 18;
//  cueArray[19] = 19;
//  cueArray[20] = 20;
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
  int address = 1;
  int z;
  for(z = 1; z<7; z++){ //make 7, don't use first
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
//int  smallAddress = 98;
//int x;
//  for(x=6;x<12;x++){
//    redArray[x] = smallAddress;
//    greenArray[x] = smallAddress + 1;
//    blueArray[x] = smallAddress + 2;
//    whiteArray[x] = smallAddress + 3;
//
//    smallAddress += 4;
//  }
  
int address1 = 85;
int address2 = 88;
int address3 = 91;
int address4 = 94;
int address5 = 97;
int address6 = 100;

  redArray[7] = address1;
  greenArray[7] = address1 + 1;
  blueArray[7] = address1 + 2;

  redArray[8] = address2;
  greenArray[8] = address2 + 1;
  blueArray[8] = address2 + 2;

  redArray[9] = address3;
  greenArray[9] = address3 + 1;
  blueArray[9] = address3 + 2;

  redArray[10] = address4;
  greenArray[10] = address4 + 1;
  blueArray[10] = address4 + 2;

  redArray[11] = address5;
  greenArray[11] = address5 + 1;
  blueArray[11] = address5 + 2;
  
  redArray[12] = address6;
  greenArray[12] = address6 + 1;
  blueArray[12] = address6 + 2;

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
