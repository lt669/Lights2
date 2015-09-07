void setup(){
	size (400,400);

	colorMode(HSB,360,100,100);

	fill(180,100,100);
	rect(100,100,50,50);

	int colourHSB = color(HSB,180,100,100);

	float red = red(colourHSB);
	float green = green(colourHSB);
	float blue = blue(colourHSB);

	println("red: "+red+" green: "+green+" blue: "+blue);
}

void draw(){
	
}