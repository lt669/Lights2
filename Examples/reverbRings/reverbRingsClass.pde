class reverbRingsClass{

int xPos,yPos, r, alpha;

	//Constructor
	reverbRingsClass(int iXPos, int iYPos, int iR, int iAlpha){
		xPos = iXPos;
		yPos = iYPos;
		r = iR;
		alpha = iAlpha;
	}

void drawRings(int r, int alpha){

	stroke(0,0,0,alpha);
	fill(0,0,0,0);
	beginShape();
	for (int i = 0; i < r; i++) {
	float x = cos(radians(i*360/r))*r;
	float y = sin(radians(i*360/r))*r;
	vertex(x+xPos,y+yPos);
}
	endShape(CLOSE);
}

}