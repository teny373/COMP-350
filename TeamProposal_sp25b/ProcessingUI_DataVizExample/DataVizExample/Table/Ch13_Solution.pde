/*

Challenge 4: Interacting with Data

*/

// 0: dark blue; 1: light tan, 2: med blue
color[] palette = {#262A40, #F2EAC2, #8C3F63};
PFont titleFont;  // Times-Roman-40.vlw
PFont axisFont;   // Times-Roman-14.vlw

Table bbd;                 // bbd = "BaseBall Data"

int wide = 1000;           // Width of window
int high = 600;            // Height of window
float border = 75;         // Size of border
float lb = border;         // Left border
float rb = wide - border;  // Right border
float bb = high - border;  // Bottom border
float tb = border;         // Top borders

float gw = rb - lb;        // Grid width
float gh = bb - tb;        // Grid height

String statString = "Data from 2252 Teams";

float minX = 0;
float maxX = 10;
float minY = 0.00;
float maxY = 1.00;

float z = 1;               // Zoom factor for scaling
float tx = wide/2;         // Used for panning on x
float ty = high/2;         // Used for panning on y

// setup ///////////////////////////////////////////////////////////////////////
void setup() {
  size(1000, 600);
  smooth();
  cursor(CROSS);
  titleFont = loadFont("Times-Roman-40.vlw");
  axisFont = loadFont("Times-Roman-14.vlw");
  bbd = new Table("bb.tsv");
}

// draw ///////////////////////////////////////////////////////////////////////
void draw() {
  background(palette[0]);
  scatter("bbd");
  frame(border, palette[0]);
  mainTitle("Winning in baseball: 127 years of data");
  xAxis("Average Runs per Game", lb, bb, rb);
  yAxis("Win %", lb, bb, tb);
}

// scatter ///////////////////////////////////////////////////////////////////
// Draws the scatterplot with the x and y coordinates in the table
void scatter(String tableObject) {
  pushMatrix();
  translate(tx, ty);
  scale(z);
  stroke(palette[1]);
  strokeWeight(3);
  int n = 2522;  // Got this manually from csv file
    
  for (int i = 0; i < n; i++) {
    // Avg runs per game in col. 2
    float x = map(bbd.getFloat(i, 2), minX, maxX, -z*gw/2, z*gw/2);
    // Win % in col. 1
    float y = map(bbd.getFloat(i, 1), minY, maxY, z*gh/2, -z*gh/2);
    point(x, y);
    
    // Hover over data point for team names & stats
    float mx = map(mouseX, lb, rb, -(gw/2)/z - (tx - width/2)/z, (gw/2)/z - (tx - width/2)/z);
    float my = map(mouseY, tb, bb, -(gh/2)/z - (ty - height/2)/z, (gh/2)/z - (ty - height/2)/z);
    if (dist(mx, my, x, y) < 5) {
        statString = bbd.getString(i, 0) + " / Runs per game: " + 
                     nf(bbd.getFloat(i, 2), 0, 2) + " / Win%: " + 
                     nf(bbd.getFloat(i, 1), 0, 3);
    }
  }
  popMatrix();
}

// frame /////////////////////////////////////////////////////////////////////
// Puts a frame around the scatterplot to mask the dots during zoom and slide
//   frame(border, palette[0]);
void frame (float border, color frameColor) {
  noStroke();
  fill(frameColor);
  rect(0, 0, width, border);    // Top mask
  rect(0, bb, width, border);   // Bottom mask
  rect(0, 0, border, height);   // Left mask
  rect(rb, 0, border, height);  // Right mask
}

// mainTitle //////////////////////////////////////////////////////////////////
void mainTitle (String titleText) {
  textAlign(CENTER, CENTER);
  textFont(titleFont);
  fill(palette[1]);
  text(titleText, width/2, 25);
  textFont(axisFont);
  fill(palette[1]);
  text(statString, width/2, 60);
}

// xAxis //////////////////////////////////////////////////////////////////////
void xAxis (String axisTitle, float xl, float y, float xr) {
  stroke(palette[1]);
  strokeWeight(2);
  line(xl, y, xr, y);

  textFont(axisFont);
  fill(palette[1]);
  textAlign(CENTER, CENTER);
  text(axisTitle, width/2, bb + 20);

  String instructions = "Hover over point for data, use up and down arrows to zoom, drag with mouse to pan, press spacebar to reset.";
  fill(palette[1]);
  text(instructions, width/2, height - 25);
}

// yAxis //////////////////////////////////////////////////////////////////////
void yAxis (String axisTitle, float x, float yb, float yt) {
  stroke(palette[1]);
  strokeWeight(2);
  line(x, yb, x, yt);

  textFont(axisFont);
  fill(palette[1]);
  textAlign(RIGHT, CENTER);
  text(axisTitle, lb - 10, height/2);
}

// keyboard zoom //////////////////////////////////////////////////////////////
void keyPressed() {
  if ((key == CODED) && (keyCode == UP))    // Zoom in
    z += .1;
  if ((key == CODED) && (keyCode == DOWN))  // Zoom out
    z -= .1;
  if (key == ' ') {                         // Press spacebar to...
    z = 1;                                  // reset zoom
    tx = wide/2;                            // reset translation on x
    ty = high/2;                            // reset translation on y
    statString = "Data from 2252 Teams";    // reset text
  }
}

// drag mouse ////////////////////////////////////////////////////////////////
void mouseDragged() {
  tx = tx + (mouseX - pmouseX);
  ty = ty + (mouseY - pmouseY);
}
