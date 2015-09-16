class archClass{

	float xStartPos, yStartPos, xEndPos, yEndPos, size;
	int extraHeight;
	int minPitch1, minPitch2, maxPitch1, maxPitch2, pitch1, pitch2;
	int [] pitchCompare1 = new int [2];
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

		reverb1 = new reverbRings(xStartPos,yStartPos);
		reverb2 = new reverbRings(xEndPos,yEndPos);

		yStartPosition[1] = iYStartPos;
		yEndPosition[1] = iYEndPos;

	}


void drawArch(){

	extraHeight = int(random(0,50));

	movementCounter++;
	if(movementCounter >= 30){
		movementCounter = 0;
	xStartPosition[1] = xStartPosition[0];
	xStartPosition[0] = int(random(0,100));
	xEndPosition[1] = xEndPosition[0];
	xEndPosition[0] = int(random(0,100));

	yStartPosition[0] = int(random(-1,1));
	yEndPosition[0] = int(random(-1,1));
	}

	if (xStartPosition[0] > xStartPosition[1]){
		xStartPos+= 0.1;
		if(xStartPos >= canX/3 + 10){
			xStartPos = canX/3 + 10;
		}
	} else if(xStartPosition[0] < xStartPosition[1]){
		xStartPos-= 0.1;
		if(xStartPos <= canX/3 - 10){
			xStartPos = canX/3 - 10;
		}
	}

	if (xEndPosition[0] > xEndPosition[1]){
		xEndPos += 0.1;
		if(xEndPos >= canX*2/3 + 10){
			xEndPos = canX*2/3 + 10;
		}
	} else if(xEndPosition[0] < xEndPosition[1]){
		xEndPos -= 0.1;
		if(xEndPos <= canX*2/3 - 10){
			xEndPos = canX*2/3 - 10;
		}
	}

		yStartPos += yStartPosition[1] + yStartPosition[0];
		if(yStartPos >= yStartPosition[1] + 10){
			yStartPos = yStartPosition[1] + 10;
		}
	

		yEndPos += yEndPosition[1] + yEndPosition[0];
		if(yEndPos >= yEndPosition[1] + 10){
			yEndPos = yEndPosition[1] + 10;
		}

	colorMode(HSB,360,100,100,100);
	float midPoint = xEndPos - (xEndPos-xStartPos)/2;

	if(pitchCompare1[0] > pitchCompare1[1]){
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

	// int bri1 = int(map(pitch1,0,360,0,100));
	// int bri2 = int(map(pitch1,0,360,0,100));
	// int sat1 = int(map(pitch1,0,360,0,100));
	// int sat2 = int(map(pitch1,0,360,0,100));

	int bri1 = 70;
	int bri2 = 70;
	int sat1 = 70;
	int sat2 = 70;	

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
	fill(pitch1,bri1,sat1);
	ellipse(xStartPos, yStartPos, size, size);

	//End Circle
	fill(pitch2,bri2,sat2);
	ellipse(xEndPos, yEndPos, size, size);


	// if(NEXT1 == true || alpha1 != 0){
	// 	reverb1.drawRings();
	// }
	// if(NEXT2 == true || alpha2 != 0){
	// 	reverb2.drawRings();
	// }

}

class reverbRings{

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

}

void reverbRings(int xPos, int yPos, int r, int alpha){

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