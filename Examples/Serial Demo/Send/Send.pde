import processing.serial.*;
Serial port;


int val = 0;
boolean NEXT = false;
int received = 1;
int var;
int[] in = new int[3];
int h;
int count;
int counter = 0;
int first;
int second;
int third;

lightClass light1;
lightClass light2;

void setup()
{
  size(200, 200);
  //Mac
  //  port = new Serial(this, "/dev/tty.usbmodem641", 9600); 

  //PC
  port = new Serial(this, "COM4", 9600); 
  port.bufferUntil(1);

  println("Initial Receive", received);

  light1 = new lightClass(1, 5, 3, 3, 225);
  light2 = new lightClass(2, 5, 6, 3, 225);
}

void draw() {
  if (NEXT == true) {
    if (count == 0) {
      count++;
      if (counter == 0) {
        println("Counter: 0");
        // light2.sendData();
        light1.sendData();
      } else if (counter == 1) {
        println("Counter: 1");
        light1.sendData();
      } else if (counter == 2) {
        println("Counter: 2");
        light2.sendData();
      }
      counter++;
      if (counter >=3) {
        counter = 0;
      }
    }
  }

  /*-----------DUMMY PROGRAM-----------*/
  //if (NEXT == true) {
  //if (count == 0) {//Prevent from triggering multiple times per click

  // val = 0;

  //Random values (ON/OFF
  //      int first = int(random(2, 8));
  //      int second = int(random(2, 8));
  //      int third = int(random(2, 8));

  //Random BRIGHTNESS values
  //      int first = int(random(0, 255));
  //      int second = int(random(0, 255));
  //      int third = int(random(0, 255));

  /*-----------THIS WORKING-----------*/

  //  int position = int(map(mouseX, 0, 200, 0, 255));
  //
  //  first += 20;
  //  second += 20;
  //  third += 20;
  //
  //  if (first >= 255) {
  //    first = 0;
  //    second = 0;
  //    third = 0;
  //  }
  //
  //  //Convert to a string
  //  String firstS = str(first);
  //  String secondS = str(second);
  //  String thirdS = str(third);
  //  String mouse = str(position);
  //
  //  //println(""+first+","+second+","+third);
  //  println("mouse: "+mouse+" position: "+position);
  //  while (val != 1) {
  //    port.write(""+mouse+","+mouse+","+mouse);
  //    val = port.read();
  //    println("Loop Val:", val);
  //    if (val == 1) {
  //      println("val: ", val);
  //      break;
  //    }
  //  }
  //  val = port.read();
  //  println("FIRST VAL: ", val);
  //  count++;

  /*-----------THIS WORKING-----------*/

  //}
  //}
}

/*-----------DUMMY PROGRAM-----------*/

void mousePressed() {
  NEXT = true;
  println("Pressed");
}
void mouseReleased() {
  NEXT = false;
  count = 0;
}

