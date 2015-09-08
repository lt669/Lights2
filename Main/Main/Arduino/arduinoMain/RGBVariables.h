/*
RGB data variables and arrays
*/

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

int lightFaderSpeed = 5; //Speed of lights fade

int rgb1[3]; //Stores Target RGB Value
int rgb2[3];
int rgb3[3];
int rgb4[3];
int rgb5[3];
int rgb6[3];
int rgb7[3];
int rgb8[3];
int rgb9[3];
int rgb10[3];
int rgb11[3];
int rgb12[3];
int rgb13[3];
int rgb14[3];

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