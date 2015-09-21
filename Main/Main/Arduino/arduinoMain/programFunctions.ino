/**
	This file will contain all the functions called throughout the program
	in 'sequence'
*/



void glowBrightnessCounter(int fadeSpeed, int maxBright, int minBright){
    fadeCounter++;
    if (fadeCounter >= fadeSpeed) {
      fadeCounter = 0;
      brightness += brightnessDirection;

      if (brightness >= maxBright) {
        brightnessDONE = true;
      } else if (brightness <= minBright) {
        brightnessDONE = false;
      }

      if (brightnessDONE == true) {
        brightnessDirection = -1;
      } else if (brightnessDONE == false) {
        brightnessDirection = 1;
      }
  }
}

void slowBrightnessCounter(int fadeSpeed, int maxBright){
  fadeCounter++;
    if (fadeCounter >= fadeSpeed) {
      fadeCounter = 0;
      if (brightness >= maxBright) {
        brightnessDONE = true;
      } else {
        brightnessDONE = false;
      }

      if(brightnessDONE == true){
        brightness = brightness;
      } else if (brightnessDONE == false){
        brightness += 1;
      } 
    }
}

//Slowly fades to bright white, can be used at begining of the show
void slowBright(int x, int rgb[4], int fadeSpeed, int maxLight){
  //White light slowly fade
  fadeCounter++;
  if(fadeCounter >= fadeSpeed){ //Larger the number the slower the fade
  fadeCounter = 0;

  if(x<6){ //Large Lights
    rgb[3] += 1;
    if(rgb[3] >= maxLight){
      rgb[3] = maxLight;
    }
    rgb[0] = 0;
    rgb[1] = 0;
    rgb[2] = 0;
  } else { //Small Lights
    rgb[0] += 1;
    rgb[1] += 1;
    rgb[2] += 1;
    if(rgb[0] >= maxLight){
      rgb[0] = maxLight;
      rgb[1] = maxLight;
      rgb[2] = maxLight;
    }
  }
}


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
  if(red >= 255){
    red = 255;
  }
  if(green >= 255){
    green = 255;
  }
  if(blue >= 255){
    blue = 255;
  }
  if(white >= 255){
    white = 255;
  }
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

void movingLight(int x, int movement[3], int tilt, int movementSpeed, int maxRot, int minRot,int counterSize){

  movement[1] = tilt;
  movement[2] = movementSpeed; //Set speed

  counter++;
  if(counter >= counterSize){
    counter = 0;
    counter2++;
    if(counter2 > 1){
      counter2 = 0;
    }
  }

  // Serial.print("movement[0]: ");
  // Serial.print(movement[0]);
  // Serial.print("counter: ");
  // Serial.print(counter);
  // Serial.print("counter2: ");
  // Serial.println(counter2);

  if(counter2 == 0){
    movement[0] = maxRot;
  } else if (counter2 == 1){
    movement[0] = minRot;
  }

  // if(movement[0] >= 212){
  //   maxReached = true;
  // } else if (movement[0] <= 128){
  //   maxReached = false;
  // }

  //   if(maxReached == true){
  //     increment = -1;
  //   } else if (maxReached == false){
  //     increment = 1;
  //   }
  
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
void writeToLargeLights(int x, int colour[4]) { //x = channel
  DmxMaster.write(redArray[x], colour[0]);
  DmxMaster.write(greenArray[x], colour[1]);
  DmxMaster.write(blueArray[x], colour[2]);
  DmxMaster.write(whiteArray[x], colour[3]);
  DmxMaster.write(dimmerArray[x], 255);
  DmxMaster.write(shutterArray[x], 255);
  
}

void writeToSmallLights(int x, int colour[4]){
  DmxMaster.write(redArray[x], colour[0]);
  DmxMaster.write(greenArray[x], colour[1]);
  DmxMaster.write(blueArray[x], colour[2]);
}

void writeMovement(int x, int movement[3]){
  DmxMaster.write(panArray[x],movement[0]);
  DmxMaster.write(tiltArray[x],movement[1]);
  DmxMaster.write(movementSpeedArray[x],movement[2]);
}

void softWhiteGlowLarge(int x, int rgb[4]){

  int whiteMin = 50;
  int whiteMax = 120;

  rgb[3] += increment[x];

  if(rgb[3] >= whiteMax){
    maxDone = true;
  } else if(rgb[3] <= whiteMin){
    maxDone = false;
  }


  if(maxDone == false){
    increment[x] = 1;
  } else if (maxDone == true){
    increment[x] = -1;
  }

  //Set rest of colours to 0
  rgb[0] = 0;
  rgb[1] = 0;
  rgb[2] = 0;
}

void softWhiteGlowSmall(int x, int rgb[4]){
  int whiteMin = 50;
  int whiteMax = 120;

  rgb[0] += increment[x];
  rgb[1] += increment[x];
  rgb[2] += increment[x];

    if(rgb[3] >= whiteMax){
    maxDone = true;
  } else if(rgb[3] <= whiteMin){
    maxDone = false;
  }

  if(maxDone == false){
    increment[x] = 1;
  } else if (maxDone == true){
    increment[x] = -1;
  }

}


//Compare two RGB values (NOT USED)
void pitchToColourDisplay(int rgb[3], int rgbCompare[3], int targetArray[3]) {
  //Compare current values to previous
  compareRGB(rgb, rgbCompare, targetArray);
}
