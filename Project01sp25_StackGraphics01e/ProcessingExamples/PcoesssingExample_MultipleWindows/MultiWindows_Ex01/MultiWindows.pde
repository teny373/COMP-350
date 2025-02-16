// Reference: https://gist.github.com/atduskgreg/666e46c8408e2a33b09a
PWindow win;

public void settings() {
  size(320, 240);
}

void setup() { 
  win = new PWindow();
}

void draw() {
  background(255, 0, 0);
  fill(255);
  rect(10, 10, frameCount, 10);
}

void mousePressed() {
  println("mousePressed in primary window");
}  