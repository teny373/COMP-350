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
      // Toggle platform drawing mode
      isActive = !isActive;
      isDrawing = false;
      if (isActive) {
        println("Platform creation mode activated. Click and drag to create platforms.");
      } else {
        println("Platform creation mode deactivated.");
      }
    }
    else if (keyChar == 's' && isActive) {
      // Print out all created platforms
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
      // Clear all created platforms
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
      
      // Calculate center, width and height for the platform
      float centerX = (startPoint.x + currentPoint.x) / 2;
      float centerY = (startPoint.y + currentPoint.y) / 2;
      float width = abs(currentPoint.x - startPoint.x);
      float height = abs(currentPoint.y - startPoint.y);
      
      // Only create platforms that have a minimum size
      if (width > 5 && height > 5) {
        // Create the platform
        Platform newPlatform = new Platform(centerX, centerY, width, height);
        createdPlatforms.add(newPlatform);
        
        // Print platform details
        println("Platform created: x=" + centerX + ", y=" + centerY + 
                ", width=" + width + ", height=" + height);
      }
    }
  }
  
  void display() {
    if (isActive) {
      // Draw all created platforms
      for (Platform p : createdPlatforms) {
        p.display();
      }
      
      // Show current drawing rectangle
      if (isDrawing) {
        stroke(255, 0, 0);
        strokeWeight(2);
        fill(255, 200, 200, 128);
        rectMode(CORNERS);
        rect(startPoint.x, startPoint.y, currentPoint.x, currentPoint.y);
        
        // Reset drawing settings
        strokeWeight(1);
        stroke(0);
        rectMode(CENTER);
      }
      
      // Show helper text
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
