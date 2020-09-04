import java.util.List;
import java.util.ArrayList;

Cannon cannon = new Cannon();

List<CannonBall> cannonBalls = new ArrayList<CannonBall>();
List<CannonBall> removeBalls = new ArrayList<CannonBall>();
List<BallInteracter> interacters = new ArrayList<BallInteracter>();

long tstart;
long tlast;
long tnow;
float t;
float dt;
boolean start = true;
int score = 0;
float gameTime = 30;
float tGameStart;

PImage logo;
PImage bg;

void setup() {
  size(1280, 720);

  imageMode(CENTER);
  logo = loadImage("GoCannonGo.png");
  bg = loadImage("Outlands.png");

  interacters.add(new Gravity(2000.0f));
  interacters.add(new Wind(500.0f));
  interacters.add(new Target());
  tstart = System.nanoTime();
  tlast = tstart;
}

void draw() {
  clear();
  background (255, 216, 182);
  image(bg, width/2, height/2);

  textSize(22);
  stroke(0.0f);
  fill(0.0f);
  text("Din score: "+score, width/2, 32);

  if (start) {

    image(logo, 250, 150, 450, 250);
    text("Du har 30 sekunder til at skyde før spillet slutter\nDu skyder med kanonen ved at klikke på venstre museknap\nDu kan ændre vinklen på kanonen ved at rykke din mus\nDu starter spillet ved at skyde og du kan starte forfra ved at klikke r", 500, 70);
  } else {
    if (tGameStart+30<t) {
      gameEnded();

      if (start == true) {
        if (mousePressed == true ) {
          start = false;
        }
      } else {
        textSize(55);
        text(score, width/2, 50);
      }
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
    if (start == false) {
      bi.display();
    }
  }

  for (CannonBall cb : cannonBalls) {
    cb.update(dt);
    cb.display();
  }

  cannon.display();

  for (CannonBall cb : removeBalls) {
    cannonBalls.remove(cb);
  }
}


void mousePressed(MouseEvent e) {

  if (start) {
    gameStart();
  }
  cannonBalls.add(cannon.shoot(e.getX(), e.getY()));
}

void onHit() {

  score++;
}

void gameStart() {
  start = false;
  tGameStart = t;
  score = 0;
}

void gameEnded() {
  start = true;
  cannonBalls.clear();
  removeBalls.clear();
}
