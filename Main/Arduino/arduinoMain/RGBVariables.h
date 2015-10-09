/*
RGB data variables and arrays
*/

boolean sendData = true;

float timer; //Time program runs
float last;

int cueArray[21];

int fre1, fre2, fre3, fre4, fre5, fre6;
int dur1, dur2, dur3, dur4, dur5, dur6;

int in[3]; //Input from Processing

int inputState = 0; //First contact with processing
int state = 0; //Function to run will change depending on where we are in the program/music
int function; //Used to manually select which test function to run

//Hardcode range variables (Taken from Processing)
int maxPitch[6];
int minPitch[6];
int maxDuration[6];

int panArray[7];//First address in each array '0' is not used due to a bug it causes
int tiltArray[7];
int movementSpeedArray[7];
int redArray[13];
int greenArray[13];
int blueArray[13];
int whiteArray[7];
int dimmerArray[13];
int shutterArray[13];

//circlesCopy variables
int hue[12];
int bri[12];
int sat[12];

int lightFaderSpeed = 5; //Speed of lights fade
int fadeCounter;

int whiteValue; //For softWhiteGlow();
int increment[12]; 	//For softWhiteGlow();
boolean maxDone, minDone;
int count; //To run certain functions only once
int counter;
int counter2;
boolean maxReached;

int brightness;			//For the dissonance bit
int brightnessDirection;
boolean brightnessDONE;

//SMALL LIGHT FADING
int smallLightBrightness;
int smallLightFadeCounter;
boolean smallLightBrightnessBool;


int rgb0[4]; //Unused Array
int rgb1[4];//Stores Target RGBW Value
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
int rgb12[4];


int move0[3];//Pan, rotation, Speed
int move1[3];
int move2[3];
int move3[3];
int move4[3];
