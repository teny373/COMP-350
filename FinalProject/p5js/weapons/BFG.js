class BFG extends Weapon {
	constructor(obj) {
		// name, damage, fireRate, reloadTime, magazineSize, accuracy
		super("BFG-9000", 30, 40, 2, 400, 0.75);

		this.displayX = 200;
		this.displayY = 160;
		this.displayZ = -150;

		this.recoilAmount = 0;
		this.maxRecoil = 15;
		this.recoilRecoveryRate = 0.8;
		this.lastFireTime = 0;

		this.model = obj;
	}

	display() {
		// Draw pistol model in HUD style
		camera();
		push();
		// Disable depth test to ensure weapon is drawn on top
		drawingContext.disable(drawingContext.DEPTH_TEST);

		// Move to 2D rendering coordinates
		translate(-width / 2, -height / 2, 0);

		// Calculate recoil animation
		if (millis() - this.lastFireTime < 150) {
			// Apply recoil
			this.recoilAmount = this.maxRecoil;
		} else if (this.recoilAmount > 0) {
			// Recover from recoil
			this.recoilAmount *= this.recoilRecoveryRate;
			if (this.recoilAmount < 0.1) this.recoilAmount = 0;
		}

		push();
		// Position at bottom right corner of screen with recoil offset
		translate(width - this.displayX, height - this.displayY + this.recoilAmount, this.displayZ);
		rotateY(PI / 6);
		rotateX(PI / 20);

		model(this.model);

		drawingContext.enable(drawingContext.DEPTH_TEST);
		pop();
	}

	fire() {
		if (super.fire()) {
			this.lastFireTime = millis();
			return true;
		}
		return false;
	}

}
