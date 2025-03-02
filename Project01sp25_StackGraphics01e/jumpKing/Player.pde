public class Person {
	
	float xpos, ypos;
	float hitboxWidth, hitboxHeight;
	
	public Person(float x, float y, float w, float h) {
		xpos = x;
		ypos = y;
		hitboxWidth = w;
		hitboxHeight = h;	
	}
}

public class Player extends Person {
	float xvel = 0;
	float yvel = 0;
	float baseJumpPower = 5;
	float maxJumpPower = 15;
	float jumpCharge = 0;
	float gravity = 0.98;
	float maxFallSpeed = 20;
	float friction = 0.8; 
	float bounceMultiplier = 0.6;  // How much bounce (0-1, where 1 would be no energy loss)
	boolean isOnGround = false;
	boolean canJump = false;
	boolean isCharging = false;
	boolean wasOnGround = false; 
	
	float mouseX;
	float mouseY;
	
	float arrowLength = 50;
	
	public Player(float x, float y, float w, float h) {	
		super(x, y, w, h);	
	}
	
	public void update() {
		yvel += gravity;
		
		if (yvel > maxFallSpeed) {
			yvel = maxFallSpeed;
		}
		
		if (isOnGround) {
			xvel = 0;	
			if (!wasOnGround) {
				xvel = 0;
			}
		}
		
		wasOnGround = isOnGround;
		xpos += xvel;
		ypos += yvel;
		if (isCharging && canJump) {
			jumpCharge = min(jumpCharge + 0.5, maxJumpPower);
		}
		
		display();
	}
	
	public void jump() {
		if (canJump) {
			float dx = mouseX - xpos;
			float dy = mouseY - ypos;
			float distance = sqrt(dx * dx + dy * dy);
			
			float power = baseJumpPower + jumpCharge;
			
			if (distance > 0) {
				float jumpSpeed = power / distance;
				xvel = dx * jumpSpeed;
				yvel = dy * jumpSpeed;
			} else {
				yvel = -power;
			}
			
			canJump = false;
			isOnGround = false;
			jumpCharge = 0;
			isCharging = false;
		}
	}
	
	public void display() {
		fill(255, 0, 0); 
		rectMode(CENTER);
		rect(xpos, ypos, hitboxWidth, hitboxHeight);
		
		if (isCharging && canJump) {
			float dx = mouseX - xpos;
			float dy = mouseY - ypos;
			float distance = sqrt(dx * dx + dy * dy);
			
			if (distance > 0) {
				float arrowScale = map(jumpCharge, 0, maxJumpPower, 0.2, 1.0);
				float showLength = arrowLength * arrowScale;
				
				float normX = dx / distance;
				float normY = dy / distance;
				float endX = xpos - normX * showLength;  
				float endY = ypos - normY * showLength;
				
				stroke(0, 255, 255);
				strokeWeight(3);
				line(xpos, ypos, endX, endY);
				
				float arrowSize = 8 * arrowScale;
				pushMatrix();
				translate(endX, endY);
				rotate(atan2(normY, normX));
				triangle(0, 0, -arrowSize, -arrowSize / 2, -arrowSize, arrowSize / 2);
				popMatrix();
				
				strokeWeight(1);
				stroke(0);
			}
			
			float chargeWidth = map(jumpCharge, 0, maxJumpPower, 0, hitboxWidth * 2);
			float meterHeight = 5;
			fill(255, 255, 0);
			rectMode(CENTER);
			rect(xpos, ypos - hitboxHeight, chargeWidth, meterHeight);
		}
	}
	
	public void keyEvent() {
		if (keyPressed) {
			if (key == ' ') {  // Spacebar
				if (canJump && !isCharging) {
					isCharging = true;
					jumpCharge = 0;
				}
			}
		}
	}
	
	public void keyReleased() {
		if (key == ' ') {  // Spacebar released
			if (isCharging) {
				jump();
			}
		}
	}
	
	public void updateMousePosition(float x, float y) {
		mouseX = x;
		mouseY = y;
	}
}
