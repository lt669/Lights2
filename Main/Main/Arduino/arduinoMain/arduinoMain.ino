#include <HSBColor.h>
#include <RGBConverter.h>
#include <DmxMaster.h>

//Self written headers
#include "DMXAddresses.h"
#include "RGBVariables.h"

//#include <pitchToColourFunctions.h>
//#include "pitchToColourFunctions.c"

boolean testing;

void setup() {

  Serial.begin(9600);
  Serial.write(1);//Send value to establish contact

  setRanges();
  setLargeAddresses();
  setSmallAddresses();
  setIncrement();
  setCues();

  testing = false;

        brightness = 0;

      setRGB(rgb0, 0, 0, 0, 0);
      setRGB(rgb1, 0, 0, 255, 0);
      setRGB(rgb2, 0, 0, 0, 0);
      setRGB(rgb3, 0, 0, 0, 0);
      setRGB(rgb4, 0, 0, 0, 0);
      setRGB(rgb5, 0, 0, 0, 0);
      setRGB(rgb6, 0, 0, 0, 0);
      setRGB(rgb7, 0, 0, 0, 0);
      setRGB(rgb8, 0, 0, 0, 0);
      setRGB(rgb9, 0, 0, 0, 0);
      setRGB(rgb10, 0, 0, 0, 0);
      setRGB(rgb11, 0, 0, 0, 0);

      setRotation(1, 0, 0, 0);
      setRotation(2, 0, 0, 0);
      setRotation(3, 0, 0, 0);
      setRotation(4, 0, 0, 0);
      setRotation(5, 0, 0, 0);
      setRotation(6, 0, 0, 0);

}

