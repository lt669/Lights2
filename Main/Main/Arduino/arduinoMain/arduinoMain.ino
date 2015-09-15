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
  setLargeAddresses();
  setSmallAddresses();
  setCues();

  

}

void loop() {
      timer = millis();
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
    function = in[4];

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
  // if (function == 1) {
  //   spin(2, in[0], in[1], in[2]); //Light 3
  // } else if (function == 2) {
  //   spin(3, in[0], in[1], in[2]);//Light 2
  // } else if (function == 3) {
  //   if (state == 1) {
  //     // pitchToColourDisplay(rgb1, compareRGB1, displayRGB1);
  //     slowBright(2, rgb0, 400); // for Lights 6 & 7 at begining
  //   } else if (state == 2) {
  //     lightsOff(2);
  //   } else if (state == 3) {
  //     setRGB(rgb0, in[0], in[1], in[2], 0); //Manually set the RGB
  //     writeToLights(2, rgb0);
  //   } else if (state == 4) {
  //     setRotation(2, in[0], in[1], in[2]);// Light, rotation, tilt, speed
  //   }
  // }

  /*------------------------------FOR TESTING WITH ONE LIGHT ONLY------------------------------*/

     // rgb0[0] = in[0];
     // rgb0[1] = in[1];
     // rgb0[2] = in[2];

     //Lights Program
     if (state == 1) {
       //BackLights only
       setRotation(1,212,80,100);//TEST LIGHT
       slowBright(1, rgb1, 400);//TEST LIGHT

       setRotation(4,212,80,100); //Set the position of the backlights
       setRotation(5,212,80,100);

       slowBright(4, rgb4, 400); //Set backlights to glow
       slowBright(5, rgb5, 400);
     } else if (state == 2) {     /*-------------FADE IN SINGERS-------------*/
       slowBright(6, rgb6, 400);  
       if(timer >= cueArray[2] + 5){
        slowBright(7, rgb7, 400);
       }
       if(timer >= cueArray[2] + 10){
        slowBright(8, rgb8, 400);
       }
       if(timer >= cueArray[2] + 15){
        slowBright(9, rgb9, 400);
       }
       if(timer >= cueArray[2] + 20){
        slowBright(10, rgb10, 400);
       }
       if(timer >= cueArray[2] + 25){
        slowBright(11, rgb11, 400);
       }                                  /*-------------FADE IN SINGERS-------------*/
     } else if (state == 3) {
       /*Wall Lights Only (Set white light to 0)*/
       setRGB(rgb6,0,0,0,0); //Fade out singer lights
       setRGB(rgb7,0,0,0,0);
       setRGB(rgb8,0,0,0,0);
       setRGB(rgb9,0,0,0,0);
       setRGB(rgb10,0,0,0,0);
       setRGB(rgb11,0,0,0,0);

       setRotation(1,85,100,0); //TEST
       setRGB(rgb1,0,0,0,200);

       setRotation(2, 85, 100, 0); //Set position of wall lights
       setRotation(3, 85, 100, 0); 

       setRGB(rgb2,0,0,0,200); //Set colours to white
       setRGB(rgb3,0,0,0,200);
     } else if (state == 4) { //Wall colours + spots white
       if(count == 0){
        setRGB(rgb0,0,0,0,0);
        setRGB(rgb1,0,0,0,0);
        setRGB(rgb6,0,0,0,0); //Set the white value to start on 0
        setRGB(rgb7,0,0,0,0);
        setRGB(rgb8,0,0,0,0);
        setRGB(rgb9,0,0,0,0);
        setRGB(rgb10,0,0,0,0);
        setRGB(rgb11,0,0,0,0);

        }
       count++; //Only runs once

       int fadeSpeed = 70;
       fadeCounter++;
       if(fadeCounter >= fadeSpeed){
        fadeCounter = 0;
         //softWhiteGlow(1, rgb1, 50);//TEST LIGHT
         softWhiteGlow(6, rgb6, 50); //Singer spots glow white
         softWhiteGlow(7, rgb7, 50);
         softWhiteGlow(8, rgb8, 50);
         softWhiteGlow(9, rgb9, 50);
         softWhiteGlow(10, rgb10, 50);
         softWhiteGlow(11, rgb11, 50);
       } 

      // writeToLights(2, rgb2);     //Set wall lights to white (copy rgb2)
      // writeToLights(3, rgb2);
     } else if (state == 5 /*Run this untill state 7*/) {
       //Continue above + sideLights throb white
       /*----------INSTER TIMER STATEMENT----------*/
       pitchToColourCalc(fre1,6,0,rgb6); //Singer spots map pitch
       pitchToColourCalc(fre2,7,1,rgb7);
       pitchToColourCalc(fre3,8,2,rgb8);
       pitchToColourCalc(fre4,9,3,rgb9);
       pitchToColourCalc(fre5,10,4,rgb10);
       pitchToColourCalc(fre6,11,5,rgb11);

     } else if (state == 6) { // Side lights throb, singers still map to pitch
       int fadeSpeed = 70;
       fadeCounter++;
       if(fadeCounter >= fadeSpeed){
        fadeCounter = 0;
        softWhiteGlow(0, rgb0, 200);//Side lights throb       
        softWhiteGlow(1, rgb1, 200);
        }
     } else if (state == 7) {
       pitchToColourCalc(fre1,6,0,rgb6); //Only Soprano map pitch
       //pitchToColourCalc(fre1,1,0,rgb1); //Map front left to sporano pitch
       setRGB(rgb1,255,0,0,0);
       //setRotation(1,in[0],in[1],in[2]);
       movingLight(1,move1); //HAVING PROBLEMS WITH THIS

       setRGB(rgb7,0,0,0,70); //Rest of singers on low white
       setRGB(rgb8,0,0,0,70);
       setRGB(rgb9,0,0,0,70);
       setRGB(rgb10,0,0,0,70);
       setRGB(rgb11,0,0,0,70);

       setRGB(rgb2,0,0,0,0);//wall lights off
       setRGB(rgb3,0,0,0,0);
       setRGB(rgb0,0,0,0,0);//Right front off




     } else if (state == 8) {
       //Animation only (Very dim siger lights)
       setRGB(rgb10,0,255,0,0);
     } else if (state == 9) {
       //Slowly fade backlightsin
     } else if (state == 10) {

     }


    /*Constantly write to all lights, therefore only calculations
      need to happen in the above if statements.
    */
      writeToLights(0,rgb0);
      writeToLights(1,rgb1);
      writeToLights(2,rgb2);
      writeToLights(3,rgb3);
      writeToLights(4,rgb4);
      writeToLights(5,rgb5);
      writeToLights(6,rgb6);
      writeToLights(7,rgb7);
      writeToLights(8,rgb8);
      writeToLights(9,rgb9);
      writeToLights(10,rgb10);//APPARENTLY LIGHT 10 CH101 - 104 FUCKS SHT UP!?!?!?!

      // writeMovement(0,move0);
      // writeMovement(1,move1);
      // writeMovement(2,move2);
      // writeMovement(3,move3);
      // writeMovement(4,move4);

  /*------------------------------FOR TESTING WITH ONE LIGHT ONLY------------------------------*/

}

// pitchToColourCalc(fre1, 9, 0, rgb9, /*compareRGB9,*/ hue, sat, bri);
// //pitchToColourDisplay(rgb9, compareRGB9, displayRGB9);

//Continously output to lights
//writeToLights(2, rgb9 /*displayRGB9*/);

//}



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
