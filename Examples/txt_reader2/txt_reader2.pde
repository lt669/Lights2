int[] part1Split;
float [][] part1;
float [][] part2;
float [][] part3;
float [][] part4;
float [][] part5;
float [][] part6;
int x=0;
void setup() {
  String[] text1 = loadStrings("Part1.txt");
  String[] text2 = loadStrings("Part2.txt");
  String[] text3 = loadStrings("Part3.txt");
  String[] text4 = loadStrings("Part4.txt");
  String[] text5 = loadStrings("Part5.txt");
  String[] text6 = loadStrings("Part6.txt");

  part1 = new float[3][text1.length];
  part2 = new float[3][text2.length];
  part3 = new float[3][text3.length];
  part4 = new float[3][text4.length];
  part5 = new float[3][text5.length];
  part6 = new float[3][text6.length];

  for (int i=0; i< (text.length/3); i++) {
    for (int j=0; j<3; j++) {
      part1[j][i] = int(text[x]);
      part1[j][i] = int(text[x]);
      part1[j][i] = int(text[x]);
      part1[j][i] = int(text[x]);
      part1[j][i] = int(text[x]);
      part1[j][i] = int(text[x]);
      x++;
    }
     println("Part1: "+ part1[0][i] + "  " + part1[1][i] + "  " + part1[2][i]);
  }
}


void draw() {
}

