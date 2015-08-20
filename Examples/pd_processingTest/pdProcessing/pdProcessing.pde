import org.puredata.processing.PureData;

PureData pd;

void setup()
{
  size(350, 350);
  
  //initialize pd with audio rate of 44100, no inputs, and two 
  //outputs, load the patch sine.pd, and start the object
  pd = new PureData(this, 44100, 0, 2);
  pd.openPatch("sine.pd");
  pd.start();
}

void draw()
{
  //refresh the background and draw a red cirle at mouse position
  background(0);
  fill(255, 0, 0);
  ellipseMode(CENTER);
  ellipse(mouseX, mouseY, 20, 20);
  
  //send normalized x-y position as float message to [receive]
  //objects "pitch" and "volume" in Pd
  pd.sendFloat("pitch", (float)mouseX / (float)width); 
  pd.sendFloat("volume", (float)(height - mouseY) / (float)height);
}
