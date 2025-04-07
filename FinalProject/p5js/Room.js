class Room {
  constructor(width, height, depth) {
    this.width = width;
    this.height = height;
    this.depth = depth;
    
    // Colors for furniture
    this.wallColor = color(200, 200, 200);
    this.tableColor = color(139, 69, 19);
    this.objectColor1 = color(0, 0, 255);
    this.objectColor2 = color(0, 255, 0);
  }
  
  display() {
    push();
    noFill();
    stroke(255);
    
    // Draw the room boundaries
    box(this.width, this.height, this.depth);
    
    // // Add some objects in the room
    // push();
    // translate(100, 50, 100);
    // fill(this.objectColor1);
    // box(50);
    // pop();
    
    // push();
    // translate(-100, 0, -100);
    // fill(this.objectColor2);
    // sphere(30);
    // pop();
    
    // // Create a table
    // push();
    // translate(0, 100, 0);
    // fill(this.tableColor);
    // box(150, 10, 80);   // Table top
    
    // // Table legs
    // push();
    // translate(-60, 50, -30);
    // box(10, 100, 10);
    // pop();
    
    // push();
    // translate(60, 50, -30);
    // box(10, 100, 10);
    // pop();
    
    // push();
    // translate(-60, 50, 30);
    // box(10, 100, 10);
    // pop();
    
    // push();
    // translate(60, 50, 30);
    // box(10, 100, 10);
    // pop();
    
    // pop();
    
    // Add some walls
    push();
    translate(0, 0, -this.depth/2);
    fill(this.wallColor);
    plane(this.width, this.height);
    pop();
    
    push();
    translate(-this.width/2, 0, 0);
    rotateY(PI/2);
    fill(this.wallColor);
    plane(this.depth, this.height);
    pop();
    
    push();
    translate(this.width/2, 0, 0);
    rotateY(PI/2);
    fill(this.wallColor);
    plane(this.depth, this.height);
    pop();
    
    push();
    translate(0, -this.height/2, 0);
    rotateX(PI/2);
    fill(this.wallColor);
    plane(this.width, this.depth);
    pop();
    
    pop();
  }
}
