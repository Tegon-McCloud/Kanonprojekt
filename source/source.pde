CannonBall b = new CannonBall(new PVector(300, 300), new PVector(10, -1000));

long t0;
long t1;
float dt;
boolean start = true;

void setup() {
  size(1280, 720);
  
  t0 = System.nanoTime();
}

void draw() {
    clear();
  background (255, 216, 182);
  if (start == true) {
    textSize(24);
    text("Du har 30 sekunder til at skyde før spillet slutter\nDu skyder med kanonen ved at klikke på venstre museknap\nDu kan ændre vinklen på kanonen ved at rykke din mus\nDu starter spillet ved at skyde og du kan starte forfra ved at klikke r", 320, 50);
    if (mousePressed == true ) {
      start = false;
    }
  }

  b.draw();
  
  t1 = System.nanoTime();
  
  dt = (t1 - t0) / 1e9;
  
  b.applyForce(new PVector(0.0f, 300.0f));
  b.update(dt);
  
  println(dt);
  
  t0 = System.nanoTime();
  
  
}
