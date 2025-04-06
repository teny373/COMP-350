int n = 2;               // Number of items
float[] x = {200, 420};  // x for leaves
int y = 100;             // y for leaves
int r = 100;             // Radius for gradient circle
int t = 180;             // Tint gray scale
int ta = 100;            // Tint alpha

// Data for trees
// Note: When Processing 2.0 is out of beta,
// the new Table class will be able to read
// this information straight from the csv
// file. For now, enter manually.
PImage[] images = new PImage[2];
String[] tree   = {"Oak", "Maple"};
String[] iNames = {"oak.png", "maple.png"};
String[] genus  = {"Quercus", "Acer"};
int[] species   = {600, 128};
String[] uses   = {"Chairs", "Syrup"};

void setup() {
  size(600, 200);
  smooth();
  imageMode(CENTER);
  
  for (int i = 0; i < n; i++) {
    images[i] = loadImage(iNames[i]);
  }
}

void draw() {
  background(255);
  fill(180);
  text("click on leaf for more information", 10, height - 10);
  
  // Cycle through each leaf
  for (int i = 0; i < n; i++) {
    tint(t, ta);  // Tints leaves to gray when not hovering
    if (dist(x[i], y, mouseX, mouseY) < r) {  // If mouse hovering over leaf 0
      gradientCircle(x[i], y, r);             // Add gradient circle
      noTint();                               // Remove image tint
    }
    image(images[i], x[i], y);
    if ((dist(x[i], y, mouseX, mouseY) < r) && mousePressed) {  // If clicked
      dataBox(i);  // Databox with data for index number 0 from arrays
    }
  } 
}

// gradientCircle function
void gradientCircle(float x, float y, float r) {
  ellipseMode(RADIUS);
  for (float i = r; i > 0; i--) {
    noStroke();
    fill(i/r * 255, 20);  // Light on outside, dark in middle
    ellipse(x, y, i, i);
  }
}

// dataBox function
void dataBox(int i) {  // Index number is only argument passed in
  pushMatrix();        // Pushes matrix to not affect leaves with translation
  translate(x[i] - 150, y - 80);  // Translates to top left corner of box
  noStroke();  
  
  fill(220, 180);
  rect(0, 0, 120, 100);

  // Line down left side of box
  stroke(0);
  strokeWeight(5);
  strokeCap(SQUARE);
  line(0, 0, 0, 100);
  
  fill(0);
  text("Name: " + tree[i], 10, 20);
  text("Genus: " + genus[i], 10, 40);
  text("Species: " + species[i], 10, 60);
  text("Uses: " + uses[i], 10, 80);
  
  popMatrix();  // Restores untranslated grid for leaves
}

// Note: Leaf images are public domain from
// http://store.tidbitstrinkets.com/blog/?p=577
