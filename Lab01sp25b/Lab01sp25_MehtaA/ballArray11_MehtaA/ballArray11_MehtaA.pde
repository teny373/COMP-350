ArrayList<DisplayObject> displayObjects;
int displayObjectWidth = 48;

void setup() {
  size(640, 360);
  noStroke();
  // Create an empty ArrayList (will store DisplayObjects)
  displayObjects = new ArrayList<DisplayObject>();
  
  // Start by adding one element
  displayObjects.add(new Ball(width/2, 0, displayObjectWidth, (color) 0));
}

void draw() {
  background(255);

  for (int i = displayObjects.size()-1; i >= 0; i--) { 
    DisplayObject displayObject = displayObjects.get(i);
    displayObject.move();
    displayObject.display();
    if (displayObject.finished()) {
      displayObjects.remove(i);
    } 
  }   
}

void mousePressed() {
  color randomColor = color(random(255), random(255), color(255));
  int numOfObj = (int) random(1, 5);

  for (int i = 0; i < numOfObj; ++i) { 
    String[] whichObject = {"ball", "triangle", "hexagon"};
    String chosenObject = whichObject[(int) random(whichObject.length)];
    float offsetX = random(10);
    float offsetY = random(10);

    if (chosenObject == "ball") {
      displayObjects.add(new Ball(mouseX + offsetX, mouseY + offsetY, displayObjectWidth, randomColor));
    } else if (chosenObject == "triangle") {
      displayObjects.add(new TriangleThingy(mouseX + offsetX, mouseY + offsetY, displayObjectWidth, randomColor)); 
    } else {
      displayObjects.add(new Hexagon(mouseX + offsetX, mouseY + offsetY, displayObjectWidth/2, randomColor));
    }
  }

}
