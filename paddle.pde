class Paddle{
  float x;
  float y;
  float w = 4;
  float h = 60;
  float step = 1;

  Paddle(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void show(){
    fill(200);
    rect(x-w/2,y-h/2,w,h);
  }

  void setY(float y){
   this.y=y;
  }

  boolean isMoving(){
   return false; 
  }

  float getWidth(){
    return w;
  }

  float getHeight(){
    return h;
  }

  float getX(){
    return x;
  }

  float getY(){
    return y;
  }
}
