PShape ground, astronaut, lunarModule;

int[] astronautCords = {460, 460, 250};
int astronautSize = 100;

int[] groundCords = {410, 420, 100};
int groundSize = 1400;

int[] lunarModuleCords = {300, 450, 200};
int lunarModuleSize = 250;


void setup() {
	size(800, 800, P3D);
	
	// ground = loadShape("data/Apollo_17.obj");
	astronaut = loadShape("data/Astronaut/Astronaut.obj");
    lunarModule = loadShape("data/LunarModule/LunarModule.obj");

	background(0);
    // lights();

    // Ground
    pushMatrix(); 
    fill(200);
    translate(groundCords[0], groundCords[1], groundCords[2]);
    rotateX(PI/3);
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

void draw() {

}
