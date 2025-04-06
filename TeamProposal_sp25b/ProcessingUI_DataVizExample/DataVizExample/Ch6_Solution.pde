int n = 100; // Number of points to draw
int d = 5;   // Diameter for points (via strokeWeight)
int m = 10;  // Limits for movement in one frame
float[] x = new float[n];
float[] y = new float[n];
color[] palette = {#F5D799, #59532F, #8C2703, #BF6211};
int critN = 0;  // Counts points in critical quadrant

void setup() {
  size(600, 600);
  frameRate(1);
  for (int i = 0; i < n; i++){
    x[i] = random(-100, 100);
    y[i] = random(-100, 100);
  }
}

void draw() {
  translate(width/2, height/2);
  background(palette[0]);
  
  critN = 0;
  
  // Lines to divide window into quadrants
  strokeWeight(1);
  stroke(palette[1]);
  line(0, -height/2, 0, +height/2);
  line(-width/2, 0, +width/2, 0);
  
  for (int i = 0; i < n; i++){
    if ((x[i] > 0) && (y[i] < 0)) {
      strokeWeight(d*2);
      stroke(palette[2]);
      critN++;
    } else {
      strokeWeight(d);
      stroke(palette[3]);
    }
    point(x[i], y[i]);
    
    x[i] += random(-m * 0.8, m);
    y[i] += random(-m, m * 0.8);
  }
  fill(palette[2]);
  text("Critical Stocks: " + critN, 10, -height/2 + 20);
}
