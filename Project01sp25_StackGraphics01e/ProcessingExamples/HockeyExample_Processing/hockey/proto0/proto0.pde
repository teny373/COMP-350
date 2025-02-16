// Hockey Pong - Iteration 1

PImage rink;
int puckX, puckY;
int dx=1, dy = 1;

void setup ()
{
  size (800, 600);
  
  rink = loadImage ("rink.bmp");
  puckX = 100; puckY = 100;
}

void draw ()
{
  background(200);
  
  image (rink, 0,0);  
// Puck control
  puck (puckX, puckY);
  puckX += dx; puckY += dy;
  if (puckX<3 || puckX>width) dx = -dx;
  if (puckY<3 || puckY>443) dy = -dy; 
  
// screen Text 
  text ("Hockey Pong Proto 0.0. Background, moving puck.", 50, 500);
  text ("X: "+puckX, 60, 530);  text ("Y: "+puckY, 100, 530);
  text ("Dx: "+dx, 60, 550);    text ("Dy: "+dy, 100, 550);
}

void puck (int x, int y)
{
  fill(0);
  ellipse (x, y, 10, 10);
}


