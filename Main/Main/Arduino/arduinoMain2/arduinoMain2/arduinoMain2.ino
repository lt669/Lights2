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

  int rgb[6];
//  rgb[3] = 9;
//  rgb[4] = 9;
//  rgb[5] = 9;
  for(int i = 100; i<110; i++){
  H2R_HSBtoRGB(i, 100, 100, rgb);
    
  Serial.print("i: ");
  Serial.print(i);
  Serial.print(" r: ");
  Serial.print(rgb[0]);
  Serial.print(" g: ");
  Serial.print(rgb[1]);
  Serial.print(" b: ");
  Serial.print(rgb[2]);
  Serial.print(" [3]: ");
  Serial.print(rgb[3]);
  Serial.print(" [4]: ");
  Serial.print(rgb[4]);
  Serial.print(" [5]: ");
  Serial.println(rgb[5]);
}

}

void loop() {
  // put your main code here, to run repeatedly:

}
