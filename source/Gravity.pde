class Gravity extends BallInteracter {
  
  float strength;
  
  Gravity(float strength) {
    this.strength = strength;
  }
  
  @Override
  void update(float t) {}
  
  @Override
  void interact(CannonBall cb) {
    cb.applyForce(new PVector(0.0f, strength));
  }
  
  @Override
  void display() {};
  
}