void loop() { 
  timer = millis();
   if (Serial.available()) {
    while (Serial.available() >= /*4*/ 4) {// wait for 3 ints to arrive (Keep having to change this?)
      in[0] = Serial.parseInt(); //TAG
      in[1] = Serial.parseInt(); //pitch
      in[2] = Serial.parseInt(); //duration
      in[3] = Serial.parseInt(); //state
     // in[4] = Serial.parseInt();//Run function (FOR TESTING ONLY!)
      Serial.write(1); //Tell processing we're done receiving data
      // Serial.end();
      // Serial.begin(9600);
    }

    if(testing == false){
      //Serial.write(0);
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
    state = in[3];

  }

    //Always store the state
    if(testing == true){
    state =  in[3];  /*---------TESTING ONLY---------*/
    function = in[4];
    }

    if(testing == false){
   // state = 1; //If there is contact between programs
    }
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

  

  //function = 1; //Testing only

  if (testing == true) {
      // DmxMaster.write(85,255);
      // DmxMaster.write(86,255);
      // DmxMaster.write(87,255);
    //Run test function
    if (function == 1) {
      //spin(1, in[0], in[1], in[2]); //Light 3
      // setRGB(rgb0,in[0],in[1],in[2],0);
      // writeToLargeLights(0,rgb0);


      //glowBrightnessCounter(170,200,100);
      slowBrightnessCounter(170,200);

      setRGB(rgb0,0,0,0,brightness);
      setRGB(rgb6,brightness,brightness,brightness,brightness);

      writeToLargeLights(1,rgb0);
      writeToSmallLights(6,rgb6);
    }

     else if (function == 2) {
      //spin(1, in[0], in[1], in[2]);//Light 2

      setRGB(rgb0,in[0],in[1],in[2],0);
      movingLight(2, move0, 50, 240, 212, 128 , 100000);
      writeToLargeLights(2,rgb0);

      // setRGB(rgb6,in[0],in[1],in[2],0);
      // writeToSmallLights(6,rgb6);
    } else if (function == 3) {
      setRGB(rgb1,in[0],in[1],in[2],0);
      writeToLargeLights(2,rgb1);
      //spin(2, in[0], in[1], in[2]);//Light 2
    } else if (function == 4) {
      //spin(3, in[0], in[1], in[2]);//Light 2
      setRGB(rgb2,in[0],in[1],in[2],0);
      writeToLargeLights(2,rgb2);
    } else if (function == 5) {         //Test small lights
      setRGB(rgb6,in[0],in[1],in[2],0);
      writeToSmallLights(7,rgb6);
    } else if (function == 6) {
      setRGB(rgb7,in[0],in[1],in[2],0);
      writeToSmallLights(8,rgb7);
    } else if (function == 7) {
      setRGB(rgb8,in[0],in[1],in[2],0);
      writeToSmallLights(9,rgb8);
    } else if (function == 8) {
      setRGB(rgb9,in[0],in[1],in[2],0);
      writeToSmallLights(10,rgb9);
    } else if (function == 9) {
      setRGB(rgb10,in[0],in[1],in[2],0);
      writeToSmallLights(11,rgb10);
    } else if (function == 10) {
      setRGB(rgb11,in[0],in[1],in[2],0);
      writeToSmallLights(12,rgb11);
    } else if (function == 11) {
      spin(10, in[0], in[1], in[2]);//Light 2
    } else if (function == 12) {
      if (state == 1) {
        // pitchToColourDisplay(rgb1, compareRGB1, displayRGB1);
        slowBright(2, rgb0, 400, 100); // for Lights 6 & 7 at begining
      } else if (state == 2) {
        lightsOff(2);
      } else if (state == 3) {
        setRGB(rgb0, in[0], in[1], in[2], 0); //Manually set the RGB
        writeToLargeLights(2, rgb0);
      } else if (state == 4) {
        setRotation(2, in[0], in[1], in[2]);// Light, rotation, tilt, speed
      }
    }
  }

  /*------------------------------FOR TESTING WITH ONE LIGHT ONLY------------------------------*/



  if (testing == false) {

    if (state == 0) { //Count how long the program runs before processing starts
      last = millis();
      Serial.print("last: ");
      Serial.println(last);
    }

    if (state >= 1) { //Only when processing starts, run the program
      timer = (millis() - last)/1000;
      //timer = in[0];
      //Lights Program
      if (timer > cueArray[0] && timer < cueArray[1]) { //Fade in backlights
        if(timer < cueArray[0] + 1){
          brightness = 0; //Reset variables
        }
       // Serial.println("cue[0]");

        setRotation(1, 128, 128, 100); //TEST LIGHT
        setRGB(rgb1,0,0,0,brightness);

        setRotation(5, 212, 80, 100); //Set the position of the backlights
        setRotation(6, 212, 80, 100);

        slowBrightnessCounter(400,200);// Backlights slowly fade on
        setRGB(rgb4,0,0,0,brightness);
        setRGB(rgb5,0,0,0,brightness);

      } else if (timer > cueArray[1] && timer < cueArray[2]) {     /*-------------FADE IN SINGERS-------------*/
        if(timer < cueArray[1] + 1){
          brightness = 0; //Reset variables
        }
       // Serial.println("cue[1]");
        //TESTER
        setRGB(rgb1, 200, 200, 0, 0);
        setRotation(2, 0, 0, 200);

        slowBrightnessCounter(400,100);// Singers slowly fade in

        setRGB(rgb6,brightness,brightness,brightness,0);
        if (timer >= cueArray[1] + 5) {
          setRGB(rgb7,brightness,brightness,brightness,brightness);
        }
        if (timer >= cueArray[1] + 10) {
          setRGB(rgb8,brightness,brightness,brightness,brightness);
        }
        if (timer >= cueArray[1] + 15) {
          setRGB(rgb9,brightness,brightness,brightness,brightness);
        }
        if (timer >= cueArray[1] + 20) {
          setRGB(rgb10,brightness,brightness,brightness,brightness);
        }
        if (timer >= cueArray[1] + 25) {
          setRGB(rgb11,brightness,brightness,brightness,brightness);
        }                                  /*-------------FADE IN SINGERS-------------*/
      } else if (timer > cueArray[2] && timer < cueArray[3]) { //Wall lights only
        if(timer < cueArray[2] + 1){
          brightness = 0; //Reset variables
        }
       // Serial.println("cue[2]");

        setRGB(rgb6, 0, 0, 0, 0); //Fade out singer lights
        setRGB(rgb7, 0, 0, 0, 0);
        setRGB(rgb8, 0, 0, 0, 0);
        setRGB(rgb9, 0, 0, 0, 0);
        setRGB(rgb10, 0, 0, 0, 0);
        setRGB(rgb11, 0, 0, 0, 0);

        setRotation(3, 233, 70, 0); //Set position of wall lights
        setRotation(4, 106, 70, 0);

        setRGB(rgb2, 0, 0, 0, 200); //Set colours to white
        setRGB(rgb3, 0, 0, 0, 200);
      } else if (timer > cueArray[3] && timer < cueArray[4]) { //Wall colours + spots white
        if(timer < cueArray[3] + 1){
          brightness = 0; //Reset variables
          setRGB(rgb0, 0, 0, 0, 0);
          setRGB(rgb1, 0, 0, 0, 0);
          setRGB(rgb6, 0, 0, 0, 0); //Set the white value to start on 0
          setRGB(rgb7, 0, 0, 0, 0);
          setRGB(rgb8, 0, 0, 0, 0);
          setRGB(rgb9, 0, 0, 0, 0);
          setRGB(rgb10, 0, 0, 0, 0);
          setRGB(rgb11, 0, 0, 0, 0);

        }
       // Serial.println("cue[3]");

         //glowBrightnessCounter(170,100,50);
        glowBrightnessCounter(110,100,20);
       // setRGB(rgb1, 0, 0, 0, brightness);
        setRGB(rgb6, brightness, brightness, brightness, 0); //Singer spotlights glow
        setRGB(rgb7, brightness, brightness, brightness, 0);
        setRGB(rgb8, brightness, brightness, brightness, 0);
        setRGB(rgb9, brightness, brightness, brightness, 0);
        setRGB(rgb10, brightness, brightness, brightness, 0);
        setRGB(rgb11, brightness, brightness, brightness, 0);

      } else if (timer > cueArray[4] && timer < cueArray[5] /*Run this untill state 7*/) {
        //Serial.println("cue[4]");
        //Continue above + sideLights throb white

        pitchToColourCalc(fre1, 6, 0, rgb6); //Singer spots map pitch
        if (timer > cueArray[4] + 5) {
          pitchToColourCalc(fre2, 7, 1, rgb7);
        } if (timer > cueArray[4] + 10) {
          pitchToColourCalc(fre3, 8, 2, rgb8);
        } if (timer > cueArray[4] + 15) {
          pitchToColourCalc(fre4, 9, 3, rgb9);
        } if (timer > cueArray[4] + 20) {
          pitchToColourCalc(fre5, 10, 4, rgb10);
        } if (timer > cueArray[4] + 25) {
          pitchToColourCalc(fre6, 11, 5, rgb11);
        }

      } else if (timer > cueArray[5] && timer < cueArray[6] /*Run this untill state 7*/) {
        if(timer < cueArray[5] + 1){
          brightness = 0; //Reset variables
        }

        //Continue above + sideLights throb white
        pitchToColourCalc(fre1, 6, 0, rgb6); //Singer spots map pitch
        pitchToColourCalc(fre2, 7, 1, rgb7);
        pitchToColourCalc(fre3, 8, 2, rgb8);
        pitchToColourCalc(fre4, 9, 3, rgb9);
        pitchToColourCalc(fre5, 10, 4, rgb10);
        pitchToColourCalc(fre6, 11, 5, rgb11);


        glowBrightnessCounter(110,100,20); //Frontlights glow
        setRGB(rgb0,0,0,0,brightness);
        setRGB(rgb1,0,0,0,brightness);

      } else if (timer > cueArray[6] && timer < cueArray[7]) { //!!!!!!!!!!!!!!!!!TEST THIS FUNCTION FOR MOVEMENT!!!!!!!!!!!!!!!!!
        if(timer < cueArray[6] + 1){
          brightness = 0; //Reset variables
        }

        pitchToColourCalc(fre1, 6, 0, rgb6); //Only Soprano map pitch
        pitchToColourCalc(fre1,1,0,rgb1); //Map front left to sporano pitch
        //movingLight(1, move0, 50, 240, 212, 128, 50000); //Left front light 
        setRotation(2,128,128,230);

        //setRGB(rgb1, 0, 255, 0, 0); // CHANGE THIS TO MAP PITCH
        
        //Light,Array,tilt,speed,max/min

        setRGB(rgb7, 50, 50, 50, 0); //Rest of singers on low white
        setRGB(rgb8, 50, 50, 50, 0);
        setRGB(rgb9, 50, 50, 50, 0);
        setRGB(rgb10, 50, 50, 50, 0);
        setRGB(rgb11, 50, 50,50, 0);

       // setRGB(rgb2, 0, 0, 0, 0); //wall lights off
        //setRGB(rgb3, 0, 0, 0, 0);
        //setRGB(rgb0, 0, 0, 0, 0); //Right front off

      } else if (timer > cueArray[7] && timer < cueArray[8]) {
        //Serial.println("cue[7]");
        setRGB(rgb6, 50, 50, 50, 0); //All singers on low white
        setRGB(rgb7, 50, 50, 50, 0);
        setRGB(rgb8, 50, 50, 50, 0);
        setRGB(rgb9, 50, 50, 50, 0);
        setRGB(rgb10, 50, 50, 50, 0);
        setRGB(rgb11, 50, 50,50, 0);

        setRGB(rgb1, 0, 0, 0, 0);  //Set front left back to position and off
        setRGB(rgb0, 0, 0, 0, 0); //Also set right right off
        setRotation(2, 45, 50, 0);

        setRGB(rgb4, 0, 0, 0, 100); //Dim backlights
        setRGB(rgb5, 0, 0, 0, 100);

      } else if (timer > cueArray[8] && timer < cueArray[9]) {//Animation Only
       // Serial.println("cue[8]");
        setRGB(rgb0, 0, 0, 0, 0); //All lights off
        setRGB(rgb1, 0, 0, 0, 0);
        setRGB(rgb2, 0, 0, 0, 0);
        setRGB(rgb3, 0, 0, 0, 0);
        setRGB(rgb4, 0, 0, 0, 0);
        setRGB(rgb5, 0, 0, 0, 0);
        setRGB(rgb6, 0, 0, 0, 0);
        setRGB(rgb7, 0, 0, 0, 0);
        setRGB(rgb8, 0, 0, 0, 0);
        setRGB(rgb9, 0, 0, 0, 0);
        setRGB(rgb10, 0, 0, 0, 0);
        setRGB(rgb11, 0, 0, 0, 0);
      } else if (timer > cueArray[9] && timer < cueArray[10]) {
        if(timer < cueArray[9] + 1){
          brightness = 0; //Reset variables
        }
       // Serial.println("cue[9]");

        // slowBright(4, rgb4, 400); //Fade backlights in
        // slowBright(5, rgb5, 400);

        slowBrightnessCounter(170,200); //Fade backlights in
        setRGB(rgb4,0,0,0,brightness);
        setRGB(rgb5,0,0,0,brightness);

        if (timer >= cueArray[9] + 9) { //Fade in right wall
          setRGB(rgb2,0,0,0,rgb2[3] + 1); /*---------Check to see if this works-------*/
          //slowBright(2, rgb2, 400);
        }

        if (timer >= cueArray[9] + 18) { //Fade in left wall
          setRGB(rgb3,0,0,0,rgb3[3] + 1);
          //slowBright(3, rgb3, 400);
        }

        if (timer >= cueArray[9] + 27) { //Fade in right front
          //slowBright(0, rgb0, 400);
          setRGB(rgb0,0,0,0,rgb0[3] + 1);
          setRotation(1, 128, 128, 200);
        }

        if (timer >= cueArray[9] + 36) { //Fade in left front
          //slowBright(1, rgb1, 400);
          setRGB(rgb1,0,0,0,rgb1[3] + 1);
          setRotation(2, 45, 128, 200);
        }

      } else if (timer > cueArray[10] && timer < cueArray[11]) {
      //  Serial.println("cue[10]");

        pitchToColourCalc(fre6, 0, 6, rgb0); //Lights map pitch in pairs one at a time
        pitchToColourCalc(fre6, 11, 6, rgb11);

        pitchToColourCalc(fre6, 1, 6, rgb1); //TEST

        if (timer >= cueArray[10] + 9) {
          pitchToColourCalc(fre5, 4, 5, rgb4);
          pitchToColourCalc(fre5, 10, 5, rgb10);
        }

        if (timer >= cueArray[10] + 18) {
          pitchToColourCalc(fre4, 2, 4, rgb4);
          pitchToColourCalc(fre4, 9, 4, rgb9);
        }

        if (timer >= cueArray[10] + 27) {
          pitchToColourCalc(fre3, 5, 3, rgb5);
          pitchToColourCalc(fre3, 8, 3, rgb8);
        }

        if (timer >= cueArray[10] + 36) {
          pitchToColourCalc(fre2, 3, 2, rgb3);
          pitchToColourCalc(fre2, 7, 2, rgb7);
        }

        if (timer >= cueArray[10] + 45) {
          pitchToColourCalc(fre1, 1, 1, rgb1);
          pitchToColourCalc(fre1, 6, 1, rgb6);
        }

      } else if (timer > cueArray[11] && timer < cueArray[12]) {
        if(timer < cueArray[11] + 1){
          brightness = 0; //Reset variables
        }

        glowBrightnessCounter(70,200,30);

          setRGB(rgb1, 0, 0, 0, brightness); //Set left side to white
          setRGB(rgb3, 0, 0, 0, brightness);
          setRGB(rgb5, 0, 0, 0, brightness);
          setRGB(rgb6, brightness, brightness, brightness, 0);
          setRGB(rgb7, brightness, brightness, brightness, 0);
          setRGB(rgb8, brightness, brightness, brightness, 0);

          setRGB(rgb0, 200 - brightness, 0, 0, 0); //Set right side to red
          setRGB(rgb2, 200 - brightness, 0, 0, 0);
          setRGB(rgb4, 200 - brightness, 0, 0, 0);
          setRGB(rgb9, 200 - brightness, 0, 0, 0);
          setRGB(rgb10, 200 - brightness, 0, 0, 0);
          setRGB(rgb11, 200 - brightness, 0, 0, 0);
        

        setRotation(1, 128, 50, 0); //Front lights face each other
        setRotation(2, 45, 50, 0);

      } else if (timer > cueArray[12] && timer < cueArray[13]) { //Swap colours around
        if(timer < cueArray[12] + 1){
          brightness = 0; //Reset variables
        }
       // Serial.println("cue[12]");

        setRGB(rgb1, 0, 200 - brightness, 0, 0); //Set left side to Green
        setRGB(rgb3, 0, 200 - brightness, 0, 0);
        setRGB(rgb5, 0, 200 - brightness, 0, 0);
        setRGB(rgb6, 0, 200 - brightness, 0, 0);
        setRGB(rgb7, 0, 200 - brightness, 0, 0);
        setRGB(rgb8, 0, 200 - brightness, 0, 0);

        setRGB(rgb0, 0,0,0,brightness); //Set right side to White
        setRGB(rgb2, 0,0,0,brightness);
        setRGB(rgb4, 0,0,0,brightness);
        setRGB(rgb9, brightness,brightness,brightness,0);
        setRGB(rgb10, brightness,brightness,brightness,0);
        setRGB(rgb11, brightness,brightness,brightness,0);

      } else if (timer > cueArray[13] && timer < cueArray[14]) { // All Lights go nice purply colour
     //   Serial.println("cue[13]");
        setRGB(rgb0, 177, 0, 200, 0);
        setRGB(rgb1, 177, 0, 200, 0);
        setRGB(rgb2, 177, 0, 200, 0);
        setRGB(rgb3, 177, 0, 200, 0);
        setRGB(rgb4, 177, 0, 200, 0);
        setRGB(rgb5, 177, 0, 200, 0);
        setRGB(rgb6, 177, 0, 200, 0);
        setRGB(rgb7, 177, 0, 200, 0);
        setRGB(rgb8, 177, 0, 200, 0);
        setRGB(rgb9, 177, 0, 200, 0);
        setRGB(rgb10, 177, 0, 200, 0);
        setRGB(rgb11, 177, 0, 200, 0);

        setRotation(0, 128, 128, 230); //Front and wall lights face upwards
        setRotation(1, 128, 128, 230);
        setRotation(2, 128, 128, 230);
        setRotation(3, 128, 128, 230);
      } else if (timer > cueArray[14] && timer < cueArray[15]) { //Fades lights out one at a time
     //   Serial.println("cue[14]");
        setRGB(rgb0, 0, 0, 0, 0);

        if (timer >= cueArray[13] + 5) {
          setRGB(rgb1, 0, 0, 0, 0);
        }

        if (timer >= cueArray[13] + 10) {
          setRGB(rgb2, 0, 0, 0, 0);
        }

        if (timer >= cueArray[13] + 15) {
          setRGB(rgb3, 0, 0, 0, 0);
        }

        if (timer >= cueArray[13] + 20) {
          setRGB(rgb4, 0, 0, 0, 0);
          setRGB(rgb5, 0, 0, 0, 0);
        }

      } else if (timer > cueArray[15] && timer < cueArray[16]) { //Spotlights go dim white
     //   Serial.println("cue[15]");
        setRGB(rgb6, 50, 50, 50, 0);
        setRGB(rgb7, 50, 50, 50, 0);
        setRGB(rgb8, 50, 50, 50, 0);
        setRGB(rgb9, 50, 50, 50, 0);
        setRGB(rgb10, 50, 50, 50, 0);
        setRGB(rgb11, 50, 50, 50, 0);
      } else if (timer > cueArray[16] && timer < cueArray[17]) { //Spotlights off
     //   Serial.println("cue[16]");
        setRGB(rgb6, 0, 0, 0, 0);
        setRGB(rgb7, 0, 0, 0, 0);
        setRGB(rgb8, 0, 0, 0, 0);
        setRGB(rgb9, 0, 0, 0, 0);
        setRGB(rgb10, 0, 0, 0, 0);
        setRGB(rgb11, 0, 0, 0, 0);
      } else if (timer > cueArray[17] && timer < cueArray[18]) { //Face front lights up and glow
        if(timer < cueArray[17] + 1){
          brightness = 0; //Reset variables
        }
     //   Serial.println("cue[17]");
        /*RUN THIS FOR THE NEXT ONE TWO*/
        slowBrightnessCounter(170, 200);
        setRGB(rgb0,0,0,0,brightness);
        setRGB(rgb1,0,0,0,brightness);

      } else if (timer > cueArray[18] && timer < cueArray[19]) { // Wall lights also glow
       // Serial.println("cue[18]");
        if(timer < cueArray[18] + 1){
          brightness = 0; //Reset variables
        }

        setRotation(3, 233, 50, 200); //Wall lights back to position
        setRotation(4, 106, 50, 200);
        setRotation(2, 64, 50, 200); //Front lights face singers
        setRotation(1, 106, 50, 200);

        slowBrightnessCounter(170, 200);
        setRGB(rgb0,0,0,0,brightness);
        setRGB(rgb1,0,0,0,brightness);
        setRGB(rgb2,0,0,0,brightness);
        setRGB(rgb3,0,0,0,brightness);

        setRGB(rgb6,brightness,brightness,brightness,0);
        setRGB(rgb7,brightness,brightness,brightness,0);
        setRGB(rgb8,brightness,brightness,brightness,0);
        setRGB(rgb9,brightness,brightness,brightness,0);
        setRGB(rgb10,brightness,brightness,brightness,0);
        setRGB(rgb11,brightness,brightness,brightness,0);

      } else if (timer > cueArray[19] && timer < cueArray[20]) { //Singers only
    //    Serial.println("cue[19]");
        setRGB(rgb0, 0, 0, 0, 0); //Turn off
        setRGB(rgb1, 0, 0, 0, 0);
        setRGB(rgb2, 0, 0, 0, 0);
        setRGB(rgb3, 0, 0, 0, 0);
        setRGB(rgb4, 0, 0, 0, 0);
        setRGB(rgb5, 0, 0, 0, 0);

        setRGB(rgb6, 50, 50, 50, 0); //Dim singer lights
        setRGB(rgb7, 50, 50, 50, 0);
        setRGB(rgb8, 50, 50, 50, 0);
        setRGB(rgb9, 50, 50, 50, 0);
        setRGB(rgb10, 50, 50, 50, 0);
        setRGB(rgb11, 50, 50, 50, 0);

      }
      else if (timer > cueArray[20]) { //Fade singers out
   //     Serial.println("cue[20]");
        setRGB(rgb6, 0, 0, 0, 0);
        setRGB(rgb7, 0, 0, 0, 0);
        setRGB(rgb8, 0, 0, 0, 0);
        setRGB(rgb9, 0, 0, 0, 0);
        setRGB(rgb10, 0, 0, 0, 0);
        setRGB(rgb11, 0, 0, 0, 0);
      }
    }

    /*Constantly write to all lights, therefore only calculations
      need to happen in the above if statements.
    */
    writeToLargeLights(1, rgb0);
    writeToLargeLights(2, rgb1);
    writeToLargeLights(3, rgb2);
    writeToLargeLights(4, rgb3);
    writeToLargeLights(5, rgb4);
    writeToLargeLights(6, rgb5);
    writeToSmallLights(7, rgb6);
    writeToSmallLights(8, rgb7);
    writeToSmallLights(9, rgb8);
    writeToSmallLights(10, rgb9);
    writeToSmallLights(11, rgb10); //APPARENTLY LIGHT 10 CH101 - 104 FUCKS SHT UP!?!?!?!
    writeToSmallLights(12, rgb11);




    /*------------------------------FOR TESTING WITH ONE LIGHT ONLY------------------------------*/

  }
}



// pitchToColourCalc(fre1, 9, 0, rgb9, /*compareRGB9,*/ hue, sat, bri);
// //pitchToColourDisplay(rgb9, compareRGB9, displayRGB9);

//Continously output to lights
//writeToLights(2, rgb9 /*displayRGB9*/);

//}




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
