//Test functions to try with the light
int pan, tilt, movementSpeed, red, green, blue, white, dimmer, strobe;
void spin(int panAddress, int tiltAddress, int speedAddress, int redAddress, int greenAddress, int blueAddress, int whiteAddress, int one, int two, int three) {


  if (state == 1) {
    red = one;
    green = two;
    blue = three;
    dimmer = 255;
    strobe = 255;
  } else if (state == 2) {
    pan = one;
    tilt = two;
    movementSpeed = three;
  } else if (state == 3) {
    white = one;
    dimmer = two;
    strobe = three;
  }

  Serial.print("red ");
  Serial.print(red);
  Serial.print(" green ");
  Serial.print(green);
  Serial.print(" blue ");
  Serial.print(blue);
  Serial.print(" white ");
  Serial.print(white);
  Serial.print(" pan ");
  Serial.print(pan);
  Serial.print(" tilt ");
  Serial.print(tilt);
  Serial.print(" speed: ");
  Serial.println(movementSpeed);

  
 DmxMaster.write(panAddress, pan);
 DmxMaster.write(tiltAddress, tilt);
 DmxMaster.write(speedAddress, movementSpeed);
 DmxMaster.write(redAddress, red);
 DmxMaster.write(greenAddress, green);
 DmxMaster.write(blueAddress, blue);
 DmxMaster.write(whiteAddress, white);
 // DmxMaster.write(10, dimmer);
 // DmxMaster.write(11, strobe); 
 // DmxMaster.write(24, dimmer);
 // DmxMaster.write(25, strobe); 
 DmxMaster.write(38, dimmer);
 DmxMaster.write(39, strobe); 


}
