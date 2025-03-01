PImage source, answerImage;

void setup() {
  size(300, 600);
  source = loadImage("SuperMarioSmall.png");
  answerImage = createImage(source.width, source.height, RGB);
}

void draw() {
  image(source, 0, 0);
  image(answerImage, 0, 300);
  diagonalFlip();
  answerImage.updatePixels();
}

// -------------------------------------
// Flips the source image diagonally 
// (both horizontally and vertically)
// -------------------------------------
void diagonalFlip() {
  source.loadPixels();
  answerImage.loadPixels();
  
  for (int x = 0; x < source.width; x++) {
    for (int y = 0; y < source.height; y++) {
      color c = source.get(x, y);

      int newX = source.width - 1 - x;
      int newY = source.height - 1 - y;

      answerImage.set(newX, newY, c);
    }
  }
}
