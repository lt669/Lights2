//Test functions to try with the light

void spin(int panAddress, int tiltAddress, int speedAddress, int redAddress, int greenAddress, int blueAddress, int whiteAddress, int one, int two, int three){

int pan, tilt, movementSpeed, red, green, blue, white;

	if(state == 0){
		red = one;
		green = two;
		blue = three;
	} else if(state == 1){
		pan = one;
		tilt = two;
		movementSpeed = three;
	} else if(state == 2){
		white = one;
	}


	DmxMaster.write(panAddress, pan);
	DmxMaster.write(tiltAddress, tilt);
	DmxMaster.write(speedAddress, movementSpeed);
	DmxMaster.write(redAddress, red);
	DmxMaster.write(greenAddress, green);
	DmxMaster.write(blueAddress, blue);
	DmxMaster.write(whiteAddress, white);

}