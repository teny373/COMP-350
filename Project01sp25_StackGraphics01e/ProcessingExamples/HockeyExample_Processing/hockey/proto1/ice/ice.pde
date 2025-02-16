int done = 0;

void setup ()
{
    size (800, 450);
    
}

void draw ()
{
  int x, y;
  
  if (done>0) return;
  background (181, 199, 220);
  
  stroke (227, 242, 255);
  for (int i=0; i<200; i++)
  {
    x = (int)random (0, width);
    y = (int)random (0, width);
    line (x, 0, y, 450);
  }
  
  for (int i=0; i<200; i++)
  {
    x = (int)random (0, height);
    y = (int)random (0, height);
    line (0, x, 800, y);
  }
  save ("icexx.jpg");
  done = 1;
}
