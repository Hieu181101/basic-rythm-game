import java.awt.*;
final int x =800;
final int y =600;
//int z =200;
//int v =277;
//float h = sqrt(sq(x-z)+sq(y-v));
final int r =60;
int  x1, y1;
int  x2, y2;

final int b1 = 10;
final int b2 = 5;
int scoreA=0, scoreB=0;

void setup() {
  size (800, 600);
  background(0);
  init();
  Refresh();
}

int xb1, xb2, yb1, yb2;
boolean f1=false, f2=false, gameover=false;
void drawABullet() {
  if (f1==false) return;
  fill(0, 0, 255);
  ellipse(xb1, yb1, b1, b2);
}
void drawBBullet() {
  if (f2==false) return;
  fill(0, 255, 0);
  ellipse(xb2, yb2, b1, b2);
}
void drawACircle() {

  fill(0, 0, 255);
  ellipse(x1, y1, r, r);
}
void drawBCircle() {

  fill(0, 255, 0);
  ellipse(x2, y2, r, r);
}
void init() {
  y1= y/2;
  x1=r;
  y2= y/2;
  x2=x-r;
  fill(255, 255, 255);
  textSize(30);
  scoreA=0;
  scoreB=0;
  f1=false;
  f2=false;
  gameover=false;
}

void Refresh() {
  clear();
  drawACircle();
  drawABullet();
  text(""+scoreA, 300, 80);
  drawBCircle();
  drawBBullet();
  text(""+scoreB, 500, 80);

  if (gameover) {
    fill(255, 255, 255);
    if (scoreA>=5) {
      text("Blue win", 300, 250);
    }
    if (scoreB>=5) {
      text("Green win", 300, 250);
    }

    text("Press 'c' to play again.", 300, 350);
  }
}
void GameOver() {
  gameover=true;


  Toolkit.getDefaultToolkit().beep();
}

void fireBulletA()
{
  while (xb1<x&&scoreA<5) {
    xb1+=5;
    if (check(x2, y2, r, xb1, yb1, b1)) {
      scoreA+=1;
      break;
    }
    delay(3);
  }
  f1=false;
}

void fireBulletB()
{
  while (xb2>0&&scoreB<5) {
    xb2-=5;
    if (check(x1, y1, r, xb2, yb2, b2)) {
      scoreB+=1;
      break;
    }
    delay(3);
  }
  f2=false;
}
void draw() {

  for ( int i = 0; i < keys_to_check.length; i++) {
    if (keys_down[i] == true)
    {
      switch (keys_to_check[i]) {
      case 'W':
      case 'w':
        y1-=5;
        if (y1<r) y1=r;
        break;
      case 'S':
      case 's':
        y1+=5;
        if (y1>y-r) y1=y-r;
        break;
      case 'F':
      case 'f':
        if (f1==false) {
          f1=true;
          xb1=r;
          yb1=y1;

          thread("fireBulletA");
        }
        break;
      case 'L':
      case 'l':
        if (f2==false) {
          f2=true;
          xb2=x-r;
          yb2=y2;

          thread("fireBulletB");
        }
        break;
      case 'C':
      case 'c':
        if (gameover==true) {
          gameover=false;
          init();
        }
        break;
      case DOWN:
        y2+=5;
        if (y2>y-r) y2=y-r;
        break;
      case UP:
        y2-=5;
        if (y2<r) y2=r;
        break;
      }
    }
    if (gameover) break;
  }

  if (scoreA >=5 || scoreB>=5) {
    GameOver();
  }
  background(0);
  Refresh();
}

char[] keys_to_check = {'C', 'c', 'W', 'w', 'S', 's', 'F', 'f', UP, DOWN, 'L', 'l'};
boolean[] keys_down = new boolean[keys_to_check.length];

void keyPressed() {
  copeWithKeys(true); // TRUE MEANS KEY PRESSED
}

void keyReleased() {
  copeWithKeys(false); // FALSE MEANS KEY NOT PRESSED
}

void copeWithKeys(boolean state) {
  for ( int i = 0; i < keys_to_check.length; i++) {
    if ( keys_to_check[i] == keyCode ) { 
      keys_down[i] = state;
    }
  }
}

boolean check(float x1, float  y1, float r1, float x2, float y2, float r2) {
  return dist(x1, y1, x2, y2) < (r1+r2)/2;
}
