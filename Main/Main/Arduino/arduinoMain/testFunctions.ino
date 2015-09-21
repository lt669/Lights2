//Test functions to try with the light
int pan, tilt, movementSpeed, red, green, blue, white, dimmer, strobe, colourCounter;
void spin(int x, int one, int two, int three) { // x = address


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

//  colourCounter++;
//  if(colourCounter = 30){
//    colourCounter = 0;
//  red += 5;
//  if(red >= 255){
//    red = 0;
//  }
//  green += 3;
//  if(green >= 255){
//    green = 0;
//  }
//  blue += 1;
//  if(blue >= 255){
//    blue = 0;
//  }
//}

  Serial.print("panArray[x] ");
  Serial.print(panArray[x]);
  Serial.print(" red ");
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



  
 DmxMaster.write(panArray[x], pan);
 DmxMaster.write(tiltArray[x], tilt);
 DmxMaster.write(movementSpeedArray[x], movementSpeed);
 DmxMaster.write(redArray[x], red);
 DmxMaster.write(greenArray[x], green);
 DmxMaster.write(blueArray[x], blue);
 DmxMaster.write(whiteArray[x], white);
 DmxMaster.write(dimmerArray[x], dimmer);
 DmxMaster.write(shutterArray[x], strobe); 


}
