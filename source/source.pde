import java.util.List;
import java.util.ArrayList;

Cannon cannon = new Cannon();

List<CannonBall> cannonBalls = new ArrayList<CannonBall>();
List<BallInteracter> interacters = new ArrayList<BallInteracter>();

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

  t1 = System.nanoTime();
  dt = (t1 - t0) / 1e9;

  for (BallInteracter bi : interacters) {
    for (CannonBall cb : cannonBalls) {
      bi.interact(cb);
    }
  }

  for (CannonBall cb : cannonBalls) {
    cb.update(dt);
    cb.display();
  }
  
  cannon.display();
  
  t0 = System.nanoTime();
}

void mouseMoved(MouseEvent e) {
  cannon.aim(e.getX(), e.getY());
}

void mousePressed(MouseEvent e){
  cannonBalls.add(cannon.shoot());
}
