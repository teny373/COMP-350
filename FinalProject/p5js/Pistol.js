class Pistol extends Weapon {
  constructor() {
    // name, damage, fireRate, reloadTime, magazineSize, accuracy
    super("Pistol", 15, 2, 1.5, 10, 0.8);
    
    // Custom properties for pistol
    this.modelColor = color(50, 50, 50);
    this.modelScale = 0.8;
  }
  
  display() {
    // Draw pistol model
    push();
    fill(this.modelColor);
    
    // View-aligned positioning at bottom right
    translate(200, 150, -200);
    rotateY(PI/8);
    
    // Barrel
    push();
    translate(0, 0, 20);
    box(5, 5, 30);
    pop();
    
    // Body
    box(15, 10, 20);
    
    // Handle
    push();
    translate(0, 15, 0);
    box(10, 20, 15);
    pop();
    
    // Trigger
    push();
    fill(100);
    translate(0, 6, 5);
    box(5, 5, 5);
    pop();
    
    pop();
  }
  
  fire() {
    if (super.fire()) {
      // Pistol-specific firing effects
      // Could add sound, visual effects, etc.
      return true;
    }
    return false;
  }
}
