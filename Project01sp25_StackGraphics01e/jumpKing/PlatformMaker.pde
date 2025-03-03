class PlatformMaker {
  boolean isActive = false;
  boolean isDrawing = false;
  PVector startPoint;
  PVector currentPoint;
  ArrayList<Platform> createdPlatforms;
  
  PlatformMaker() {
    createdPlatforms = new ArrayList<Platform>();
    startPoint = new PVector(0, 0);
    currentPoint = new PVector(0, 0);
  }
  
  void handleKey(char keyChar) {
    if (keyChar == 'p') {
      isActive = !isActive;
      isDrawing = false;
      if (isActive) {
        println("Platform creation mode activated. Click and drag to create platforms.");
      } else {
        println("Platform creation mode deactivated.");
      }
    }
    else if (keyChar == 's' && isActive) {
      println("\n// Generated platform code:");
      println("Platform[] platforms = {");
      println("\tnew Platform(250, 500, 500, 10), // Ground platform");
      
      for (Platform p : createdPlatforms) {
        println("\tnew Platform(" + p.xpos + ", " + p.ypos + ", " + 
                p.hitboxWidth + ", " + p.hitboxHeight + "),");
      }
      
      println("};\n");
    }
    else if (keyChar == 'c' && isActive) {
      createdPlatforms.clear();
      println("All created platforms cleared.");
    }
  }
  
  void handleMousePressed() {
    if (isActive && !isDrawing) {
      startPoint.x = mouseX;
      startPoint.y = mouseY;
      isDrawing = true;
      currentPoint.x = mouseX;
      currentPoint.y = mouseY;
    }
  }
  
  void handleMouseDragged() {
    if (isActive && isDrawing) {
      currentPoint.x = mouseX;
      currentPoint.y = mouseY;
    }
  }
  
  void handleMouseReleased() {
    if (isActive && isDrawing) {
      isDrawing = false;
      
      float centerX = (startPoint.x + currentPoint.x) / 2;
      float centerY = (startPoint.y + currentPoint.y) / 2;
      float width = abs(currentPoint.x - startPoint.x);
      float height = abs(currentPoint.y - startPoint.y);
      
      if (width > 5 && height > 5) {
        Platform newPlatform = new Platform(centerX, centerY, width, height);
        createdPlatforms.add(newPlatform);
        
        println("Platform created: x=" + centerX + ", y=" + centerY + 
                ", width=" + width + ", height=" + height);
      }
    }
  }
  
  void display() {
    if (isActive) {
      for (Platform p : createdPlatforms) {
        p.display();
      }
      
      if (isDrawing) {
        stroke(255, 0, 0);
        strokeWeight(2);
        fill(255, 200, 200, 128);
        rectMode(CORNERS);
        rect(startPoint.x, startPoint.y, currentPoint.x, currentPoint.y);
        
        strokeWeight(1);
        stroke(0);
        rectMode(CENTER);
      }
      
      fill(0);
      textAlign(LEFT, TOP);
      textSize(12);
      text("Platform Creation Mode", 10, 10);
      text("Click and drag to create platforms", 10, 25);
      text("Press 's' to get platform code", 10, 40);
      text("Press 'c' to clear platforms", 10, 55);
      text("Press 'p' to exit platform mode", 10, 70);
    }
  }
  
  ArrayList<Platform> getCreatedPlatforms() {
    return createdPlatforms;
  }
}
