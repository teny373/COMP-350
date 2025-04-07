class Player {
  float x, y, z;
  float size;
  float speed = 5.0;
  boolean moveForward, moveBackward, moveLeft, moveRight;
  float yaw = 0.0; // Rotation around Y-axis
  float pitch = 0.0; // Rotation around X-axis
  PVector velocity = new PVector(0, 0, 0);
  
  float prevMouseX = 0;
  float prevMouseY = 0;
  float sensitivity = 0.003;
  
  Player(float x, float y, float z, float size) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.size = size;
    prevMouseX = mouseX;
    prevMouseY = mouseY;
  }
  
  void update() {
    // Calculate movement direction based on yaw
    PVector forward = new PVector(sin(yaw), 0, cos(yaw));
    PVector right = new PVector(sin(yaw + PI/2), 0, cos(yaw + PI/2));
    
    // Reset velocity
    velocity.set(0, 0, 0);
    
    // Apply movement based on keys pressed
    if (moveForward) {
      velocity.add(PVector.mult(forward, speed));
    }
    if (moveBackward) {
      velocity.add(PVector.mult(forward, -speed));
    }
    if (moveLeft) {
      velocity.add(PVector.mult(right, -speed));  // Fixed left direction
    }
    if (moveRight) {
      velocity.add(PVector.mult(right, speed));   // Fixed right direction
    }
    
    // Apply velocity to position
    x += velocity.x;
    z += velocity.z;
    
    // Constrain player to room boundaries
    x = constrain(x, -room.width/2 + size, room.width/2 - size);
    y = constrain(y, -room.height/2 + size, room.height/2 - size);
    z = constrain(z, -room.depth/2 + size, room.depth/2 - size);
    
    // Update camera to follow player with both yaw and pitch
    camera(
      x, y, z,   // Camera position
      x + sin(yaw) * cos(pitch), 
      y + sin(pitch), 
      z + cos(yaw) * cos(pitch), // Look-at point with pitch
      0, 1, 0    // Up vector
    );
  }
  
  void handleMouseLook(float mx, float my) {
    // Calculate how much the mouse moved from the previous position
    float dx = mx - prevMouseX;
    float dy = my - prevMouseY;
    
    // Only update if there was significant movement
    if (abs(dx) > 0 || abs(dy) > 0) {
      // Update rotation based on mouse movement
      yaw -= dx * sensitivity;
      pitch -= dy * sensitivity;
      
      // Limit pitch to prevent flipping
      pitch = constrain(pitch, -PI/2 + 0.1, PI/2 - 0.1);
      
      // Store current mouse position for next frame
      prevMouseX = mx;
      prevMouseY = my;
    }
  }
  
  void display() {
    // Player is the camera, so no need to draw player model
  }
  
  void handleKeyPressed() {
    if (key == 'w' || key == 'W') moveForward = true;
    if (key == 's' || key == 'S') moveBackward = true;
    if (key == 'a' || key == 'A') moveLeft = true;
    if (key == 'd' || key == 'D') moveRight = true;
  }
  
  void handleKeyReleased() {
    if (key == 'w' || key == 'W') moveForward = false;
    if (key == 's' || key == 'S') moveBackward = false;
    if (key == 'a' || key == 'A') moveLeft = false;
    if (key == 'd' || key == 'D') moveRight = false;
  }
}
