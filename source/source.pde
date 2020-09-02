CannonBall b = new CannonBall(new PVector(300, 300), new PVector(10, -1000));

long t0;
long t1;
float dt;

void setup() {
  size(1280, 720);
  
  t0 = System.nanoTime();
}

void draw() {
  b.draw();
  
  t1 = System.nanoTime();
  
  dt = (t1 - t0) / 1e9;
  
  b.applyForce(new PVector(0.0f, 300.0f));
  b.update(dt);
  
  println(dt);
  
  t0 = System.nanoTime();
}
