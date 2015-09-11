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

  setRanges();
  setAddresses();

}

void loop() {

  if (Serial.available()) {
    while (Serial.available() >= /*4*/ 4) {// wait for 3 ints to arrive (Keep having to change this?)
      in[0] = Serial.parseInt(); //TAG
      in[1] = Serial.parseInt(); //pitch
      in[2] = Serial.parseInt(); //duration
      in[3] = Serial.parseInt(); //state
      in[4] = Serial.parseInt();//Run function (FOR TESTING ONLY!)
      Serial.write(1); //Tell processing we're done receiving data
    }
      //Serial.write(0);

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
    state = in[3];
    function = /*3*/ in[4];

    //    function = 3; //For testing with processing

    // Serial.print("in[0]: ");
    // Serial.print(in[0]);
    // Serial.print(" in[1]: ");
    // Serial.print(in[1]);
    // Serial.print(" in[2]: ");
    // Serial.print(in[2]);
    // Serial.print(" State: ");
    // Serial.print(state);
    // Serial.print(" function "); //FOR TESTING ONLY
    // Serial.println(function);

    //Colour and movement calculations based on the state (while serial is available)
    //    if (state == 1) {
    //      pitchToColourCalc(fre1, 9, 0, rgb9, compareRGB9, hue, sat, bri); //SingerPitch, Light, Singer, Light, (3 arrays to save the conversions to)
    //    }
  }

   //Run test function
   if (function == 1) {
     spin(2, in[0], in[1], in[2]); //Light 3
   } else if (function == 2) {
     spin(3, in[0], in[1], in[2]);//Light 2
   } else if (function == 3) {
     if (state == 1) {
      // pitchToColourDisplay(rgb1, compareRGB1, displayRGB1);
      slowBright(2,rgb9); // for Lights 6 & 7 at begining
     } else if(state == 2){
        lightsOff(2);
     } else if(state == 3){
        setRGB(rgb9,in[0],in[1],in[2],0); //Manually set the RGB
        writeToLights(2,rgb9);
     } else if(state == 4){
        setRotation(2, in[0], in[1], in[2]);// Light, rotation, tilt, speed
     }

   }
  
  // pitchToColourCalc(fre1, 9, 0, rgb9, /*compareRGB9,*/ hue, sat, bri);
  // //pitchToColourDisplay(rgb9, compareRGB9, displayRGB9);
  
  //Continously output to lights
  //writeToLights(2, rgb9 /*displayRGB9*/);

}



void SerialEvent() {
  //This doesn't really work
}

// void circlesCopy() {
//   //NOTE:Test lights will not have movement, so use hardcoded addresses
//   for (int i = 0; i < 8; i++) {
//     //Map the frequency and duration the same way it is in Processing - Circles
//     hue[i] = int(map(fre1, minPitch[i], maxPitch[i], 0, 360));
//     sat[i] =  int(map(fre1, minPitch[i], maxPitch[i], 0, 100));
//     bri[i] = int(map(fre1, minPitch[i], maxPitch[i], 0, 70));
//   }

//   //Convert HSB to RGB

//   H2R_HSBtoRGB(hue[0], sat[0], bri[0], rgb1);

//   //Send to appropriate lights
//   DmxMaster.write(redL1, rgb1[0]);
//   DmxMaster.write(greenL1, rgb1[1]);
//   DmxMaster.write(blueL1, rgb1[2]);

// }