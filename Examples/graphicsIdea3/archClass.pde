class archClass{

	int xStartPos, yStartPos, xEndPos, yEndPos, size/*, pitch1, pitch2*/;
	int extraHeight = 20;
	

	//Constructor
	archClass(int iXStartPos, int iYStartPos, int iXEndPos, int iYEndPos, int iSize){
		xStartPos = iXStartPos;
		yStartPos = iYStartPos;
		xEndPos = iXEndPos;
		yEndPos = iYEndPos;

		size = iSize;

	}


void drawArch(int r1, int g1, int b1, int r2, int g2, int b2){


	int midPoint = xEndPos - (xEndPos-xStartPos)/2;

	//Convert Pitch

	//drawArch for first circle
	noStroke();
	fill(r1,g1,b1,50);
	beginShape();
	curveVertex(xStartPos, yStartPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xEndPos,yEndPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape(CLOSE);
	noStroke();
	fill(r1,g1,b1,50);
	beginShape();
	curveVertex(xEndPos, yEndPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xStartPos,yStartPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape();


	noStroke();
	fill(r2,g2,b2,50);
	beginShape();
	curveVertex(xEndPos, yEndPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xStartPos,yStartPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape();
	noStroke();
	fill(r2,g2,b2,50);
	beginShape();
	curveVertex(xStartPos, yStartPos);
	curveVertex(midPoint, yStartPos + extraHeight);
	curveVertex(xEndPos,yEndPos);
	curveVertex(midPoint, yStartPos - extraHeight);
	curveVertex(xStartPos, yStartPos);
	endShape(CLOSE);

		//Draw circles
	fill(r1,g1,b1);
	ellipse(xStartPos, yStartPos, size, size);

	//End Circle
	fill(r2,g2,b2);
	ellipse(xEndPos, yEndPos, size, size);

}


}