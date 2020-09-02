class Cannon extends BallInteracter {
 
  PVector location;
  
  Cannon() {
    location =  new PVector(0, height+600);
  }
  
   void display() {
    float angle = atan2(mouseY-225*PI, mouseX);

    stroke(0);
    fill(0);
    pushMatrix();
    rectMode(CENTER);
    translate(location.x, location.y);
    rotate(angle);
    rect(0, 0,150,50);
    popMatrix();
  }
  
  void interact(CannonBall b) {
  
  }
  
}
