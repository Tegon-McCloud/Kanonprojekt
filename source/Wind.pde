
class Wind extends BallInteracter {

  NoiseFlow nf;

  Wind(float strength) {
    nf = new NoiseFlow(0.004f, strength);
  }

  @Override
  void update(float t) {
    nf.setTime(t);
  }

  @Override
  void interact(CannonBall cb) {
    PVector relVel = PVector.sub(nf.get(cb.getPos()), cb.getVel());
    float relVelMag2 = relVel.dot(relVel);
    relVel.normalize();
    relVel.mult(relVelMag2);
    relVel.mult(0.00095f);

    cb.applyForce(relVel);
  }

  @Override
  void display() {
    stroke(0f, 0f, 200.0f);
    strokeWeight(1.0f);
    fill(0.0f, 0.0f, 0.0f, 0.0f);

    for (int i = 0; i < width/80; i++) {
      for (int j = 0; j < height/80; j++) {
        PVector pos = new PVector(i * 80.0f +40.0f, j * 80.0f + 40.0f);
        PVector dir = nf.get(pos).normalize().mult(40.0f);
        line(pos.x, pos.y, pos.x + dir.x, pos.y + dir.y);
        ellipse(pos.x, pos.y, 20.0f, 20.0f);
      }
    }
  }
}

abstract class VectorField {
  abstract PVector get(PVector pos);
}

class NoiseFlow extends VectorField {

  float inc;
  float strength;
  float t;

  NoiseFlow(float inc, float strength) {
    this.inc = inc;
    this.strength = strength;
    t = 0;
  }

  void setTime(float t) {
    this.t = t;
  }

  float getAngle(PVector pos) {
    return noise(pos.x * inc, pos.y * inc, t * 0.5f) * TWO_PI;
  }

  @Override
    PVector get(PVector pos) {
    float angle = getAngle(pos);
    return new PVector(cos(angle) * strength, sin(angle) * strength);
  }
}
