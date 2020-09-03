class Gravity extends BallInteracter {
  
  float strength;
  
  Gravity(float strength) {
    this.strength = strength;
  }
  
  void interact(CannonBall cb) {
    cb.applyForce(new PVector(0.0f, strength));
  }
  
  void display() {};
  
}
