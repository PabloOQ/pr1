import processing.sound.*;
import gifAnimation.*;

Ball ball;
Paddle rPad;
Paddle lPad;
int rScore;
int lScore;
float margin;
boolean right;

float step = 2;

SoundFile goalSound;
GifMaker winGif;
int gifCount;
boolean recording;
boolean stopRecording;

void setup(){
  goalSound = new SoundFile(this, "Casio-MT-600-Synth-Bells-C3.wav");
  gifCount = 0;
  recording = false;
  stopRecording = false;
  
  margin = 50;
  ball = new Ball();
  rPad = new Paddle(margin, height / 2);
  lPad = new Paddle(width - margin, height / 2);
  rScore = 0;
  lScore = 0;
  size(900,400);
  resetBall();
  frameRate(200);
}

void draw(){
  gifMethod();
  logic();
  show();
  finishRecord();
}

void gifMethod(){
  if (recording && gifCount % 10 == 0){
    winGif.addFrame();
  }
  gifCount++;
}

void logic(){
  movePads();
  checkBounce();
  checkGoal();
  ball.move();
  record();
}

void record(){
  if ((rScore == 9 || lScore == 9) && !recording){
        winGif = new GifMaker(this, "winner.gif");
        winGif.setRepeat(0);
        gifCount = 0;
        recording = true;
        stopRecording = false;
  }
}

void movePads(){
  if (keyPressed){
    switch(key){
      case 'W':
      case 'w':
        rPad.setY(rPad.getY()-step);
        checkIfPadInside(rPad);
        break;
      case 'S':
      case 's':
        rPad.setY(rPad.getY()+step);
        checkIfPadInside(rPad);
        break;
      case 'O':
      case 'o':
        lPad.setY(lPad.getY()-step);
        checkIfPadInside(lPad);
        break;
      case 'L':
      case 'l':
        lPad.setY(lPad.getY()+step);
        checkIfPadInside(lPad);
        break;
      default:
        break;
    }
  }
}

void checkIfPadInside(Paddle pad){
  if (pad.getY() < 0){
    pad.setY(0);
  }else if(pad.getY() > height){
    pad.setY(height);
  }
}

void checkGoal(){
  if (ball.getX() <= 0){
    rScore++;
    resetBallSpeed(-1);
    goalSound.play();
    if(rScore == 10){
      stopRecording = true;
    }else if (recording){
      winGif.finish();
      recording = false;
      record();
    }
  }
  if (ball.getX() >= width){
    lScore++;
    resetBallSpeed(1);
    goalSound.play();
    if(lScore == 10){
      stopRecording = true;
    }else if (recording){
      winGif.finish();
      recording = false;
      record();
    }
  }
}

void finishRecord(){
  if (stopRecording){
    for (int i = 0; i < 10; i++){
      winGif.addFrame();
    }
    winGif.finish();
    recording = false;
    goalSound.stop();
    goalSound = new SoundFile(this, "mundial-ronaldinho-soccer-64.wav");
    goalSound.play();
    noLoop();
  }
}

int randomSign(){
  if(random(2) < 1) {
    return -1;
  } else {
    return 1;
  }
}

void resetBall(){
  resetBallSpeed(randomSign());
}

void resetBallSpeed(int side){
  ball.setSpeed(random(1,5)*side,random(1,3)*randomSign()); //Can get stuck if goes vertical 
  ball.setX(width / 2);
  ball.setY(height / 2);  
}

void checkBounce(){
  float x = ball.getX();
  float y = ball.getY();
  float r = ball.getD() / 2;
  
  //Check bounce on y axis
  if (y - r <= 0 || height <= y + r){
    ball.setSpeed(ball.getVX(), -ball.getVY());
  }
  
  padBounce(lPad);
  padBounce(rPad);
}

void padBounce(Paddle pad){
  float bx = ball.getX();
  float by = ball.getY();
  float br = ball.getD() / 2;
  float px = pad.getX();
  float py = pad.getY();
  float pw = pad.getWidth();
  float ph = pad.getHeight();
  float dir;
  if (pad.getX() < width / 2){
    dir = 1;
  }else{
    dir = -1;
  }
  
  if (pad.isMoving()){
    
  }else{
    if (bx - br <= px + pw / 2 &&    //X axis left
        bx + br >= px - pw / 2 &&    //X axis right
        by - br <= py + ph / 2 &&    //Y axis top
        by + br >= py - ph / 2){     //Y axis bottom
        //Hitboxes are hitting
        if(px + pw / 2 <= bx){
          ball.setSpeed(abs(ball.getVX()) * dir + random(-0.2,0.2), ball.getVY() + random(-0.2,0.2));
        }else if(px - pw / 2 >= bx){
          ball.setSpeed(abs(ball.getVX()) * dir + random(-0.2,0.2), ball.getVY() + random(-0.2,0.2));
        }
    }
  }
}

void show(){
  background(255);
  showSeparator();
  showScore();
  ball.show();
  rPad.show();
  lPad.show();
}

void showSeparator(){
  stroke(30);
  float s = 14; //TODO: fix
  for (float i = 0; i < height; i+=14){
    line(width/2, i, width/2, i+7);
  }
}

void showScore(){
  textSize(50);
  fill(0);
  //Not centered
  text(lScore, width / 2 - 100, 100);
  text(rScore, width / 2 + 100, 100);
}
