
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
    stroke(0.0f);
    strokeWeight(1.0f);

    for (int i = 0; i < width/20; i++) {
      for (int j = 0; j < height/20; j++) {
        PVector pos = new PVector(i * 20.0f + 10.0f, j * 20.0f + 10.0f);
        PVector dir = nf.get(pos).normalize().mult(10.0f);
        line(pos.x, pos.y, pos.x + dir.x, pos.y + dir.y);
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

class Particle {

  PVector pos, vel, acc;

  Particle() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(0.0f, 0.0f);
    acc = new PVector(0.0f, 0.0f);
  }

  void update(float dt) {

    vel.add(PVector.mult(acc, dt));
    pos.add(PVector.mult(vel, dt));
    acc.set(0.0f, 0.0f);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void follow(VectorField vf) {
    PVector relVel = PVector.sub(vf.get(pos), vel);
    float relVelMag2 = relVel.dot(relVel);
    relVel.normalize();
    relVel.mult(relVelMag2);
    relVel.mult(0.001f);

    applyForce(relVel);
  }

  void display() {
    int x = (int)pos.x;
    int y = (int)pos.y;

    if (x < 0 || x >= width || y < 0 || y >= height) return;

    color col = pixels[x + y * width];
    int a = (col & 0xff000000) >> 24;
    int r = (col & 0x00ff0000) >> 16;
    int g = (col & 0x0000ff00) >> 8;
    int b = (col & 0x000000ff) >> 0;

    b += 5;
    r += 3;
    if (b > 255) {
      b = 255;
      r = 153;
    }

    col = (a << 24) | (r << 16) | (g << 8) | (b << 0);

    pixels[x + y * width] = col;
  }

  void edgeLoop() {
    if (pos.x < 0 || pos.x >= width || pos.y < 0 || pos.y >= height) {
      pos = new PVector(random(width), random(height));
      vel = new PVector(0.0f, 0.0f);
      acc = new PVector(0.0f, 0.0f);
    };
  }
}
