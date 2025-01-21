PImage source, imgFlipY, imgFlipX, imgDiagonal, imgComposite, imgScale;
float angle = 0;
float[][] transformMatrix = new float[3][3];
PImage interactiveImg;
String transformation = "none"; // none, rotate, -rotate, flipX, flipY, scaleUp, scaleDown
float interactiveAngle = 0;
float scaleFactor = 1.0;

void setup() {
  size(1000, 800);
  source = loadImage("nooo.gif");
  source.resize(200, 200);
  
  imgFlipY = createImage(source.width, source.height, RGB);
  imgFlipX = createImage(source.width, source.height, RGB);
  imgDiagonal = createImage(source.width, source.height, RGB);
  imgComposite = createImage(source.width, source.height, RGB);
  imgScale = createImage(source.width, source.height, RGB);
  
  interactiveImg = source.copy();
}

void draw() {
  background(255);
  
  flipVertical(source, imgFlipY);
  flipHorizontal(source, imgFlipX);
  flipDiagonal(source, imgDiagonal);
  angle += 0.02;
  compositeTransform(source, imgComposite, angle);
  scaleImage(source, imgScale, 0.5);

  image(source, 50, 50);
  image(imgFlipY, 300, 50);
  image(imgFlipX, 50, 300);
  image(imgDiagonal, 300, 300);
  image(imgScale, 550, 300);
  image(imgComposite, 550, 50);

  image(interactiveImg, 300, height - 250);
   
  drawLegend();
}

void flipVertical(PImage src, PImage dest) {
  dest.loadPixels();
  for (int y = 0; y < src.height; y++) {
    for (int x = 0; x < src.width; x++) {
      int sourcePos = x + y * src.width;
      int targetPos = x + (src.height - 1 - y) * src.width;
      dest.pixels[targetPos] = src.pixels[sourcePos];
    }
  }
  dest.updatePixels();
}

void flipHorizontal(PImage src, PImage dest) {
  dest.loadPixels();
  for (int y = 0; y < src.height; y++) {
    for (int x = 0; x < src.width; x++) {
      int sourcePos = x + y * src.width;
      int targetPos = (src.width - 1 - x) + y * src.width;
      dest.pixels[targetPos] = src.pixels[sourcePos];
    }
  }
  dest.updatePixels();
}

void flipDiagonal(PImage src, PImage dest) {
  dest.loadPixels();
  for (int y = 0; y < src.height; y++) {
    for (int x = 0; x < src.width; x++) {
      int sourcePos = x + y * src.width;
      int targetPos = y + x * src.width;
      dest.pixels[targetPos] = src.pixels[sourcePos];
    }
  }
  dest.updatePixels();
}

void compositeTransform(PImage src, PImage dest, float nextAngle) {
  dest.loadPixels();
  float centerX = src.width / 2;
  float centerY = src.height / 2;
  
  for (int y = 0; y < src.height; y++) {
    for (int x = 0; x < src.width; x++) {
      float sx = (x - centerX);
      float sy = (y - centerY);
      
      float ry = sx * sin(nextAngle) + sy * cos(nextAngle);
      float rx = sx * cos(nextAngle) - sy * sin(nextAngle);
      
      float tx = rx + centerX;
      float ty = ry + centerY;
      
      if (tx >= 0 && tx < src.width && ty >= 0 && ty < src.height) {
        int sourcePos = x + y * src.width;
        int targetPos = int(tx) + int(ty) * src.width;
        if (targetPos >= 0 && targetPos < dest.pixels.length) {
          dest.pixels[targetPos] = src.pixels[sourcePos];
        }
      }
    }
  }
  dest.updatePixels();
}

void scaleImage(PImage src, PImage dest, float scale) {
  dest.loadPixels();
  float centerX = src.width / 2;
  float centerY = src.height / 2;
  
  for (int y = 0; y < src.height; y++) {
    for (int x = 0; x < src.width; x++) {
      float sx = (x - centerX) * scale + centerX;
      float sy = (y - centerY) * scale + centerY;
      
      if (sx >= 0 && sx < src.width && sy >= 0 && sy < src.height) {
        int sourcePos = x + y * src.width;
        int targetPos = int(sx) + int(sy) * src.width;
        if (targetPos >= 0 && targetPos < dest.pixels.length) {
          dest.pixels[targetPos] = src.pixels[sourcePos];
        }
      }
    }
  }
  dest.updatePixels();
}

void drawLegend() {
  fill(0);
  textAlign(LEFT);
  textSize(12);
  int y = height - 200;
  int x = 50;
  text("Interactive Controls:", x, y);
  text("r/R - Rotate clockwise/counter-clockwise", x, y += 20);
  text("x - Flip horizontally", x, y += 20);
  text("y - Flip vertically", x, y += 20);
  text("s/S - Scale up/down", x, y += 20);
  text("c - Reset transformation", x, y += 20);

  text("Source", 50, 40);
  text("Vertical Flip", 300, 40);
  text("Horizontal Flip", 50, 290);
  text("Diagonal Flip", 300, 290);
  text("Composite", 550, 40);
  text("Scale", 550, 290);
  
}

void keyPressed() {
  PImage tempBuffer = createImage(interactiveImg.width, interactiveImg.height, RGB);
  switch (key) {
    case 'x':
      transformation = "flipX";
      flipHorizontal(interactiveImg, tempBuffer);
      interactiveImg.copy(tempBuffer, 0, 0, tempBuffer.width, tempBuffer.height, 0, 0, tempBuffer.width, tempBuffer.height);
      break;
    case 'y':
      transformation = "flipY";
      flipVertical(interactiveImg, tempBuffer);
      interactiveImg.copy(tempBuffer, 0, 0, tempBuffer.width, tempBuffer.height, 0, 0, tempBuffer.width, tempBuffer.height);
      break;
    case 'r':
      transformation = "rotate";
      interactiveAngle += PI / 4;
      compositeTransform(source, interactiveImg, interactiveAngle);
      break;
    case 'R':
      transformation = "-rotate";
      interactiveAngle -= PI / 4;
      compositeTransform(source, interactiveImg, interactiveAngle);
      break;
    case 's':
      transformation = "scaleUp";
      scaleFactor *= 1.2;
      scaleImage(source, interactiveImg, scaleFactor);
      break;
    case 'S':
      transformation = "scaleDown";
      scaleFactor /= 1.2;
      scaleImage(source, interactiveImg, scaleFactor);
      break;
    case 'c':
      transformation = "none";
      interactiveImg = source.copy();
      interactiveAngle = 0;
      scaleFactor = 1.0;
      break;
  }
}
