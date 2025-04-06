size(1000, 300);
int y = height/2;
int d = 150;

smooth();
background(#DBC1A1);

// Pies within circles
noStroke();
fill(#8A8866);
arc(200, y, d, d, PI*-0.5, PI*1.4);
arc(400, y, d, d, PI*-0.5, PI*0.1);
arc(600, y, d, d, PI*-0.5, PI*1.1);
arc(800, y, d, d, PI*-0.5, PI*-0.3);

// Thin circles
stroke(#8C3225);
strokeWeight(3);
noFill();
ellipse(200, y, d, d);
ellipse(400, y, d, d);
ellipse(600, y, d, d);
ellipse(800, y, d, d);

// Thick arc on perimeter
stroke(#3B3B39);
strokeWeight(12);
strokeCap(SQUARE);
arc(200, y, d, d, PI*-0.5, PI*1.3);
arc(400, y, d, d, PI*-0.5, PI*-0.3);
arc(600, y, d, d, PI*-0.5, PI*0.8);
arc(800, y, d, d, PI*-0.5, PI*0.4);
