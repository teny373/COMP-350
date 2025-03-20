PShape character;
float a = 0;


void setup() {
  size(800, 600, P3D);
  smooth(8);
  character = loadShape("agent343a.obj");
  character.scale(30);
  character.rotateX(radians(180));
  character.rotateY(radians(115));
  character.translate(-100, 0, 250);
}


void draw() {
  background(color(136, 176, 255));
  camera(-50, min(350, mouseY), (height/2) / tan(PI/6) -200, width/2, height/2, 0, 0, 1, 0);
  translate(width/2, height/2 + 100, -100);  

  float cameraY = height/2.0;
  float fov = mouseX/float(width) * PI/2;
  float cameraZ = cameraY / tan(fov / 2.0);
  float aspect = float(width)/float(height);
  if (mousePressed) {
    aspect = aspect / 2.0;
  }
  perspective(fov, aspect, cameraZ/10.0, cameraZ*10.0); 
  
  directionalLight(153, 153, 153, .5, 2, -1);

  ambient(255,255,0);
 

  // Draw grass plane
  pushMatrix();
  rotateX(radians(90));
  textureMode(IMAGE);
  textureWrap(REPEAT);
  PImage grass = loadImage("grass.png");
  grass.resize(0, 190);
  beginShape();
  texture(grass);
  vertex(-1500, -1500, 1500, -1500);
  vertex(1500, -1500, 1500, 1500);
  vertex(1500, 1500, -1500, 1500);
  vertex(-1500, 1500, -1500, -1500);
  endShape();
  popMatrix();
  
  // Draw character
  lightFalloff(0.7, 0.01, 0);
  pushMatrix();
  translate(-160, -100, 280);
  pointLight(255, 150, 255, 0, 0, 0);
  popMatrix();
  shape(character);
}
