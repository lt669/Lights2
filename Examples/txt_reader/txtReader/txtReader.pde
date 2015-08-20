String[] text;
String[] part1;
String[] part2;
String[] part3;
String[] part4;
String[] part5;
String[] part6;

void setup() {
  //Load .txt file
  text = loadStrings("architexture2_testdatafile.txt");  

  //Seperate the lines using )
  for (int i=0; i<=text.length; i++) {
    part1 = splitTokens(text[13], "NEWPART() ");
    part2 = splitTokens(text[17], "NEWPART()");
    part3 = splitTokens(text[22], "NEWPART()");
    part4 = splitTokens(text[26], "NEWPART()");
    part5 = splitTokens(text[30], "NEWPART()");
    part6 = splitTokens(text[34], "NEWPART()");
  }

  //Save to .txt files
  saveStrings("Part1.txt", part1);
  saveStrings("Part2.txt", part2);
  saveStrings("Part3.txt", part3);
  saveStrings("Part4.txt", part4);
  saveStrings("Part5.txt", part5);
  saveStrings("Part6.txt", part6);

  //Split
  
  
}



void draw() {
}

