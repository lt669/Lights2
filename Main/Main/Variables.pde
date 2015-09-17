//Mac
int canX = 1920;
int canY = 1080;

//MovieMaker
int fps = 60;

boolean first, second;
int backCount = 0;
int BGhue = 0;
int BGsat = 0;
int BGbri = 100;
int colorBright; //graphics brightness variable
int select; //Bckground colour changer and other variables)
//Cicles Variables
Table table;
int dur = 0;
int pit = 0;
PImage img;
char circleKey;
char squigleKey;
int choice = 0;
//char choice;

//Squigle Variables
float check = 0;
char nPoints;
//int nPoints = 1;
float newX = canX/2;
float newY = canY/2;
int input;
boolean pressed;
float move;

float startBang = 1.0;
float stopBang = 1.0;

int x =0;
int cueAddress;

int[] comp = new int[2];

int state; //What the Arduino should run

int count; //Prevent screen from fading multiple times

/*---------------CUES---------------*/
int[] cueArray = new int[31];
void setCues(){
  cueArray[0] = 0;
  cueArray[1] = 68000;
  cueArray[2] = 180000;
  cueArray[3] = 240000;
  cueArray[4] = 300000;
  cueArray[5] = 408000;
  cueArray[6] = 496000;
  cueArray[7] = 564000;
  cueArray[8] = 624000;
  cueArray[9] = 708000;
  cueArray[10] = 768000;
  cueArray[11] = 830000;
  cueArray[12] = 856000;
  cueArray[13] = 916000;
  cueArray[14] = 930000;
  cueArray[15] = 955000;
  cueArray[16] = 1000000;
  cueArray[17] = 1036000;
  cueArray[18] = 1100000;
  cueArray[19] = 1176000;
  cueArray[20] = 1216000;
}
/*---------------CUES---------------*/
