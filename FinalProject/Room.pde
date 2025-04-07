class Room {
  float width, height, depth;
  
  Room(float width, float height, float depth) {
    this.width = width;
    this.height = height;
    this.depth = depth;
  }
  
  void display() {
    pushMatrix();
    noFill();
    stroke(255);
    
    // Draw the room boundaries
    box(width, height, depth);
    
    // Add some objects in the room
    pushMatrix();
    translate(100, 50, 100);
    fill(0, 0, 255);
    box(50);
    popMatrix();
    
    pushMatrix();
    translate(-100, 0, -100);
    fill(0, 255, 0);
    sphere(30);
    popMatrix();
    
    // Create a table
    pushMatrix();
    translate(0, 100, 0);
    fill(139, 69, 19);  // Brown color
    box(150, 10, 80);   // Table top
    
    // Table legs
    pushMatrix();
    translate(-60, 50, -30);
    box(10, 100, 10);
    popMatrix();
    
    pushMatrix();
    translate(60, 50, -30);
    box(10, 100, 10);
    popMatrix();
    
    pushMatrix();
    translate(-60, 50, 30);
    box(10, 100, 10);
    popMatrix();
    
    pushMatrix();
    translate(60, 50, 30);
    box(10, 100, 10);
    popMatrix();
    
    popMatrix();
    
    popMatrix();
  }
}
