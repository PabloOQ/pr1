class Ball{
  float d = 20;
  float x = width/2;
  float y = height/2;
  float vx = 0;
  float vy = 0;

  Ball(){
  
  }
  
  void move(){
    x += vx;
    y += vy;
  }
  
  void show(){
    fill(50);
    circle(x,y,d);
  }
  
  void setX(float x){
    this.x = x;
  }

  void setY(float y){
    this.y = y;
  }  
  
  void setSpeed(float vx, float vy){
    this.vx = vx;
    this.vy = vy;
  }
  
  float getVX(){
    return vx;
  }

  float getVY(){
    return vy;
  }
  
  float getX(){
    return x;
  }

  float getY(){
    return y;
  }
  
  float getD(){
    return d;
  }
}
