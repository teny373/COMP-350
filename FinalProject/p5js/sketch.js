let player;
let room;
let gameState;
let myFont;

function preload() {
  // Load a font before using text in WEBGL
  myFont = loadFont('https://cdnjs.cloudflare.com/ajax/libs/topcoat/0.8.0/font/SourceCodePro-Bold.otf');
}

function setup() {
  // Create canvas that fills the window
  createCanvas(windowWidth, windowHeight, WEBGL);

  // Create instances of our classes
  player = new Player(0, 0, 0, 20);
  room = new Room(400, 300, 400);
  gameState = new GameState();

  // Set the font
  textFont(myFont);

  // Basic lighting
  lights();

  // Wait for user input before starting AudioContext
  userStartAudio();
  
  // Add pointer lock event listeners
  document.addEventListener('pointerlockchange', pointerLockChange);
  document.addEventListener('mozpointerlockchange', pointerLockChange);
  document.addEventListener('webkitpointerlockchange', pointerLockChange);
  
  console.log("Setup complete");
}

function draw() {
  background(0);

  if (gameState.isPaused) {
    gameState.displayMainMenu();
  } else {
    // Set ambient light
    ambientLight(50, 50, 50);
    // Add directional light
    directionalLight(255, 255, 255, 0, 1, -1);

    // Update player and room
    player.update();
    room.display();
  }

  if (gameState.showControls) {
    gameState.displayControls();
  }
}

function keyPressed() {
  player.handleKeyPressed(key, keyCode);
  gameState.handleKeyPressed(key, keyCode);

  if (keyCode.toString().endsWith('ARROW')) {
    return false;
  }
}

function keyReleased() {
  player.handleKeyReleased(key, keyCode);
  return false;
}

function mouseMoved() {
  if (!gameState.isPaused && !gameState.showControls && gameState.pointerLocked) {
    // When pointer is locked, use movedX and movedY instead of mouseX/mouseY
    player.handleMouseLook(movedX, movedY);
  }
  return false;
}

function mousePressed() {
  if (gameState.isPaused && !gameState.showControls) {
    gameState.isPaused = false;
    gameState.requestPointerLock();
    return false;
  }
  gameState.handleMousePressed();
}

function pointerLockChange() {
  console.log("Pointer lock change detected");
  if (document.pointerLockElement === document.querySelector('canvas') ||
      document.mozPointerLockElement === document.querySelector('canvas') ||
      document.webkitPointerLockElement === document.querySelector('canvas')) {
    
    console.log("Pointer is locked");
    gameState.pointerLocked = true;
    gameState.isPaused = false; // Ensure the game is unpaused when pointer is locked
  } else {
    console.log("Pointer is unlocked");
    gameState.pointerLocked = false;
    // Only pause the game if it was previously unpaused
    if (!gameState.isPaused) {
      gameState.isPaused = true;
    }
  }
}

// Add window resize handler
function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
  
  // Update room size proportionally if needed
  room = new Room(windowWidth * 0.5, windowHeight * 0.5, windowWidth * 0.5);
  
  // Reset player position if necessary
  player.resetPosition();
}
