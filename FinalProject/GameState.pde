class GameState {
  boolean PAUSED = false;
  boolean CONTROLS = false;
  
  void displayMainMenu() {
    camera();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    
    fill(0, 0, 0, 150);
    rectMode(CORNER);
    rect(0, 0, width, height);
    
    textAlign(CENTER, CENTER);
    textSize(40);
    fill(255);
    text("3D Room Navigation", width/2, height/4);
    
    textSize(20);
    text("Press SPACE to play", width/2, height/2);
    text("Press C for controls", width/2, height/2 + 40);
    
    hint(ENABLE_DEPTH_TEST);
  }
  
  void displayControls() {
    camera();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    
    fill(0, 0, 0, 150);
    rectMode(CORNER);
    rect(0, 0, width, height);
    
    textAlign(CENTER, CENTER);
    textSize(30);
    fill(255);
    text("Controls", width/2, height/4);
    
    textSize(16);
    text("W/S: Move forward/backward", width/2, height/2 - 60);
    text("A/D: Move left/right", width/2, height/2 - 30);
    text("Mouse: Look around", width/2, height/2);
    text("ESC: Pause game", width/2, height/2 + 30);
    text("Press C to return", width/2, height/2 + 80);
    
    hint(ENABLE_DEPTH_TEST);
  }
  
  void handleKeyPressed() {
    if (key == ' ') {
      PAUSED = !PAUSED;
    }
    
    if (key == 'c' || key == 'C') {
      CONTROLS = !CONTROLS;
    }
    
    if (key == ESC) {
      key = 0;  // Prevent Processing from exiting
      PAUSED = true;
    }
  }
  
  void handleMousePressed() {
    if (PAUSED) {
      // Handle menu clicks here if needed
    }
  }
}
