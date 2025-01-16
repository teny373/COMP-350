PImage bg1, bg2, nooo, yes;
boolean isHomePage = true;
boolean changeBg = false;
int[] balatroButtonCoords = {200, 333, 238, 378}; // x1, y1, x2, y2
int[] exitButtonCoords = {448, 203, 507, 232}; // x1, y1, x2, y2
int delayValue = 2;
int delaySecond = second();

void setup() {
	size(260, 560);

	bg1 = loadImage("homescreen.jpg");
	bg2 = loadImage("balatro.jpg");
  nooo = loadImage("nooo.gif");
  yes = loadImage("yes.jpg");
}

void draw() {
  if (changeBg && (second() - delaySecond >= delayValue)) {
		if (isHomePage) {
      windowResize(560, 260);
		} else {	
      windowResize(260, 560);
	  }
    isHomePage = !isHomePage;
	  changeBg = false;
	}

	imageMode(CORNERS);
	image(isHomePage ? bg1 : bg2, 0, 0, width, height);

  if (!isHomePage) {
    fill(0);
    stroke(0);
    rect(exitButtonCoords[0], exitButtonCoords[1], exitButtonCoords[2] - exitButtonCoords[0], exitButtonCoords[3] - exitButtonCoords[1]);
    fill(255);
    text("Exit", 460, 220);
  } else {
    stroke(255, 0, 0);
    strokeWeight(5);
    int arrowStartX = 170;
    int arrowStartY = 405;
    int arrowEndX = 205;
    int arrowEndY = 389;
    int arrowHeadLength = 10;
    float angle = atan2(arrowEndY - arrowStartY, arrowEndX - arrowStartX);

    line(arrowStartX, arrowStartY, arrowEndX, arrowEndY);

    float arrowHeadAngle1 = angle + radians(135);
    float arrowHeadAngle2 = angle - radians(135);
    float arrowHeadX1 = arrowEndX + cos(arrowHeadAngle1) * arrowHeadLength;
    float arrowHeadY1 = arrowEndY + sin(arrowHeadAngle1) * arrowHeadLength;
    float arrowHeadX2 = arrowEndX + cos(arrowHeadAngle2) * arrowHeadLength;
    float arrowHeadY2 = arrowEndY + sin(arrowHeadAngle2) * arrowHeadLength;

    line(arrowEndX, arrowEndY, arrowHeadX1, arrowHeadY1);
    line(arrowEndX, arrowEndY, arrowHeadX2, arrowHeadY2);

    fill(255, 0, 0);
    textSize(40);
    text("Click Here", arrowStartX - 100, arrowStartY + 30);
  }

  if (changeBg && (second() - delaySecond < delayValue)) {
    if (isHomePage) {
      image(yes, 0, 0, width, height);
    } else {
      image(nooo, 0, 0, width, height);
    }
  }

}

void mousePressed() {
	if (mousePressed == true) {
    if (
      isHomePage &&
      (balatroButtonCoords[0] <= mouseX && mouseX <= balatroButtonCoords[2]) && 
      (balatroButtonCoords[1] <= mouseY && mouseY <= balatroButtonCoords[3])
      ) {
		    changeBg = true;
        delaySecond = second();
    } 
    else if (
      (!isHomePage) &&
      (exitButtonCoords[0] <= mouseX && mouseX <= exitButtonCoords[2]) && 
      (exitButtonCoords[1] <= mouseY && mouseY <= exitButtonCoords[3])
      ) {
        changeBg = true;
        delaySecond = second();
    }
	}
}

void keyPressed() {
  if (key == 'q') {
    if (!isHomePage) {
    changeBg = true;
    delaySecond = second();
    }
  } else if (key == 'b') {
    if (isHomePage) {
    changeBg = true;
    delaySecond = second();
    } 
  }
}

void mouseReleased() {
	
}

