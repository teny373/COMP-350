class Weapon {
  constructor(name, damage, fireRate, reloadTime, magazineSize, accuracy) {
    this.name = name;
    this.damage = damage;
    this.fireRate = fireRate; // Shots per second
    this.reloadTime = reloadTime; // Seconds
    this.magazineSize = magazineSize;
    this.accuracy = accuracy; // 0-1, 1 being perfect
    
    // Current state
    this.ammoInMagazine = magazineSize;
    this.totalAmmo = magazineSize * 3; // Start with 3 extra magazines
    this.isReloading = false;
    this.lastFireTime = 0;
    
    // Visual properties
    this.modelScale = 1.0;
    this.modelColor = color(200);
  }
  
  update() {
    // Check if reload is complete
    if (this.isReloading) {
      if (millis() - this.lastFireTime >= this.reloadTime * 1000) {
        this.completeReload();
      }
    }
  }
  
  fire() {
    // Can't fire if reloading or if not enough time has passed since last shot
    if (this.isReloading) return false;
    if (millis() - this.lastFireTime < 1000 / this.fireRate) return false;
    
    // Check if we have ammo
    if (this.ammoInMagazine <= 0) {
      this.reload();
      return false;
    }
    
    // Fire the weapon
    this.ammoInMagazine--;
    this.lastFireTime = millis();
    
    // Calculate hit based on accuracy
    let didHit = random() <= this.accuracy;
    
    console.log(`Fired ${this.name}: Hit? ${didHit}, Ammo left: ${this.ammoInMagazine}`);
    return didHit;
  }
  
  reload() {
    if (this.isReloading) return;
    if (this.ammoInMagazine >= this.magazineSize) return;
    if (this.totalAmmo <= 0) return;
    
    this.isReloading = true;
    this.lastFireTime = millis();
    console.log(`Reloading ${this.name}...`);
  }
  
  completeReload() {
    const ammoNeeded = this.magazineSize - this.ammoInMagazine;
    const ammoToLoad = min(ammoNeeded, this.totalAmmo);
    
    this.ammoInMagazine += ammoToLoad;
    this.totalAmmo -= ammoToLoad;
    this.isReloading = false;
    
    console.log(`Reload complete. ${this.ammoInMagazine} in magazine, ${this.totalAmmo} remaining.`);
  }
  
  addAmmo(amount) {
    this.totalAmmo += amount;
    console.log(`Added ${amount} ammo to ${this.name}. Total: ${this.totalAmmo}`);
  }
  
  display() {
    // Draw weapon model - override in specific weapons
    push();
    fill(this.modelColor);
    // Position at bottom right of screen
    translate(width/4, height/3, -50);
    box(20 * this.modelScale, 5 * this.modelScale, 40 * this.modelScale);
    pop();
  }
}
