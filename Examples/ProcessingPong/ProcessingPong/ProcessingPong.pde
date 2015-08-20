
//NOW WORKING ON A WINDOWS COMPUTER

int canX = 600;
int canY = 400;
int check;
int restart;

float ranX = abs(random(5, 9));
float ranY = abs(random(2, 5));

PaddleLeft LeftPad;
PaddleRight RightPad;
Ball ball;

void setup() {
  size(canX, canY);
  LeftPad = new PaddleLeft(canX*0.1, canY/2);
  RightPad = new PaddleRight(canX*0.9, canY/2);
  ball = new Ball(canX/2, canY/2, 20, ranX, ranY);
}

void draw() {

//  if (key == 'r') {
//    ball.reset();
//  } else {

    if (restart == 0) {
      background(-1);
      LeftPad.drawPad();
      RightPad.drawPad();
      ball.drawBall();
      ball.moveBall();
      Fail();
    } else if (restart == 1) {
      if (key == '\n') {
        ranX = abs(random(5, 9));
        ranY = abs(random(2, 5));
        ball = new Ball(canX/2, canY/2, 20, ranX, ranY);
        restart = 0;
      } else {
      }
    }
  //}
}

void Fail() {
  boolean FAIL = ball.getFail();

  if (FAIL == true) {
    print("\n FAIL BITCH!");
    ball.reset();
    LeftPad.setY(canY/2);
    restart = 1;
  } else {
  }
}

void keyPressed() {
  check = 1;
}

void keyReleased() {
  check = 0;
}

