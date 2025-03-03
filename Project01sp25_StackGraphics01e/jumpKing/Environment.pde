color grassColor = color(0, 255, 0);
color dirtColor = color(139, 69, 19);

public class EnvironmentHandler {
	
	Player currentPlayer;
	int totalLevels;
	int currentLevel = 0;
	Platform[][] platforms;
	
	int levelChangeCooldown = 0;
	
	EnvironmentHandler(Player player, Platform[][] p, int startLevel) {
		currentPlayer = player;	
		platforms = p;
		totalLevels = p.length;
		currentLevel = startLevel;
	}

	public void setPlatforms(Platform[][] p) {
		platforms = p;	
	}
	
	public void update() {
		if (levelChangeCooldown > 0) {
			levelChangeCooldown--;
		}

		background(255);
		
		currentPlayer.updateMousePosition(mouseX, mouseY);
		
		checkLevel();
		currentPlayer.update();
		
		checkCollisions();
			
		for (int i = 0; i < platforms[currentLevel].length; i++) {
			platforms[currentLevel][i].display();	
		}		
	}
	
	public void checkCollisions() {
		currentPlayer.isOnGround = false;
		currentPlayer.canJump = false;
		
		checkPlatformCollisions();	
		checkWindowEdges();
	}
	
	private void checkPlatformCollisions() {
		for (Platform platform : platforms[currentLevel]) {
			float playerLeft = currentPlayer.xpos - currentPlayer.hitboxWidth / 2;
			float playerRight = currentPlayer.xpos + currentPlayer.hitboxWidth / 2;
			float playerTop = currentPlayer.ypos - currentPlayer.hitboxHeight / 2;
			float playerBottom = currentPlayer.ypos + currentPlayer.hitboxHeight / 2;
			
			float platformLeft = platform.xpos - platform.hitboxWidth / 2;
			float platformRight = platform.xpos + platform.hitboxWidth / 2;
			float platformTop = platform.ypos - platform.hitboxHeight / 2;
			float platformBottom = platform.ypos + platform.hitboxHeight / 2;
			
			if (playerRight > platformLeft && playerLeft < platformRight && 
				playerBottom > platformTop && playerTop < platformBottom) {
				
				float overlapLeft = playerRight - platformLeft;
				float overlapRight = platformRight - playerLeft;
				float overlapTop = playerBottom - platformTop;
				float overlapBottom = platformBottom - playerTop;
				
				float minOverlap = min(min(overlapLeft, overlapRight), min(overlapTop, overlapBottom));
				
				if (minOverlap == overlapTop && currentPlayer.yvel >= 0) {
					currentPlayer.ypos = platformTop - currentPlayer.hitboxHeight / 2;
					currentPlayer.yvel = 0;
					currentPlayer.isOnGround = true;
					currentPlayer.canJump = true;
					
					if (!currentPlayer.wasOnGround) {
						currentPlayer.xvel = 0;
					}
				} else if (minOverlap == overlapBottom && currentPlayer.yvel <= 0) {
					currentPlayer.ypos = platformBottom + currentPlayer.hitboxHeight / 2;
					currentPlayer.yvel = 0;
				} else if (minOverlap == overlapLeft) {
					currentPlayer.xpos = platformLeft - currentPlayer.hitboxWidth / 2;
					currentPlayer.xvel = -currentPlayer.xvel * currentPlayer.bounceMultiplier; // Reverse and reduce velocity
				} else if (minOverlap == overlapRight) {
					currentPlayer.xpos = platformRight + currentPlayer.hitboxWidth / 2;
					currentPlayer.xvel = -currentPlayer.xvel * currentPlayer.bounceMultiplier; // Reverse and reduce velocity
				}
			}
		}
	}
	
	private void checkWindowEdges() {
		if (currentPlayer.xpos - currentPlayer.hitboxWidth / 2 < 0) {
			currentPlayer.xpos = currentPlayer.hitboxWidth / 2;
			currentPlayer.xvel = -currentPlayer.xvel * currentPlayer.bounceMultiplier; // Bounce off left edge
		}
		
		if (currentPlayer.xpos + currentPlayer.hitboxWidth / 2 > width) {
			currentPlayer.xpos = width - currentPlayer.hitboxWidth / 2;
			currentPlayer.xvel = -currentPlayer.xvel * currentPlayer.bounceMultiplier; // Bounce off right edge
		}
	}
	
	private void checkLevel() {
		if (levelChangeCooldown <= 0) {
			if (currentPlayer.ypos - currentPlayer.hitboxHeight/2 < 0) {
				if (currentLevel < totalLevels - 1) {
					currentLevel++;
					// println("Level up to: " + (currentLevel + 1));
					
					currentPlayer.ypos = height - currentPlayer.hitboxHeight;	
					levelChangeCooldown = 30; // 30 frames cooldown
				} else {
					currentPlayer.ypos = currentPlayer.hitboxHeight/2;
					currentPlayer.yvel = 0;
				}
			}
			
			if (currentPlayer.ypos + currentPlayer.hitboxHeight/2 > height) {
				if (currentLevel > 0) {
					currentLevel--;
					// println("Level down to: " + (currentLevel + 1));
					
					currentPlayer.ypos = currentPlayer.hitboxHeight;	
					levelChangeCooldown = 30;
				} else {
					currentPlayer.ypos = height - currentPlayer.hitboxHeight/2;
					currentPlayer.yvel = 0;
					currentPlayer.isOnGround = true;
					currentPlayer.canJump = true;
					
					if (!currentPlayer.wasOnGround) {
						currentPlayer.xvel = 0;
					}
				}
			}
		}
	}
	
	public void handleKeyPressed() {
		currentPlayer.keyEvent();	
	}
	
	public void handleKeyReleased() {
		currentPlayer.keyReleased();
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
		rect(xpos, ypos - hitboxHeight / 2, hitboxWidth, 5);
	}
	
}
