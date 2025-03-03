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
	
	Platform[][] platforms = {{
			new Platform(250, 500, 500, 10), // Ground platform
				
				new Platform(70.0, 426.5, 140.0, 139.0),
				new Platform(427.5, 429.5, 143.0, 137.0),
				new Platform(261.5, 248.0, 99.0, 32.0),
				new Platform(129.5, 204.5, 115.0, 33.0),
				new Platform(267.5, 71.5, 95.0, 31.0),			
			} , {	
			new Platform(129.5, 204.5, 115.0, 33.0),
				new Platform(471.0, 421.5, 56.0, 21.0),
				new Platform(36.0, 420.0, 38.0, 26.0),	
				new Platform(380, 460, 100, 20),
				new Platform(190.5, 304.5, 131.0, 37.0),
				new Platform(295.0, 100.0, 22.0, 24.0),
				new Platform(404.5, 36.0, 81.0, 20.0),
				new Platform(37.0, 74.5, 76.0, 23.0),
				
			} , {
			new Platform(250, 500, 250, 10), // Ground platform
				new Platform(383.5, 356.0, 27.0, 20.0),
				new Platform(279.5, 218.5, 27.0, 25.0),
				new Platform(252.0, 110.5, 268.0, 49.0),
				new Platform(102.5, 208.5, 73.0, 19.0),
				
			} };
	
	envHandler = new EnvironmentHandler(new Player(250, 50, 30, 30), platforms, 1);
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
