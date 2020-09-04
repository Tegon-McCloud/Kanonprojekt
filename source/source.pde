import java.util.List;
import java.util.ArrayList;

Cannon cannon = new Cannon();

List<CannonBall> cannonBalls = new ArrayList<CannonBall>();
List<BallInteracter> interacters = new ArrayList<BallInteracter>();

long tstart;
long tlast;
long tnow;
float t;
float dt;
boolean start = true;
int score = 0;

void setup() {
  size(1280, 720);
  
  interacters.add(new Gravity(2000.0f));
  interacters.add(new Wind(500.0f));
  interacters.add(new Target());
  tstart = System.nanoTime();
  tlast = tstart;
  
}

void draw() {
  clear();
  background (255, 216, 182);
  text("Din score: "+score, 10,250);
  if (start == true) {
    textSize(24);
    text("Du har 30 sekunder til at skyde før spillet slutter\nDu skyder med kanonen ved at klikke på venstre museknap\nDu kan ændre vinklen på kanonen ved at rykke din mus\nDu starter spillet ved at skyde og du kan starte forfra ved at klikke r", 320, 50);
    if (mousePressed == true ) {
      start = false;
    }
  }
  
  tnow = System.nanoTime();
  dt = (tnow - tlast) / 1e9;
  t = (tnow - tstart) / 1e9;
  tlast = tnow;

  for (BallInteracter bi : interacters) {
    bi.update(t);
    
    for (CannonBall cb : cannonBalls) {
      bi.interact(cb);
    }
    
    bi.display();
  }

  for (CannonBall cb : cannonBalls) {
    cb.update(dt);
    cb.display();
  }
  
  cannon.display();
  
}


void mousePressed(MouseEvent e){
  cannonBalls.add(cannon.shoot(e.getX(), e.getY()));
}

void onHit(){
 
  score++;
  
}
