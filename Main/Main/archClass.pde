/*
This class produces three arches with circels on either side representing each singer. Each of the singers
circles change colour depending on the singers pitch and the arches between them are a combination of both
colours. This is used to represent dissonance in the piece of music.
*/

class archClass{

	float xStartPos, yStartPos, xEndPos, yEndPos, size, yStartInitial, yEndInitial, xStartInitial, xEndInitial; //Initial positions
	int extraHeight;
	int minPitch1, minPitch2, maxPitch1, maxPitch2, pitch1, pitch2; //Ranges recieved from text files
	int [] pitchCompare1 = new int [2]; //Used for gradual colour changes
	int [] pitchCompare2 = new int [2];
	int colourGlide = 1;
	boolean NEXT1, NEXT2;
	int radius1, radius2;
	int alpha1 = 100;
	int alpha2 = 100;
	int transparency = 2;
	reverbRings reverb1;
	reverbRings reverb2;
	int [] xStartPosition = new int[2];
	int [] xEndPosition = new int[2];
	int [] yStartPosition = new int[2];
	int [] yEndPosition = new int[2];
	int movementCounter = 0;
	

	//Constructor
	archClass(int iXStartPos, int iYStartPos, int iXEndPos, int iYEndPos, int iSize){
		xStartPos = iXStartPos;
		yStartPos = iYStartPos;
		xEndPos = iXEndPos;
		yEndPos = iYEndPos;

		size = iSize;

		reverb1 = new reverbRings(xStartPos,yStartPos); //Extra idea that was not used
		reverb2 = new reverbRings(xEndPos,yEndPos);

		yStartPosition[1] = iYStartPos;
		yEndPosition[1] = iYEndPos;
		yStartInitial = iYStartPos;
		yEndInitial = iYEndPos;
		xStartInitial = iXStartPos;
		xEndInitial = iXEndPos;

	}


void drawArch(){

	//Height of arches flicers to produce colour pattern
	extraHeight = int(random(0,30));

	movementCounter++; //Moves the circles around
	if(movementCounter >= 30){ //Calculates new positions
		movementCounter = 0;
	xStartPosition[1] = xStartPosition[0];
	xStartPosition[0] = int(random(0,100));
	xEndPosition[1] = xEndPosition[0];
	xEndPosition[0] = int(random(0,100));

	yStartPosition[0] = int(random(0,100));
	yEndPosition[0] = int(random(0,100));
	}

	if (xStartPosition[0] > xStartPosition[1]){//Slowly moves circle to new position
		xStartPos+= 0.1;
		if(xStartPos >= xStartInitial + 10){
			xStartPos = xStartInitial + 10;
		}
	} else if(xStartPosition[0] < xStartPosition[1]){
		xStartPos-= 0.1;
		if(xStartPos <= xStartInitial - 10){
			xStartPos = xStartInitial - 10;
		}
	}

	if (xEndPosition[0] > xEndPosition[1]){
		xEndPos += 0.1;
		if(xEndPos >= xEndInitial + 10){
			xEndPos = xEndInitial + 10;
		}
	} else if(xEndPosition[0] < xEndPosition[1]){
		xEndPos -= 0.1;
		if(xEndPos <= xEndInitial - 10){
			xEndPos = xEndInitial - 10;
		}
	}

	if(yStartPosition[0] > yStartPosition[1]){
		yStartPos += 0.1;
		if(yStartPos >= yStartInitial + 10){
			yStartPos = yStartInitial + 10;
		}
	} else if (yStartPosition[0] < yStartPosition[1]){
		yStartPos -= 0.1;
		if(yStartPos <= yStartInitial - 10){
			yStartPos = yStartInitial - 10;
	}
}
	
		if(yEndPosition[0] > yEndPosition[1]){
		yEndPos += 0.1;
		if(yEndPos >= yEndInitial + 10){
			yEndPos = yEndInitial + 10;
		}
	} else if (yEndPosition[0] < yEndPosition[1]){
		yEndPos -= 0.1;
		if(yEndPos <= yEndInitial - 10){
			yEndPos = yEndInitial - 10;
	}
}

	colorMode(HSB,360,100,100,100);
	float midPoint = xEndPos - (xEndPos-xStartPos)/2;

	if(pitchCompare1[0] > pitchCompare1[1]){ //Circluar colour calculator
		pitch1 -= colourGlide;
		if(pitch1 <= 0){
			pitch1 = 360;
		}
	} else if (pitchCompare1[0] < pitchCompare1[1]){
		pitch1 += colourGlide;
		if(pitch1 >= 360){
			pitch1 = 0;
		}
	}

	if(pitchCompare2[0] > pitchCompare2[1]){
		pitch2 -= colourGlide;
		if(pitch2 <= 0){
			pitch2 = 360;
		}
	} else if (pitchCompare2[0] < pitchCompare2[1]){
		pitch2 += colourGlide;
		if(pitch2 >= 360){
			pitch2 = 0;
		}
	}

	int bri1 = 70;
	int bri2 = 70;
	int sat1 = 100;
	int sat2 = 100;	

	//drawArch for first circle
	noStroke();
	fill(pitch1,bri1,sat1,transparency);
	beginShape();
	curveVertex(xStartPos, yStartPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xEndPos,yEndPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape(CLOSE);
	noStroke();
	fill(pitch1,bri1,sat1,transparency);
	beginShape();
	curveVertex(xEndPos, yEndPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xStartPos,yStartPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape();


	noStroke();
	fill(pitch2,bri2,sat2,transparency);
	beginShape();
	curveVertex(xEndPos, yEndPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xStartPos,yStartPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape();
	noStroke();
	fill(pitch2,bri2,sat2,transparency);
	beginShape();
	curveVertex(xStartPos, yStartPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xEndPos,yEndPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape(CLOSE);

	//Draw circles
	stroke(pitch1,bri1,sat1);
	fill(pitch1,bri1,sat1,0);
	ellipse(xStartPos, yStartPos, size, size);

	//End Circle
	stroke(pitch2,bri2,sat2);
	fill(pitch2,bri2,sat2,0);
	ellipse(xEndPos, yEndPos, size, size);
}

class reverbRings{//Idea that was never used

float xPos, yPos;
int r = 0;
int alpha = 100;

	//Constructor
	reverbRings(float iXPos, float iYPos){
		xPos = iXPos;
		yPos = iYPos;
	}

	void drawRings(){
	r += 2;
    alpha -= 1;

    if (alpha <= 0) {
        r = 0;
        alpha = 100;
    }

    stroke(0, 0, 0, alpha);
    fill(0, 0, 0, 0);
    beginShape();
    for (int i = 0; i < r; i++) {
      float x = cos(radians(i*360/r))*r;
      float y = sin(radians(i*360/r))*r;
      vertex(x+xPos, y+yPos);
    }
    endShape(CLOSE);
	}


void setRange(int MinPitch1, int MaxPitch1, int MinPitch2, int MaxPitch2) {
    minPitch1 = MinPitch1;
    maxPitch1 = MaxPitch1;
    minPitch2 = MinPitch2;
    maxPitch2 = MaxPitch2;
    
  }

void getPitch(int inPitch1, int inPitch2){

	 if(NEXT1 == true){ pitchCompare1[1] = pitchCompare1[0];
	}
	if(NEXT2 == true){	pitchCompare2[1] = pitchCompare2[0];
	}
	 pitchCompare1[0] = int(map(inPitch1,minPitch1,maxPitch1,0,360));
	 pitchCompare2[0] = int(map(inPitch2,minPitch2,maxPitch2,0,360));
}

void getNext(boolean Next1, boolean Next2){
	NEXT1 = Next1;
	NEXT2 = Next2;
}


}