/*
RGB data variables and arrays
*/

float timer; //Time program runs

int cueArray[36];

int fre1, fre2, fre3, fre4, fre5, fre6;
int dur1, dur2, dur3, dur4, dur5, dur6;

int in[3]; //Input from Processing

int state; //Function to run will change depending on where we are in the program/music
int function; //Used to manually select which test function to run

//Hardcode range variables (Taken from Processing)
int maxPitch[6];
int minPitch[6];
int maxDuration[6];

int panArray[8];
int tiltArray[8];
int movementSpeedArray[8];
int redArray[10];
int greenArray[10];
int blueArray[10];
int whiteArray[10];
int dimmerArray[8];
int shutterArray[8];

//circlesCopy variables
int hue[14];
int bri[14];
int sat[14];

int lightFaderSpeed = 5; //Speed of lights fade
int fadeCounter;

int whiteValue; //For softWhiteGlow();
int increment; 	//For softWhiteGlow();
boolean maxDone, minDone;
int count; //To run certain functions only once

  boolean maxReached;

int rgb0[4]; //Stores Target RGBW Value
int rgb1[4];
int rgb2[4];
int rgb3[4];
int rgb4[4];
int rgb5[4];
int rgb6[4];
int rgb7[4];
int rgb8[4];
int rgb9[4];
int rgb10[4];
int rgb11[4];


int move0[3];//Pan, rotation, Speed
int move1[3];
int move2[3];
int move3[3];
int move4[3];

int compareRGB1[3]; //Stores previous RGB Value
int compareRGB2[3];
int compareRGB3[3];
int compareRGB4[3];
int compareRGB5[3];
int compareRGB6[3];
int compareRGB7[3];
int compareRGB8[3];
int compareRGB9[3];
int compareRGB10[3];
int compareRGB11[3];
int compareRGB12[3];
int compareRGB13[3];
int compareRGB14[3];

int displayRGB1[3]; //RGB values to fade between Target and Previous RGB values
int displayRGB2[3];
int displayRGB3[3];
int displayRGB4[3];
int displayRGB5[3];
int displayRGB6[3];
int displayRGB7[3];
int displayRGB8[3];
int displayRGB9[3];
int displayRGB10[3];
int displayRGB11[3];
int displayRGB12[3];
int displayRGB13[3];
int displayRGB14[3];
