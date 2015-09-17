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
  setIncrement();
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
    //  in[4] = Serial.parseInt();//Run function (FOR TESTING ONLY!)
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
   
    //function = in[4];

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


   //Always store the state
    state = in[3];
  
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

       setRotation(2, 233, 70, 0); //Set position of wall lights
       setRotation(3, 106, 70, 0); 

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
         softWhiteGlow(6, rgb6); //Singer spots glow white
         softWhiteGlow(7, rgb7);
         softWhiteGlow(8, rgb8);
         softWhiteGlow(9, rgb9);
         softWhiteGlow(10, rgb10);
         softWhiteGlow(11, rgb11);
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
        softWhiteGlow(0, rgb0);//Side lights throb       
        softWhiteGlow(1, rgb1);
        }
     } else if (state == 7) {
       pitchToColourCalc(fre1,6,0,rgb6); //Only Soprano map pitch
       //pitchToColourCalc(fre1,1,0,rgb1); //Map front left to sporano pitch
       setRGB(rgb1,255,0,0,0);// CHANGE THIS TO MAP PITCH

       movingLight(1, move1, 50, 240, 212, 128); //Left front light moves
                                                 //Light,Array,tilt,speed,max/min

       setRGB(rgb7,0,0,0,70); //Rest of singers on low white
       setRGB(rgb8,0,0,0,70);
       setRGB(rgb9,0,0,0,70);
       setRGB(rgb10,0,0,0,70);
       setRGB(rgb11,0,0,0,70);

       setRGB(rgb2,0,0,0,0);//wall lights off
       setRGB(rgb3,0,0,0,0);
       setRGB(rgb0,0,0,0,0);//Right front off

     } else if (state == 8) {
       setRGB(rgb6,0,0,0,70);//All singers on low white
       setRGB(rgb7,0,0,0,70); 
       setRGB(rgb8,0,0,0,70);
       setRGB(rgb9,0,0,0,70);
       setRGB(rgb10,0,0,0,70);
       setRGB(rgb11,0,0,0,70);

       setRGB(rgb1,0,0,0,0);      //Set front left back to position and off
       setRotation(1,45,50,0);

       setRGB(rgb4,0,0,0,100); //Dim backlights
       setRGB(rgb5,0,0,0,100);

     } else if (state == 9) {//Animation Only
       setRGB(rgb0,0,0,0,0);//All lights off
       setRGB(rgb1,0,0,0,0);
       setRGB(rgb2,0,0,0,0);
       setRGB(rgb3,0,0,0,0);
       setRGB(rgb4,0,0,0,0); 
       setRGB(rgb5,0,0,0,0);
       setRGB(rgb6,0,0,0,0);
       setRGB(rgb7,0,0,0,0); 
       setRGB(rgb8,0,0,0,0);
       setRGB(rgb9,0,0,0,0);
       setRGB(rgb10,0,0,0,0);
       setRGB(rgb11,0,0,0,0);
     } else if (state == 10) {

       slowBright(4, rgb4, 400); //Fade backlights in
       slowBright(5, rgb5, 400);

       // if(timer >= time + 9){   //Fade in right wall
       //  slowBright(2,rgb2,400);
       // }

       // if(timer >= time + 18){  //Fade in left wall
       //  slowBright(3,rgb3,400);
       // }

       // if(timer >= time + 27){ //Fade in right front
       //  slowBright(0,rgb0,400);
       //  setRotation(0,128,128,200);
       // }

       // if(timer >= time + 36){  //Fade in left front
       //  slowBright(1,rgb1,400);
       //  setRotation(1,45,128,200);
       // }
 
     } else if(state == 11){

      pitchToColourCalc(fre6,0,6,rgb0);  //Lights map pitch in pairs one at a time
      pitchToColourCalc(fre6,11,6,rgb11);

      pitchToColourCalc(fre6,1,6,rgb1); //TEST



      // if(timer >= time + 9){
      //   pitchToColourCalc(fre5,4,5,rgb4);
      //   pitchToColourCalc(fre5,10,5,rgb10);
      // }

      // if(timer >= time + 18){
      //   pitchToColourCalc(fre4,2,4,rgb4);
      //   pitchToColourCalc(fre4,9,4,rgb9);
      // }

      // if(timer >= time + 27){
      //   pitchToColourCalc(fre3,5,3,rgb5);
      //   pitchToColourCalc(fre3,8,3,rgb8);
      // }

      // if(timer >= time + 36){
      //   pitchToColourCalc(fre2,3,2,rgb3);
      //   pitchToColourCalc(fre2,7,2,rgb7);
      // }

      // if(timer >= time + 45){
      //   pitchToColourCalc(fre1,1,1,rgb1);
      //   pitchToColourCalc(fre1,6,1,rgb6);
      // }

     } else if(state == 12){

       int fadeSpeed = 70;
       fadeCounter++;
       if(fadeCounter >= fadeSpeed){
          fadeCounter = 0;
          brightness += brightnessDirection;

          if(brightness >= 200){
            brightnessDONE = true;
          } else if(brightness <= 0){
            brightnessDONE = false;
          }

          if(brightnessDONE == true){
            brightnessDirection = -1;
          } else if (brightnessDONE == false){
            brightnessDirection = 1;
          }
           setRGB(rgb1,0,0,0,brightness); //Set left side to white
           setRGB(rgb3,0,0,0,brightness);
           setRGB(rgb5,0,0,0,brightness);
           setRGB(rgb6,0,0,0,brightness);
           setRGB(rgb7,0,0,0,brightness);
           setRGB(rgb8,0,0,0,brightness);

           setRGB(rgb0,200 - brightness,0,0,0); //Set right side to red
           setRGB(rgb2,200 - brightness,0,0,0);
           setRGB(rgb4,200 - brightness,0,0,0);
           setRGB(rgb9,200 - brightness,0,0,0);
           setRGB(rgb10,200 - brightness,0,0,0);
           setRGB(rgb11,200 - brightness,0,0,0);
     }

       setRotation(0, 128, 50, 0); //Front lights face each other
       setRotation(1, 45, 50, 0);

     } else if(state == 13){ //Swap colours around

      int fadeSpeed = 70;
       fadeCounter++;
       if(fadeCounter >= fadeSpeed){
          fadeCounter = 0;
          brightness += brightnessDirection;
          if(brightness >= 200){
            brightnessDONE = true;
          } else if(brightness <= 0){
            brightnessDONE = false;
          }

          if(brightnessDONE == true){
            brightnessDirection = -1;
          } else if (brightnessDONE == false){
            brightnessDirection = 1;
          }
           setRGB(rgb1,0,200 - brightness,0,0); //Set left side to white
           setRGB(rgb3,0,200 - brightness,0,0);
           setRGB(rgb5,0,200 - brightness,0,0);
           setRGB(rgb6,0,200 - brightness,0,0);
           setRGB(rgb7,0,200 - brightness,0,0);
           setRGB(rgb8,0,200 - brightness,0,0);

           setRGB(rgb0,0,0,0,brightness); //Set right side to red
           setRGB(rgb2,0,0,0,brightness);
           setRGB(rgb4,0,0,0,brightness);
           setRGB(rgb9,0,0,0,brightness);
           setRGB(rgb10,0,0,0,brightness);
           setRGB(rgb11,0,0,0,brightness);
     }


     } else if(state == 14){ // All Lights go nice purply colour
       setRGB(rgb0,177,0,200,0);
       setRGB(rgb1,177,0,200,0);
       setRGB(rgb2,177,0,200,0);
       setRGB(rgb3,177,0,200,0);
       setRGB(rgb4,177,0,200,0);
       setRGB(rgb5,177,0,200,0);
       setRGB(rgb6,177,0,200,0);
       setRGB(rgb7,177,0,200,0);
       setRGB(rgb8,177,0,200,0);
       setRGB(rgb9,177,0,200,0);
       setRGB(rgb10,177,0,200,0);
       setRGB(rgb11,177,0,200,0);

       setRotation(0,128,128,230); //Front and wall lights face upwards
       setRotation(1,128,128,230);
       setRotation(2,128,128,230);
       setRotation(3,128,128,230);
     } else if(state == 15){ //Fades lights out one at a time
        setRGB(rgb0,0,0,0,0);

        // if(timer >= time + 5000){
        //   setRGB(rgb1,0,0,0,0);
        // }

        // if(timer >= time + 10000){
        //   setRGB(rgb1,0,0,0,0);
        // }

        // if(timer >= time + 15000){
        //   setRGB(rgb2,0,0,0,0);
        // }

        // if(timer >= time + 20000){
        //   setRGB(rgb3,0,0,0,0);
        // }

        // if(timer >= time + 25000){
        //   setRGB(rgb4,0,0,0,0);
        //   setRGB(rgb5,0,0,0,0);
        // }

     } else if(state == 16){ //Spotlights go dim white
        setRGB(rgb6,0,0,0,100);
        setRGB(rgb7,0,0,0,100);
        setRGB(rgb8,0,0,0,100);
        setRGB(rgb9,0,0,0,100);
        setRGB(rgb10,0,0,0,100);
        setRGB(rgb11,0,0,0,100);
     } else if(state == 17){ //Spotlights off
        setRGB(rgb6,0,0,0,0);
        setRGB(rgb7,0,0,0,0);
        setRGB(rgb8,0,0,0,0);
        setRGB(rgb9,0,0,0,0);
        setRGB(rgb10,0,0,0,0);
        setRGB(rgb11,0,0,0,0);
     } else if(state == 18){ //Face front lights up and glow
      /*RUN THIS FOR THE NEXT ONE TOO*/
       int fadeSpeed = 70;
       fadeCounter++;
       if(fadeCounter >= fadeSpeed){
        fadeCounter = 0;
        softWhiteGlow(0,rgb0);
        softWhiteGlow(1,rgb1);
      }
     } else if(state == 19){ // Wall lights also glow

        setRotation(2,233,50,0);//Wall lights back to position
        setRotation(3,106,50,0);
        setRotation(1,64,50,0);//Front lights face singers
        setRotation(0,106,50,0);

        int fadeSpeed = 70;
        fadeCounter++;
       if(fadeCounter >= fadeSpeed){
        fadeCounter = 0;
          softWhiteGlow(2,rgb2);//WallLights Glow
          softWhiteGlow(3,rgb3);
          softWhiteGlow(3,rgb6);//Singer Lights Glow
          softWhiteGlow(3,rgb7);
          softWhiteGlow(3,rgb8);
          softWhiteGlow(3,rgb9);
          softWhiteGlow(3,rgb10);
          softWhiteGlow(3,rgb11);
      }
      
     } else if(state == 20){ //Singers only
        setRGB(rgb0,0,0,0,0);//Turn off
        setRGB(rgb1,0,0,0,0);
        setRGB(rgb2,0,0,0,0);
        setRGB(rgb3,0,0,0,0);
        setRGB(rgb4,0,0,0,0);
        setRGB(rgb5,0,0,0,0);

        setRGB(rgb6,0,0,0,70);//Dim singer lights
        setRGB(rgb7,0,0,0,70);
        setRGB(rgb8,0,0,0,70);
        setRGB(rgb9,0,0,0,70);
        setRGB(rgb10,0,0,0,70);
        setRGB(rgb11,0,0,0,70);


     } else if(state == 21){ //Fade singers out
        setRGB(rgb6,0,0,0,0);
        setRGB(rgb7,0,0,0,0);
        setRGB(rgb8,0,0,0,0);
        setRGB(rgb9,0,0,0,0);
        setRGB(rgb10,0,0,0,0);
        setRGB(rgb11,0,0,0,0);
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
