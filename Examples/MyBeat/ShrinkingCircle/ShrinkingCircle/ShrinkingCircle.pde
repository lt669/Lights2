int i;
int check = 0;
void setup(){
 size(600, 400);
 background(-1); 
 noLoop();
}

void draw(){

   background(-1);
      //int col = 255 * 50/i;
      fill(155);
      ellipse(mouseX, mouseY, i, i);
      i--;
  
 }
 
 void drawing(){
   
    if (check == 1){
    i = 50;
    do{
      redraw();
    }while (check == 1 && i>0);
    check = 0;
  } 
   
 }
 
 void mouseClicked(){
  check = 1;
  drawing();
  
 }
  
//void pointless{
//   background(255);
//   fill(0);
//   ellipse(300, 200, i, i);
//   //delay(10);
//   if (i <= 0){
//    i++;
//    check = 1;
//  }
//   else if (i >= 400){
//    i--;
//    check = 0;
//   }
//   else if (check == 0){
//     i--;
//   }
//   else{
//     i++;
//   }
//}
  
    
    
