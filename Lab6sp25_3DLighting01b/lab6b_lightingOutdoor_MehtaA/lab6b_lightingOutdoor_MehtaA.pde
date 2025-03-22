PShape ground, astronaut, lunarModule;

int[] astronautCords = {460, 460, 250};
int astronautSize = 100;

int[] groundCords = {410, 420, 100};
int groundSize = 1400;

int[] lunarModuleCords = {300, 450, 200};
int lunarModuleSize = 250;

boolean showOrignal = false;
int buttonWidth = 100;
int buttonHeight = 40;
int buttonX, buttonY = 10; // buttonX will be calculated based on width

void setup() {
	size(800, 800, P3D);
	
	// ground = loadShape("data/Apollo_17.obj");
	astronaut = loadShape("data/Astronaut/Astronaut.obj");
	lunarModule = loadShape("data/LunarModule/LunarModule.obj");
	
}

void draw() {
	background(0);
	lights();	
	
	if (!showOrignal) {	
		camera(astronautCords[0] + 10, astronautCords[1],(astronautCords[2] - 50) / tan(PI * 30.0 / 180.0), width / 2.0, height / 2.0, 0, 0, 1, 0);
	}
	
	drawScene();
	drawSceneButton();
}

void drawSceneButton() {
	buttonX = width - buttonWidth - 10;
	
	fill(100, 100, 200);
	rectMode(CORNER);
	
	hint(DISABLE_DEPTH_TEST); // Button in 2D screen space, not affected by 3D transformations
	camera();
	noLights();
	
	rect(buttonX, buttonY, buttonWidth, buttonHeight);
	
	fill(255);
	textAlign(CENTER, CENTER);
	text(showOrignal ? "First Person" : "Original View", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2);
		
	hint(ENABLE_DEPTH_TEST); // Re-enable depth testing for 3D rendering
}

void mousePressed() {
	if (mouseX > buttonX && mouseX < buttonX + buttonWidth && 
		mouseY > buttonY && mouseY < buttonY + buttonHeight) {
		showOrignal = !showOrignal;
	}
}

void drawScene() {
	// Ground
	pushMatrix(); 
	fill(200);
	translate(groundCords[0], groundCords[1], groundCords[2]);
	rotateX(PI / 3);
	rotateZ(PI);
	// shape(ground, 0, 0, groundSize, groundSize);
	box(groundSize, groundSize, 10); 
	popMatrix();
	
	// Lunar Module
	pushMatrix();
	translate(lunarModuleCords[0], lunarModuleCords[1], lunarModuleCords[2]);
	// rotateY(PI/3);
	rotateZ(PI);
	shape(lunarModule, 0, 0, lunarModuleSize, lunarModuleSize);
	popMatrix();
	
	// Astronaut
	pushMatrix();
	translate(astronautCords[0], astronautCords[1], astronautCords[2]);
	rotateZ(PI);
	shape(astronaut, 0, 0, astronautSize, astronautSize);
	popMatrix();
}

