#include <SoftwareSerial.h>

#include <DMXSerial.h>

void setup() {
  // put your setup code here, to run once:
    //DMXSerial.begin(9600);
    DMXSerial.init(DMXController);
    DMXSerial.write(1,1);//Send value to establish contact

}

void loop() {
  // put your main code here, to run repeatedly:

}
