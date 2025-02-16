void setup() {
  size(800, 800);
  background(255);
  smooth();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  float petalSize = map(mouseX, 0, width, 50, 300);
  int petalCount = int(map(mouseY, 0, height, 3, 8));
  drawLotus(petalSize, petalCount);
}

void drawLotus(float petalSize, int petalCount) {
  if (petalSize < 10) return;

  pushMatrix();
  noStroke();
  fill(255, 150, 200, 180);
  beginShape();
  vertex(0, 0);
  bezierVertex(petalSize * 0.3, -petalSize * 0.8, petalSize * 0.7, -petalSize * 0.8, 0, -petalSize);
  bezierVertex(-petalSize * 0.7, -petalSize * 0.8, -petalSize * 0.3, -petalSize * 0.8, 0, 0);
  endShape(CLOSE);
  popMatrix();
  
  for (int i = 0; i < petalCount; i++) {
    pushMatrix();
    float angle = TWO_PI / petalCount * i;
    rotate(angle);
    translate(0, -petalSize);
    drawLotus(petalSize * 0.6, petalCount);
    popMatrix();
  }
}

