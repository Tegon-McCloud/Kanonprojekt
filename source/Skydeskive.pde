class Target extends BallInteracter {

  PVector pos;
  float radius;
  Target(){
    pos=new PVector();
    radius = 60;
    reposition();
    
  }

  void reposition() {
  pos.x=random(width/2,width-radius-50);
  pos.y=(height-100);
  }


  @Override
    void update(float t) {
  }

  @Override
    void interact(CannonBall cb) {
    PVector bPos = cb.getPos();
    
      if (bPos.x>pos.x-radius && 
      bPos.x<pos.x+radius &&
      bPos.y>pos.y-20 &&
      bPos.y<pos.y+20) {
      reposition();
      onHit();
      removeBalls.add(cb);
    }
  }

  @Override
    void display() {
    strokeWeight(2);
    
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, 120, 50);
    noStroke();
    fill(255, 255, 255);
    ellipse(pos.x, pos.y, 90, 40);
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, 70, 30);
    fill(255, 255, 255);
    ellipse(pos.x, pos.y, 50, 20);
    
    
  }
}
