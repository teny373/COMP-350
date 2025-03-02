color grassColor = color(0, 255, 0);
color dirtColor = color(139, 69, 19);

public class EnvironmentHandler {
	
	Player currentPlayer;
	Platform[] platforms;
	
	EnvironmentHandler(Player player, Platform[] p) {
		currentPlayer = player;	
		platforms = p;
	}

	public void setPlatforms(Platform[] p) {
		platforms = p;	
	}

	public void update() {
		background(255);
		for (int i = 0; i < platforms.length; i++) {
			platforms[i].display();	
		}
	}

	public void handleKeyPressed() {
		currentPlayer.keyEvent();	
	}
	
}


public class Platform {
	
	float xpos, ypos, hitboxWidth, hitboxHeight;	
	
	Platform(float x, float y, float w, float h) {
		xpos = x;
		ypos = y;
		hitboxWidth = w;
		hitboxHeight = h;	
	}
	
	public void display() {
		fill(dirtColor);
		rectMode(CENTER);
		rect(xpos, ypos, hitboxWidth, hitboxHeight);	
		fill(grassColor);
		rect(xpos, ypos - hitboxHeight/2, hitboxWidth, 5);
	}
	
}
