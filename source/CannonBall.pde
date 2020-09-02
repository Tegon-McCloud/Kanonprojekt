class CannonBall {  
  
  PVector pos, vel, acc;
  
  CannonBall(PVector pos, PVector vel) {
    this.pos = pos.copy();
    this.vel = vel.copy();
    this.acc = new PVector(0.0f, 0.0f);
  }
  
  void applyForce(PVector f) {
    acc.add(f);
  }
  
  void update(float dt) {
    vel.add(PVector.mult(acc, dt));
    pos.add(PVector.mult(vel, dt));
    
    acc.set(0.0f, 0.0f);
  }
  
  void display() {
    stroke(0.0f);
    strokeWeight(3.0f);
    fill(0.3f);
    
    ellipse(pos.x, pos.y, 20.0f, 20.0f);
  }
  
  PVector getPos() {
    return pos.copy();
  }
  
  PVector getVel() {
    return vel.copy();
  }
  
}
