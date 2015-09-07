#include <HSBColor.h>
#include <RGBConverter.h>
#include <DmxMaster.h>
#include <DMXAddresses.h>

int fre1, fre2, fre3, fre4, fre5, fre6;
int dur1, dur2, dur3, dur4, dur5, dur6;

int in[3]; // Input from Processing

int state; //Function to run will change depending on where we are in the program/music

//Hardcode range variables (Taken from Processing)
int maxPitch[6];
int minPitch[6];
int maxDuration[6];

//circlesCopy variables
int hue[14];
int bri[14];
int sat[14];

int rgb1[6]; //Current values: 1-3 Previous values: 4-6
int rgb2[6];
int rgb3[6];
int rgb4[6];
int rgb5[6];
int rgb6[6];
int rgb7[6];
int rgb8[6];
int rgb9[6];
int rgb10[6];
int rgb11[6];
int rgb12[6];
int rgb13[6];
int rgb14[6];

int fader = 5; //Speed of lights fade

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
  
  if(state == 1){
  //Contiuously outputs data to the lights
  pitchToColourDisplay();
}

  //Output to lights
  writeToLights(redL1, greenL1, blueL1, red1, green1, blue1);
}

void SerialEvent(){
  while (Serial.available() >= 3) {// wait for 3 ints to arrive (Keep having to change this?)
    in[0] = Serial.parseInt(); //TAG
    in[1] = Serial.parseInt(); //pitch
    in[2] = Serial.parseInt(); //duration
    in[3] = Serial.parseInt(); //state
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
  } else if (in[0] == 7) {
    state = in[3];
  }

  //Colour and movment calculations based on the state
  if (state == 1) {
    pitchToColour(fre1,9,0,rgb9); //SingerPitch, Light, Singer, Light
  }
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

void pitchToColourCalc(int frequency, int light, int singer, int rgb[6]){
  
  //Map the frequency to color (using map)
  mapHSB(frequency,light,singer); //SingerPitch, Light, Singer

  //Shift previous values
  RGBShift(rgb);

  //Convert HSB to RGB
  H2R_HSBtoRGB(hue[light], sat[light], bri[light], rgb);
}

void pitchToColourDisplay(){
  //Compare current values to previous
  compareRed(rgb);
}

void mapHSB(int freq, int count, int count2){
    //Maps 
    hue[count] = int(map(freq, minPitch[count2], maxPitch[count2], 0, 360));
    sat[count] =  int(map(freq, minPitch[count2], maxPitch[count2], 0, 100));
    bri[count] = int(map(freq, minPitch[count2], maxPitch[count2], 0, 70));
}

void writeToLights(int redAddress, int greenAddress, int blueAddress, int colour[6]){
    DmxMaster.write(redAddress, colour[0]);
    DmxMaster.write(greenAddress, colour[1]);
    DmxMaster.write(blueAddress, colour[2]);
}

void RGBShift(RGBArray[6]){
  RGBArray[0] = RGBArray[3];
  RGBArray[1] = RGBArray[4];
  RGBArray[2] = RGBArray[5];
}

void compareRGB(int initialArray[6], int targetArray[3]){
  targetArray[0] = compareRed(initialArray);
  targetArray[2] = compareGreen(initialArray);
  targetArray[3] = compareBlue(initialArray);
}

void compareRed(int compareRedArray[6]){
  if(compareRedArray[0] > compareRedArray[3]){
    red += fader;
  } else if (compareRedArray[0] < compareRedArray[3]){
    red -= fader;
  } else {
    red = red;
  }
  return red;
}

void compareGreen(int compareGreenArray[6]){
    if(compareGreenArray[1] > compareGreenArray[4]){
    green += fader;
  } else if (compareGreenArray[1] < compareGreenArray[4]){
    green -= fader;
  } else {
    green = green;
  }
  return green;
}

void compareBlue(int compareBlueArray[6]){
      if(compareBlueArray[2] > compareBlueArray[5]){
    blue += fader;
  } else if (compareBlueArray[2] > compareBlueArray[5]){
    blue -= fader;
  } else {
    blue = blue;
  }
  return blue
}


