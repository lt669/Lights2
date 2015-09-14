//Mac
int canX = 800;
int canY = 400;

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

int state = 1; //What the Arduino should run

/*---------------CUES---------------*/
int[] cueArray = new int[17];
void setCues(){
cueArray[0] = 8000;
cueArray[1] = 68000;
cueArray[2] = 180000;
cueArray[3] = 256000;
cueArray[4] = 408000;
cueArray[5] = 496000;
cueArray[6] = 564000;
cueArray[7] = 708000;
cueArray[8] = 764000;
cueArray[9] = 784000;
cueArray[10] = 856000;
cueArray[11] = 916000;
cueArray[12] = 968000;
cueArray[13] = 984000;
cueArray[14] = 1036000;
cueArray[15] = 1100000;
cueArray[16] = 1176000;
}
/*---------------CUES---------------*/
