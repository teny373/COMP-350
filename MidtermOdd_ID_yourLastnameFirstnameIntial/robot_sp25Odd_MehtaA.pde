// Your name: Arnav Mehta
// UFV ID#: 300196365

int headWidth = 40; 
int headHeight = 30; 
int headX = 20;
int headY = 0;
int eyeWidth = headWidth/2; 
int eyeHeight = headHeight/2;
int bodyWidth = 50; 
int bodyHeight = 70; 
int armWidth = 10; 
int armHeight = 50;
int legWidth = 10; 
int legHeight = 50;

void setup(){
size(300, 300);
smooth();
}

void draw(){

  pushMatrix(); 
  translate(50, 50);
  drawRobot(45, 0);
  popMatrix();

  for (int i = 0; i < 2; i++){
    pushMatrix(); 
    translate(200, 100+(i*100));
    rotate(radians(-45*(i+1)));
    scale(0.5);
    drawRobot(90, 90+90*(i));
    popMatrix();
  }

}

void drawRobot(int angleL, int angleR){
  rect(headX, headY, headWidth, headHeight); 

  beginShape();
  vertex(headX - 5, headHeight+ 5);
  vertex(headX + headWidth + 5, headHeight+ 5); 
  vertex(headX + headWidth/2, headHeight+ bodyHeight+ 5); 
  endShape(CLOSE);

  drawRightArm(angleR); 
  drawLeftArm(angleL);
  rect(headX, headHeight+ bodyHeight, legWidth, legHeight); 
  rect(headX + headWidth - legWidth, headHeight+ bodyHeight, legWidth, legHeight);
  fill(255);
  ellipse(headWidth/2, headHeight/2, eyeWidth, eyeWidth);  
}

void drawLeftArm(int angle){
  pushMatrix();
  translate(headX + headWidth, headHeight + 10); 
  rotate(radians(-angle));
  rect(0, 0, armWidth, armHeight); 
  popMatrix();
}

void drawRightArm(int angle){
  pushMatrix();
  translate(headWidth - headX, headHeight + 10); 
  rotate(radians(angle));
  rect(0, 0, armWidth, armHeight); 
  popMatrix();
}
