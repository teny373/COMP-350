public class GameState {
	
	boolean PAUSED = true;	
	boolean CONTROLS = false;
	
	int[] buttonSize = {200, 60};
	int buttonGap = 80;
	
	public GameState() {
		
	}
	
	public void displayControls() {

		// Background
		fill(255);
		rectMode(CENTER);
		rect(width / 2, height / 2, width, height);
		
		// Title
		fill(0);
		textAlign(CENTER, CENTER);
		textSize(48);
		text("Controls", width / 2, 100);
		
		// Control instructions
		textSize(24);
		text("Press 'ESC' to pause the game", width / 2, height/2 - 120);
		text("Hold SPACEBAR to charge jump", width / 2, height/2 - 80);
		text("Release SPACEBAR to jump", width / 2, height/2 - 40);
		text("Aim with mouse to set jump direction", width / 2, height/2);
		text("Press 'R' to restart the game", width / 2, height/2 + 40);
		text("Press 'Q' to quit the game", width / 2, height/2 + 80);
		
		// Back button
		fill(200, 200, 200);
		rectMode(CENTER);
		rect(width / 2, height - 100, buttonSize[0], buttonSize[1]);
		
		fill(0);
		textAlign(CENTER, CENTER);
		textSize(32);
		text("Back", width / 2, height - 100);
	}
	
	public void displayMainMenu() {
		// Background
		fill(255);
		rectMode(CENTER);
		rect(width / 2, height / 2, width, height);
		
		// Title
		fill(0);
		textAlign(CENTER, CENTER);
		textSize(64);
		text("Jump King", width / 2, 100);
		
		// Start button
		fill(200, 200, 200);
		rectMode(CENTER);
		rect(width / 2, height/2 - buttonGap, buttonSize[0], buttonSize[1]);
		
		// Controls button
		rect(width / 2, height/2, buttonSize[0], buttonSize[1]);
		
		// Quit button
		rect(width / 2, height/2 + buttonGap, buttonSize[0], buttonSize[1]);
		
		// Button text
		fill(0);
		textAlign(CENTER, CENTER);
		textSize(32);
		text("Start", width / 2, height/2 - buttonGap);
		text("Controls", width / 2, height/2);
		text("Quit", width / 2, height/2 + buttonGap);
	}
	
	public void handleKeyPressed() {
		switch(key) {
			case ESC:
				PAUSED = !PAUSED;
				break;
		}
	}
	
	public void handleMousePressed() {
		if (CONTROLS) {
			if (mouseX > width/2 - buttonSize[0]/2 && mouseX < width/2 + buttonSize[0]/2 &&
				mouseY > height - 100 - buttonSize[1]/2 && mouseY < height - 100 + buttonSize[1]/2) {
				CONTROLS = false;
				PAUSED = true;
			}
		} else if (PAUSED) {
			if (mouseX > width/2 - buttonSize[0]/2 && mouseX < width/2 + buttonSize[0]/2 &&
				mouseY > height/2 - buttonGap - buttonSize[1]/2 && mouseY < height/2 - buttonGap + buttonSize[1]/2) {
				PAUSED = false;
			}
			
			if (mouseX > width/2 - buttonSize[0]/2 && mouseX < width/2 + buttonSize[0]/2 &&
				mouseY > height/2 - buttonSize[1]/2 && mouseY < height/2 + buttonSize[1]/2) {
				CONTROLS = true;
			}
			
			if (mouseX > width/2 - buttonSize[0]/2 && mouseX < width/2 + buttonSize[0]/2 &&
				mouseY > height/2 + buttonGap - buttonSize[1]/2 && mouseY < height/2 + buttonGap + buttonSize[1]/2) {
				exit();
			}
		}
	}
}
