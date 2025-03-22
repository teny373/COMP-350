PShape ground, astronaut, lunarModule;

int[] astronautCords = {460, 460, 250};
int astronautSize = 100;

int[] groundCords = {410, 420, 100};
int groundSize = 1400;

int[] lunarModuleCords = {300, 450, 200};
int lunarModuleSize = 250;

float[] cameraEyeCoords = {
	astronautCords[0],
	astronautCords[1] - 25,
	astronautCords[2] + 80
};

float[] cameraCenterCoords = {
	astronautCords[0],
	astronautCords[1] - 40,
	astronautCords[2]
};

float rightLightDistance = 50;
float leftLightDistance = 100;  
float heightLightDistance = 60;
float backLightDistance = 200;

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
	noLights();
	
	placeCamera();	

	if (showOrignal) {
		ambientLight(255, 255, 235);
	} else {
		threePointLighting();
	}
	
	drawScene();
	drawSceneButton();
}

void placeCamera() {	
	camera(cameraEyeCoords[0], cameraEyeCoords[1], cameraEyeCoords[2], 
		cameraCenterCoords[0], cameraCenterCoords[1], cameraCenterCoords[2], 
		0, 1, 0);
}

void threePointLighting() {
	
	// ---- fill light (right side)
	float rightLightX = cameraEyeCoords[0] + rightLightDistance;
	float rightLightY = cameraEyeCoords[1];              
	float rightLightZ = cameraEyeCoords[2];              
	
	spotLight(
		255, 255, 230,
		rightLightX, rightLightY, rightLightZ,                
		cameraCenterCoords[0] - rightLightX,        
		cameraCenterCoords[1] - rightLightY,        
		cameraCenterCoords[2] - rightLightZ,        
		PI / 4,
		5
		);
	
	// ---- key light (left side and above)
	float leftLightX = cameraEyeCoords[0] - leftLightDistance;  
	float leftLightY = cameraEyeCoords[1] - heightLightDistance; 
	float leftLightZ = cameraEyeCoords[2];                      
	
	spotLight(
		220, 220, 255,
		leftLightX, leftLightY, leftLightZ,
		cameraCenterCoords[0] - leftLightX,
		cameraCenterCoords[1] - leftLightY,
		cameraCenterCoords[2] - leftLightZ,
		PI / 4,
		8
		);
	
	// ---- back light
	float backLightX = leftLightX;
	float backLightY = leftLightY;
	float backLightZ = astronautCords[2] - backLightDistance;
	
	spotLight(
		255, 240, 200,
		backLightX, backLightY, backLightZ,
		cameraCenterCoords[0] - backLightX,
		cameraCenterCoords[1] - backLightY,
		cameraCenterCoords[2] - backLightZ,
		PI / 4,                                  
		12
		);
	
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
	text(showOrignal ? "3 point lighiting" : "Ambient lighiting", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2);
	
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
