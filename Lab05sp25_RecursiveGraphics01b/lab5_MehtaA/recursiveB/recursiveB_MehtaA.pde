void setup() {
  size(800, 800);
  background(255);
  smooth();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  float size = map(mouseX, 0, width, 100, 400);
  int levels = int(map(mouseY, 0, height, 2, 7));
  recursiveTriangle(size, levels);
}

void recursiveTriangle(float size, int level) {
  if (level <= 0) return;

  fill(255 - level * 30, 150 + level * 20, 200, 180);
  noStroke();
  
  beginShape();
  vertex(-size/2, size/2);  
  vertex(size/2, size/2);   
  vertex(0, -size/2);
  endShape(CLOSE);
  
  if (level > 1) {
    float newSize = size * 0.5;
    
    pushMatrix();
    translate(0, -size/2);
    recursiveTriangle(newSize, level - 1);
    popMatrix();
    
    pushMatrix();
    translate(-size/2, size/2);
    recursiveTriangle(newSize, level - 1);
    popMatrix();
    
    pushMatrix();
    translate(size/2, size/2);
    recursiveTriangle(newSize, level - 1);
    popMatrix();
  }
}
