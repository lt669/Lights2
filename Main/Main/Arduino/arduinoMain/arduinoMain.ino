#include <DMXSerial.h>

//#include <DmxMaster.h>
//
//#include <DMXSerial.h>
//
//#include <DmxSimple.h>
//
//#include <SoftwareSerial.h>


/*------DMX ADDRESSES------*/
int panL1 = 1;
int tiltL1 = 2;
int speelL1 = 3;
int redL1 = 4;
int blueL1 = 5;
int greenL1 = 6;

int panL2 = 7;
int tiltL2 = 8;
int speelL2 = 9;
int redL2 = 10;
int blueL2 = 11;
int greenL2 = 12;

int panL3 = 13; 
int tiltL3 = 14;
int speelL3 = 15;
int redL3 = 16;
int blueL3 = 17;
int greenL3 = 18;

int panL4 = 19;
int tiltL4 = 20;
int speelL4 = 21;
int redL4 = 22;
int blueL4 = 23;
int greenL4 = 24;

int panL5 = 25;
int tiltL5 = 26;
int speelL5 = 27;
int redL5 = 28;
int blueL5 = 29;
int greenL5 = 30;

int panL6 = 31;
int tiltL6 = 32;
int speelL6 = 33;
int redL6 = 34;
int blueL6 = 35;
int greenL6 = 36;

int panL7 = 37;
int tiltL7 = 38;
int speelL7 = 39;
int redL7 = 40;
int blueL7 = 41;
int greenL7 = 42;

int panL8 = 43;
int tiltL8 = 44;
int speelL8 = 45;
int redL8 = 46;
int blueL8 = 47;
int greenL8 = 48;
/*------DMX ADDRESSES------*/

int fre1, fre2, fre3, fre4, fre5, fre6;
int dur1, dur2, dur3, dur4, dur5, dur6;

int in[3]; // Input from Processing

int situation; //Function to run will change depending on where we are in the program/music

void setup() {

	Serial.begin(9600);
  Serial.write(1);//Send value to establish contact
}

void loop(){
while (Serial.available() >= 3) {// wait for 3 ints to arrive (Keep having to change this?)
     in[0] = Serial.parseInt();
     in[1] = Serial.parseInt();
     in[2] = Serial.parseInt();
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
    } else if (in[0] == 7){
    	situation = in[1];
    }

    if(situation == 1){
    	function1();
    }
}

void function1(){
	DMXSerial.write(panL1, in[0]);
}
