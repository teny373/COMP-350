EnvironmentHandler envHandler;
GameState gameState;

void setup() {
	size(500, 500);
	background(255);
	
	Platform[] platforms = {
		new Platform(250, 475, 500, 50),
			new Platform(250, 200, 200, 50),
			new Platform(250, 300, 200, 50),
			new Platform(250, 100, 200, 50)
		};
	
	envHandler = new EnvironmentHandler(new Player(50, 50, 20, 20), platforms);
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

void mousePressed() {
	gameState.handleMousePressed();	
}
