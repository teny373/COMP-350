class DisplayObject {  
  float x;
  float y;
  float speed;
  float gravity;
  float w;
  float life = 255;
  int normalGravity;
  color objectColor;
  
  DisplayObject(float tempX, float tempY, float tempW, color tempColor) {
    x = tempX;
    y = tempY;
    w = tempW;
    objectColor = tempColor;

    float gravityDirections[] = {-1,1};
    gravity = ((float) random(0.5)) * gravityDirections[(int) random(2)];
    speed = gravity;

    int axisOptions[] = {0,1};
    normalGravity = axisOptions[(int) random(2)];
  }
  
  void move() {
    speed = speed + gravity;
    float dampening = -0.8;

    if (normalGravity == 1) {
      y = y + speed;
      if (y > height) {
        speed = speed * -0.8;
        y = height;
      }
    } else {
      x = x + speed;
      if (x > width) {
        speed = speed * -0.8;
        x = width;
      }
    };
    print("cords: ", mouseX, mouseY, "\nSpeed: ", speed, "\n\n");
  }
  
  boolean finished() {
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    fill(objectColor,life);
    ellipse(x,y,w,w);
  }
}  


// Simple bouncing ball class
class Ball extends DisplayObject { 
  Ball (float tempX, float tempY, float tempW, color tempColor) {
    super(tempX, tempY, tempW, tempColor);
  }
  void display() {
    fill(objectColor,life);
    ellipse(x,y,w,w);
  }
}  

class TriangleThingy extends DisplayObject {
  TriangleThingy (float tempX, float tempY, float tempW, color tempColor) {
    super(tempX, tempY, tempW, tempColor);
  } 
  void display() {
    fill(objectColor, life);
    triangle(
      x, y, 
      x + w, y + w/2, 
      x + w, y - w/2
    );
  }
}

// Simple Hexagon class
class Hexagon extends DisplayObject {
	float angle = TWO_PI / 6;
  Hexagon (float tempX, float tempY, float tempW, color tempColor) {
    super(tempX, tempY, tempW, tempColor);
  }
  void display() {
    fill(objectColor, life);
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * w;
      float sy = y + sin(a) * w;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}

