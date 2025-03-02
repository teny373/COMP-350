EnvironmentHandler envHandler;
GameState gameState;
PlatformMaker platformMaker;

void setup() {
	size(500, 500);
	background(255);
	
	File dataFolder = new File(sketchPath("data"));
	if (!dataFolder.exists()) {
		dataFolder.mkdir();
	}
	
	Platform[] platforms = {
		new Platform(250, 500, 500, 10), // Ground platform
			
			new Platform(70.0, 426.5, 140.0, 139.0),
			new Platform(427.5, 429.5, 143.0, 137.0),
			new Platform(261.5, 248.0, 99.0, 32.0),
			new Platform(129.5, 204.5, 115.0, 33.0),
			new Platform(267.5, 71.5, 95.0, 31.0),
			new Platform(471.0, 21.5, 56.0, 21.0),
			new Platform(36.0, 20.0, 38.0, 26.0),
			
		};
	
	envHandler = new EnvironmentHandler(new Player(250, 400, 30, 30), platforms);
	gameState = new GameState();
	platformMaker = new PlatformMaker();
}

void draw() {	
	if (gameState.PAUSED) {
		gameState.displayMainMenu();	
	} else {	
		envHandler.update();
		platformMaker.display();
	} 
	if (gameState.CONTROLS) {
		gameState.displayControls();	
	}
}

void keyPressed() {	
	// Check if we should handle platform maker keys
	if (key == 'p' || (platformMaker.isActive && (key == 's' || key == 'c'))) {
		platformMaker.handleKey(key);
		return;
	}
	
	envHandler.handleKeyPressed();
	gameState.handleKeyPressed();
}

void keyReleased() {
	envHandler.handleKeyReleased();
}

void mousePressed() {
	if (platformMaker.isActive) {
		platformMaker.handleMousePressed();
	} else {
		gameState.handleMousePressed();
	}
}

void mouseDragged() {
	if (platformMaker.isActive) {
		platformMaker.handleMouseDragged();
	}
}

void mouseReleased() {
	if (platformMaker.isActive) {
		platformMaker.handleMouseReleased();
	}
}
