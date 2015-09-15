/**
	This file will contain all the functions called throughout the program
	in 'sequency'
*/


//Slowly fades to bright white, can be used at begining of the show
void slowBright(int x, int rgb[4], int fadeSpeed){
  //White light slowly fade
  fadeCounter++;
  if(fadeCounter >= fadeSpeed){ //Larger the number the slower the fade
  fadeCounter = 0;
  rgb[3] += 1;
  if(rgb[3] >= 255){
    rgb[3] = 255;
  }
}

    rgb[0] = 0;
    rgb[1] = 0;
    rgb[2] = 0;
  // DmxMaster.write(whiteArray[x], rgb[3]);
  // DmxMaster.write(dimmerArray[x], 255);
  // DmxMaster.write(shutterArray[x], 255);
}

//Function to turn selected lights off
void lightsOff(int x){
	DmxMaster.write(redArray[x], 0);
	DmxMaster.write(greenArray[x], 0);
	DmxMaster.write(blueArray[x], 0);
	DmxMaster.write(whiteArray[x], 0);
}

//Set the colour of a light manually
void setRGB(int rgb[4],int red, int green, int blue, int white){
	rgb[0] = red;
	rgb[1] = green;
	rgb[2] = blue;
	rgb[3] = white;
}

void setRotation(int x, int rotation, int tilt, int movementSpeed){
	DmxMaster.write(panArray[x],rotation);
	DmxMaster.write(tiltArray[x],tilt);
	DmxMaster.write(movementSpeedArray[x],movementSpeed);
}

void movingLight(int x, int movement[3]){


  movement[2] = 200; //Set speed
  movement[0] += increment;

  if(movement[0] >= 212){
    maxReached = true;
  } else if (movement[0] <= 128){
    maxReached = false;
  }

    if(maxReached == true){
      increment = -1;
    } else if (maxReached == false){
      increment = 1;
    }
  
  DmxMaster.write(panArray[x],movement[0]);
  DmxMaster.write(tiltArray[x],movement[1]);
  DmxMaster.write(movementSpeedArray[x],movement[2]);

}

//Used to convert data from Processing into the same colour as shown on screen(ish)
void pitchToColourCalc(int frequency, int light, int singer, int rgb[4]/*, int hue[14], int sat[14], int bri[14]*/) {
  //Map the frequency to color (using map)
  mapHSB(frequency, light, singer/*, hue, sat, bri*/); //SingerPitch, Light, Singer, (arrays to save data to)
  //Convert HSB to RGB (Overwrites first three addresses of RGB)
  H2R_HSBtoRGB(hue[light], sat[light], bri[light], rgb);
  //Set whiteLight to 0
  rgb[3] = 0;
}

//Write the calculated data to the appropriate light
void writeToLights(int x, int colour[4]) { //x = channel
  DmxMaster.write(redArray[x], colour[0]);
  DmxMaster.write(greenArray[x], colour[1]);
  DmxMaster.write(blueArray[x], colour[2]);
  DmxMaster.write(whiteArray[x], colour[3]);
  if(x < 6){
  DmxMaster.write(dimmerArray[x], 255);
  DmxMaster.write(shutterArray[x], 255);
}
}

void writeMovement(int x, int movement[3]){
  DmxMaster.write(panArray[x],movement[0]);
  DmxMaster.write(tiltArray[x],movement[1]);
  DmxMaster.write(movementSpeedArray[x],movement[2]);
}

void softWhiteGlow(int x, int rgb[4], int fadeSpeed){

  int whiteMin = 50;
  int whiteMax = 120;


    rgb[3] += increment;

  if(rgb[3] >= whiteMax){
    maxDone = true;
  } else if(rgb[3] <= whiteMin){
    maxDone = false;
  }


  if(maxDone == false){
    increment = 1;
  } else if (maxDone == true){
    increment = -1;
  }

  //Set rest of colours to 0
  rgb[0] = 0;
  rgb[1] = 0;
  rgb[2] = 0;
    
  // DmxMaster.write(redArray[x], 0);
  // DmxMaster.write(greenArray[x], 0);
  // DmxMaster.write(blueArray[x], 0);
  // DmxMaster.write(whiteArray[x], rgb[3]);
}


//Compare two RGB values (NOT USED)
void pitchToColourDisplay(int rgb[3], int rgbCompare[3], int targetArray[3]) {
  //Compare current values to previous
  compareRGB(rgb, rgbCompare, targetArray);
}
