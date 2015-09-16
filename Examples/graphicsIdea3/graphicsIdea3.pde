archClass arch1;
archClass arch2;
archClass arch3;

void setup(){
	size (400, 400);
	arch1 = new archClass(50,100,350,100,50);
	arch2 = new archClass(50,200,350,200,50);
	arch3 = new archClass(50,300,350,300,50);
}

void draw(){
	background(-1);
	arch1.drawArch(255,100,0,0,205,30);
	arch2.drawArch(0,100,58,12,106,200);
	arch3.drawArch(100,255,200,90,50,100);
