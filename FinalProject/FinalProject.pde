Player player;
Room room;
GameState gameState;

void setup() {
  size(800, 600, P3D);
  
  // Create instances of our classes
  player = new Player(0, 0, 0, 20);
  room = new Room(400, 300, 400);
  gameState = new GameState();
  
  // Set camera position
  camera(0, 0, (height/2) / tan(PI/6), 0, 0, 0, 0, 1, 0);
  
  // Basic lighting
  lights();
}

void draw() {
  background(0);
  
  if (gameState.PAUSED) {
    gameState.displayMainMenu();
  } else {
    // Set ambient light
    ambientLight(50, 50, 50);
    // Add directional light
    directionalLight(255, 255, 255, 0, 1, -1);
    
    // Update player and room
    player.update();
    room.display();
    player.display();
  }
  
  if (gameState.CONTROLS) {
    gameState.displayControls();
  }
}

void keyPressed() {
  player.handleKeyPressed();
  gameState.handleKeyPressed();
}

void keyReleased() {
  player.handleKeyReleased();
}

void mousePressed() {
  gameState.handleMousePressed();
}

void mouseMoved() {
  if (!gameState.PAUSED && !gameState.CONTROLS) {
    player.handleMouseLook(mouseX, mouseY);
  }
}
