EnvironmentHandler envHandler;
GameState gameState;

void setup() {
	size(500, 500);
	background(255);
	
	Platform[] platforms = {
			new Platform(250, 500, 500, 10),

			new Platform(50, 400, 50, 10),
		};
	
	envHandler = new EnvironmentHandler(new Player(250, 400, 20, 20), platforms);
	gameState = new GameState();
}

void draw() {	
	if (gameState.PAUSED) {
		gameState.displayMainMenu();	
	} else {	
		envHandler.update();
	} 
	if (gameState.CONTROLS) {
		gameState.displayControls();	
	}
}


void keyPressed() {	
	envHandler.handleKeyPressed();
	gameState.handleKeyPressed();
}

void keyReleased() {
	envHandler.handleKeyReleased();
}

void mousePressed() {
	gameState.handleMousePressed();	
}
