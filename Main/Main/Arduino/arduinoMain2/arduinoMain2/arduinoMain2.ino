#include <HSBColor.h>

//#include <color.h>
//#include <colorpalettes.h>
//#include <hsv2rgb.h>
#include <DmxMaster.h>
//#include <RGBConverter.h>

//#include <SoftwareSerial.h>
//
//#include <DMXSerial.h>

void setup() {
  // put your setup code here, to run once:
  //DMXSerial.begin(9600);
  //    DMXSerial.init(DMXController);
  //    DMXSerial.write(1,1);//Send value to establish contact
  Serial.begin(9600);
  Serial.println("READY");

  int rgb[3];

  for(int i = 100; i<110; i++){
  H2R_HSBtoRGB(i, 100, 100, rgb);


  
  
  Serial.print("i: ");
  Serial.print(i);
  Serial.print(" r: ");
  Serial.print(rgb[0]);
  Serial.print(" g: ");
  Serial.print(rgb[1]);
  Serial.print(" b: ");
  Serial.println(rgb[2]);
}

}

void loop() {
  // put your main code here, to run repeatedly:

}
