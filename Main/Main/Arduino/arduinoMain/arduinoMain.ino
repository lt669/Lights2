#include <HSBColor.h>
#include <RGBConverter.h>
#include <DmxMaster.h>

//Self written headers
#include "DMXAddresses.h"
#include "RGBVariables.h"

//#include <pitchToColourFunctions.h>
//#include "pitchToColourFunctions.c"



void setup() {

  Serial.begin(9600);
  Serial.write(1);//Send value to establish contact

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

void loop() {

  if(Serial.available()){
  while (Serial.available() >= /*4*/ 5) {// wait for 3 ints to arrive (Keep having to change this?)
    in[0] = Serial.parseInt(); //TAG
    in[1] = Serial.parseInt(); //pitch
    in[2] = Serial.parseInt(); //duration
    in[3] = Serial.parseInt(); //state
    in[4] = Serial.parseInt();//Run function (FOR TESTING ONLY!)
    Serial.write(1); //Tell processing we're done receiving data
  }

  //Sort incoming data
  if (in[0] == 1) {
    fre1 = in[1];
    dur1 = in[2];
    } else if (in[0] == 2) {
      fre2 = in[1];
      dur2 = in[2];
      } else if (in[0] == 3) {
        fre3 = in[1];
        dur3 = in[2];
        } else if (in[0] == 4) {
          fre4 = in[1];
          dur4 = in[2];
          } else if (in[0] == 5) {
            fre5 = in[1];
            dur5 = in[2];
            } else if (in[0] == 6) {
              fre6 = in[1];
              dur6 = in[2];
            }
    //Always store the state
    state = in[3]
    fucntion = in[4];

    Serial.print("in[0]: ");
    Serial.print(in[0]);
    Serial.print(" in[1]: ");
    Serial.print(in[1]);
    Serial.print(" in[2]: ");
    Serial.print(in[2]);
    Serial.print(" State: ");
    Serial.print(state);
    Serial.print(" function "); //FOR TESTING ONLY
    Serial.println(function);

  //Colour and movement calculations based on the state
  if (state == 1) {
    pitchToColourCalc(fre1,9,0,rgb9, compareRGB9, hue, sat, bri); //SingerPitch, Light, Singer, Light, (3 arrays to save the conversions to)
  }

}

//Run test function
if(function == 1){
  spin(panL1,tiltL1,speedL1,redL1,greenL1,blueL1,whiteL1, in[0], in[1], in[2]); //Light 1
} else if (fuction == 2){
  if(state == 1){
  spin(panL2,tiltL2,speedL2,redL2,greenL2,blueL2,whiteL2, in[0], in[1], in[2]); //Light 2
} else if (fuction == 3){
  if(state == 1){
  pitchToColourDisplay(rgb1, compareRGB1, displayRGB1);
}
}

  //Continously output to lights
  //writeToLights(redL1, greenL1, blueL1, displayRGB1);

  
}

void SerialEvent(){
//This doesn't really work
}

void circlesCopy() {
  //NOTE:Test lights will not have movement, so use hardcoded addresses
  for (int i = 0; i < 8; i++) {
    //Map the frequency and duration the same way it is in Processing - Circles
    hue[i] = int(map(fre1, minPitch[i], maxPitch[i], 0, 360));
    sat[i] =  int(map(fre1, minPitch[i], maxPitch[i], 0, 100));
    bri[i] = int(map(fre1, minPitch[i], maxPitch[i], 0, 70));
  }

  //Convert HSB to RGB
  
  H2R_HSBtoRGB(hue[0], sat[0], bri[0], rgb1);

  //Send to appropriate lights
  DmxMaster.write(redL1, rgb1[0]);
  DmxMaster.write(greenL1, rgb1[1]);
  DmxMaster.write(blueL1, rgb1[2]);

}


void pitchToColourCalc(int frequency, int light, int singer, int rgb[3], int rgbCompare[3], int hue[14], int sat[14], int bri[14]){

  //Map the frequency to color (using map)
  mapHSB(frequency,light,singer, hue, sat, bri); //SingerPitch, Light, Singer, (arrays to save data to)

  //Shift previous values of RGB (Before loading new ones in below)
  RGBShift(rgb, rgbCompare);

  //Convert HSB to RGB (Overwrites first three addresses of RGB)
  H2R_HSBtoRGB(hue[light], sat[light], bri[light], rgb); //Does it only write to first 3 addresses?
}


void writeToLights(int redAddress, int greenAddress, int blueAddress, int colour[3]){
  DmxMaster.write(redAddress, colour[0]);
  DmxMaster.write(greenAddress, colour[1]);
  DmxMaster.write(blueAddress, colour[2]);
}

void pitchToColourDisplay(int rgb[3], int rgbCompare[3], int targetArray[3]){
  //Compare current values to previous
  compareRGB(rgb, rgbCompare, targetArray);
}




