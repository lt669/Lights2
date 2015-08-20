Table table;
int posX;
int posY;
int size;

void setup(){
  
  size(200,200);
  
  table = loadTable("File.csv", "header");
  
  println(table.getRowCount()+ "rows in the file");
  
  for(TableRow row : table.rows()){
    posX = row.getInt("positionX");
    posY = row.getInt("positionY");
    size = row.getInt("size");
   
   println("posX:" + posX + ", posY:" + posY + ", size:" + size);
   drawEllipse(posX,posY,size);
  }  
}

void drawEllipse(int posX, int posY, int size){
 fill(255,0,0);
 ellipse(posX, posY, size, size); 
}
