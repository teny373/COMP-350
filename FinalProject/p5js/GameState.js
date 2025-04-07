class GameState {
  gl;
  constructor(gl) {
    this.isPaused = true;
    this.showControls = false;
    this.pointerLocked = false;

    // Game stats
    this.playerDeaths = 0;
    this.gameStartTime = 0;
    this.gameTime = 0;

    this.gl = gl
  }

  displayMainMenu() {
    // Reset camera for UI
    camera();
    push();

    // Move to 2D rendering temporarily
    translate(-width / 2, -height / 2, 0);
    fill(0, 0, 0, 150);
    noStroke();
    rect(0, 0, width, height);

    textSize(40);
    textAlign(CENTER, CENTER);
    fill(255);
    text("3D Room Navigation", width / 2, height / 4);

    textSize(20);
    text("Press SPACE to play", width / 2, height / 2);
    text("Press C for controls", width / 2, height / 2 + 40);

    pop();
  }

  displayControls() {
    // Reset camera for UI
    camera();
    push();

    // Move to 2D rendering temporarily
    translate(-width / 2, -height / 2, 0);
    fill(0, 0, 0, 150);
    noStroke();
    rect(0, 0, width, height);

    textSize(30);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Controls", width / 2, height / 4);

    textSize(16);
    // Movement controls
    text("W/S: Move forward/backward", width / 2, height / 2 - 80);
    text("A/D: Move left/right", width / 2, height / 2 - 60);
    text("Mouse: Look around", width / 2, height / 2 - 40);

    // Weapon controls
    text("Mouse click: Fire weapon", width / 2, height / 2 - 10);
    text("R: Reload weapon", width / 2, height / 2 + 10);
    text("1-3: Select weapon", width / 2, height / 2 + 30);
    text("Q/E: Previous/next weapon", width / 2, height / 2 + 50);

    // General controls
    text("ESC: Pause game", width / 2, height / 2 + 80);
    text("Press C to return", width / 2, height / 2 + 120);

    pop();
  }

  displayHUD() {
    if (!player) return;

    console.log('hud');


    // push();
    this.gl.disable(this.gl.DEPTH_TEST);

    camera();
    perspective();
    noLights();

    translate(0, 0, -1);

    // Health and armor container
    fill(0, 0, 0, 180);
    stroke(100);
    strokeWeight(1);
    rect(-width / 2 + 20, height / 2 - 70, 200, 50, 5);

    // Health bar
    noStroke();
    fill(255, 0, 0);
    rect(-width / 2 + 30, height / 2 - 60, map(player.health, 0, player.maxHealth, 0, 180), 15, 3);

    // Armor bar
    fill(0, 100, 255);
    rect(-width / 2 + 30, height / 2 - 40, map(player.armor, 0, player.maxArmor, 0, 180), 15, 3);

    // Text labels with better contrast
    fill(255);
    stroke(0);
    strokeWeight(1);
    textSize(12);
    textAlign(LEFT);
    text(`Health: ${floor(player.health)}/${player.maxHealth}`, -width / 2 + 220, height / 2 - 50);
    text(`Armor: ${floor(player.armor)}/${player.maxArmor}`, -width / 2 + 220, height / 2 - 30);

    // Weapon info
    if (player.hasWeapon()) {
      const weapon = player.getCurrentWeapon();
      fill(0, 0, 0, 180);
      stroke(100);
      strokeWeight(1);
      rect(width / 2 - 220, height / 2 - 70, 200, 50, 5);

      noStroke();
      fill(255);
      text(weapon.name, width / 2 - 210, height / 2 - 55);

      if (weapon.isReloading) {
        fill(255, 200, 0);
        text("RELOADING...", width / 2 - 210, height / 2 - 40);
      } else {
        text(`Ammo: ${weapon.ammoInMagazine}/${weapon.magazineSize} | ${weapon.totalAmmo}`, width / 2 - 210, height / 2 - 40);
      }
    }

    // Crosshair - always in the center
    stroke(255);
    strokeWeight(1);
    noFill();
    line(-10, 0, 10, 0);
    line(0, -10, 0, 10);

    // Current position - top left
    fill(0, 0, 0, 180);
    stroke(100);
    strokeWeight(1);
    rect(-width / 2 + 20, -height / 2 + 20, 200, 20, 5);

    noStroke();
    fill(255);
    textSize(12);
    text(`Position: X:${player.pos.x.toFixed(1)} Y:${player.pos.y.toFixed(1)} Z:${player.pos.z.toFixed(1)}`, -width / 2 + 30, -height / 2 + 35);

    // pop();
    this.gl.enable(this.gl.DEPTH_TEST);

  }

  handleKeyPressed(key, keyCode) {
    // Handle audio context whenever a key is pressed
    if (getAudioContext().state !== 'running') {
      userStartAudio();
    }

    if (key === ' ') {
      this.isPaused = !this.isPaused;

      // Start the game when pressing space
      if (!this.isPaused) {
        // Try to request pointer lock when starting game
        this.requestPointerLock();
        console.log("Game starting... Pointer lock requested");
      } else {
        // Ensure pointer lock is exited when pausing
        if (document.pointerLockElement) {
          this.exitPointerLock();
        }
      }

      // Start audio after user interaction
      userStartAudio();
      return false; // Prevent default space behavior
    }

    if (key === 'c' || key === 'C') {
      this.showControls = !this.showControls;

      // Exit pointer lock when showing controls
      if (this.showControls && this.pointerLocked) {
        this.exitPointerLock();
      }
    }

    if (keyCode === ESCAPE) {
      this.isPaused = true;

      // Exit pointer lock when paused
      if (this.pointerLocked) {
        this.exitPointerLock();
      }

      // Prevent default browser behavior
      return false;
    }
  }

  handleMousePressed() {
    if (this.isPaused) {
      // Could handle menu buttons here

      // Request pointer lock when clicking on menu to start game
      if (!this.pointerLocked && mouseY > height / 2 - 20 && mouseY < height / 2 + 20) {
        this.isPaused = false;
        this.requestPointerLock();
      }

      // Start audio after user interaction
      userStartAudio();
    }
  }

  requestPointerLock() {
    try {
      // Use the canvas element directly for best compatibility
      const canvas = document.querySelector('canvas');
      if (canvas) {
        canvas.requestPointerLock = canvas.requestPointerLock ||
          canvas.mozRequestPointerLock ||
          canvas.webkitRequestPointerLock;

        // Request pointer lock
        canvas.requestPointerLock();
        console.log("Requesting pointer lock on canvas");
      } else {
        console.error("Canvas element not found");
      }
    } catch (e) {
      console.error("Error requesting pointer lock:", e);
      // Still allow the game to start even if pointer lock fails
      this.pointerLocked = false;
      this.isPaused = false;
    }
  }

  exitPointerLock() {
    try {
      document.exitPointerLock = document.exitPointerLock ||
        document.mozExitPointerLock ||
        document.webkitExitPointerLock;
      document.exitPointerLock();
    } catch (e) {
      console.error("Error exiting pointer lock:", e);
    }
    this.pointerLocked = false;
  }

  playerDied() {
    this.playerDeaths++;
    console.log(`Player died (${this.playerDeaths} times)`);
  }
}
