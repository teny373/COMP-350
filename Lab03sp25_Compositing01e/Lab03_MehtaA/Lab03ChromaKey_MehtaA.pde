PImage daiki, background;
int threshold = 20;

void setup() {
  size(800, 600);
  daiki = loadImage("data/daiki.jpg");
  background = loadImage("data/background.jpg");
  daiki.resize(400, 0);
  background.resize(400, 0);
}

