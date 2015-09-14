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
  DmxMaster.write(whiteArray[x], rgb[3]);
  DmxMaster.write(dimmerArray[x], 255);
  DmxMaster.write(shutterArray[x], 255);
}

//Function to turn selected lights off
void lightsOff(int x){
	DmxMaster.write(redArray[x], 0);
	DmxMaster.write(greenArray[x], 0);
	DmxMaster.write(blueArray[x], 0);
	DmxMaster.write(whiteArray[x], 0);
}

//Set the colour of a light manually
void setRGB(int rgb[3],int red, int green, int blue, int white){
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

//Used to convert data from Processing into the same colour as shown on screen(ish)
void pitchToColourCalc(int frequency, int light, int singer, int rgb[4], int hue[14], int sat[14], int bri[14]) {
  //Map the frequency to color (using map)
  mapHSB(frequency, light, singer, hue, sat, bri); //SingerPitch, Light, Singer, (arrays to save data to)
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
  DmxMaster.write(dimmerArray[x], 255);
  DmxMaster.write(shutterArray[x], 255);
}

void softWhiteGlow(int x, int rgb[4]){

  int whiteMin = 10;
  int whiteMax = 255;
  boolean maxDone, minDone;

  if(rgb[3] >= 100){
    maxDone = true;
  } else if(rgb[3] <= 10){
    maxDone = false;
  }

  if(maxDone == false){
    rgb[3]++;
  } else if (maxDone == true){
    rgb[3]--;
  }
    
  DmxMaster.write(redArray[x], 0);
  DmxMaster.write(greenArray[x], 0);
  DmxMaster.write(blueArray[x], 0);
  DmxMaster.write(whiteArray[x], rgb[3]);
}


//Compare two RGB values (NOT USED)
void pitchToColourDisplay(int rgb[3], int rgbCompare[3], int targetArray[3]) {
  //Compare current values to previous
  compareRGB(rgb, rgbCompare, targetArray);
}
