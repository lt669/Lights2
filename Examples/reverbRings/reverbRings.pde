int radius;
int alpha = 100;
boolean pressed;
boolean DONE;

reverbRingsClass r1;
reverbRingsClass r2;

void setup(){
	size(400,400);
	r1 = new reverbRingsClass(100,100,0,100);
	r2 = new reverbRingsClass(100,200,0,100);
}

void draw(){
	background(-1);
	colorMode(HSB,360,100,100,100);

	if(pressed == true || DONE == false){
	radius += 1;
	alpha -= 1;
	}

	if(alpha <= 0){
		alpha = 100;
		radius = 0;
		DONE = true;
		pressed = false;
	}

	r1.drawRings(radius,alpha);
	r2.drawRings(radius,alpha);
}

void mousePressed(){
	pressed = true;
	println("PRESSED");
}