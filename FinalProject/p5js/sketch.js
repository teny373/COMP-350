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
  // let gl = document.getElementById('defaultCanvas0').getContext('webgl');
  let gl = drawingContext;
  console.log(gl, 'gl');
  

  // Create instances of our classes
  player = new Player(0, 0, 0, 20);
  room = new Room(400, 300, 400);
  gameState = new GameState(gl);

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

    push();
    
    ambientLight(50, 50, 50);
    directionalLight(255, 255, 255, 0, 1, -1);
    
    player.update();
    room.display();
    
    if (player.hasWeapon()) {
      player.getCurrentWeapon().display();
    }


    gameState.displayHUD();
    pop();
    
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
  // Check if gameState exists before accessing it
  if (typeof gameState !== 'undefined' && 
      gameState !== null && 
      !gameState.isPaused && 
      !gameState.showControls &&
      gameState.pointerLocked) {
    
    // Check if player exists before calling handleMouseLook
    if (typeof player !== 'undefined' && player !== null) {
      player.handleMouseLook(movedX, movedY);
    }
  }
  return false;
}

// Add an event listener to handle audio context
function touchStarted() {
  // This will help with the AudioContext issues
  if (getAudioContext().state !== 'running') {
    getAudioContext().resume();
  }
  return false;
}

function mousePressed() {
  // Handle audio context
  if (getAudioContext().state !== 'running') {
    getAudioContext().resume();
  }
  
  // Original mousePressed code
  if (typeof gameState !== 'undefined' && gameState !== null) {
    if (gameState.isPaused && !gameState.showControls) {
      gameState.isPaused = false;
      gameState.requestPointerLock();
    } else if (!gameState.isPaused && gameState.pointerLocked) {
      // Start firing if player exists
      if (typeof player !== 'undefined' && player !== null) {
        player.isFiring = true;
      }
    }
  }
  return false;
}

function mouseReleased() {
  // Stop firing when mouse is released
  if (typeof player !== 'undefined' && player !== null) {
    player.isFiring = false;
  }
  return false;
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
