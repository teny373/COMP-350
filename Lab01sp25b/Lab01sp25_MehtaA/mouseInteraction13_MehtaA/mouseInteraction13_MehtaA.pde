// At each step in time, the following transitions occur:
// 1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
// 2. Any live cell with two or three live neighbours lives on to the next generation.
// 3. Any live cell with more than three live neighbours dies, as if by overpopulation.
// 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

int rows = 50;
int cols = 50;
int[][] grid = new int[rows][cols];
int[][] nextGrid = new int[rows][cols];
int[][] prevGrid = new int[rows][cols];
int[][] prev2Grid = new int[rows][cols];
int[][] shapeType = new int[rows][cols]; // Store shape type (0-3) for each cell
int[][] initGrid = {{19,19}, {21, 19}, {20, 19}, {20, 18}, {21, 20}};
PImage noooImg;
boolean isPlaying = false;
float speed = 10;
long lastUpdate = 0;
int imageGridSize = 10;

void setup() {
  size(500, 500);
  frameRate(60);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      grid[i][j] = 0;
      shapeType[i][j] = int(random(4));
    }
  }
  for (int i = 0; i < initGrid.length; i++) {
    grid[initGrid[i][0]][initGrid[i][1]] = 1;
    shapeType[initGrid[i][0]][initGrid[i][1]] = int(random(4));
  }
  noooImg = loadImage("nooo.gif");
}

void draw() {
  background(255);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (grid[i][j] == 1) fill(0);
      else fill(255);
      drawShape(j * 10, i * 10, 10, shapeType[i][j]);
    }
  }
  if (isPlaying && millis() - lastUpdate >= 1000/speed) {
    nextGeneration();
    lastUpdate = millis();
  }
  // Check if grid, prevGrid, and prev2Grid match
  if (isSame(grid, prevGrid) && isSame(prevGrid, prev2Grid)) {
    int pxSize = imageGridSize * 10;
    image(noooImg, width - pxSize, 0, pxSize, pxSize);
  }
  drawPlayPauseButton();
  drawResetButton();
  drawStepButtons();
}

void nextGeneration() {
  // Shift prevGrid into prev2Grid
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      prev2Grid[i][j] = prevGrid[i][j];
    }
  }
  // Copy current grid to prevGrid
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      prevGrid[i][j] = grid[i][j];
    }
  }
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int state = grid[i][j];
      int neighbors = countNeighbors(grid, i, j);
      if (state == 0 && neighbors == 3) nextGrid[i][j] = 1;
      else if (state == 1 && (neighbors < 2 || neighbors > 3)) nextGrid[i][j] = 0;
      else nextGrid[i][j] = state;
    }
  }
  int[][] temp = grid;
  grid = nextGrid;
  nextGrid = temp;
}

void stepBackward() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      grid[i][j] = prevGrid[i][j];
    }
  }
}

int countNeighbors(int[][] arr, int x, int y) {
  int sum = 0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      int row = (x + i + rows) % rows;
      int col = (y + j + cols) % cols;
      sum += arr[row][col];
    }
  }
  sum -= arr[x][y];
  return sum;
}

void drawShape(float x, float y, float size, int type) {
  if (grid[int(y/10)][int(x/10)] == 0) {
    rect(x, y, size, size); // Always rectangle for inactive cells
    return;
  }
  switch(type) {
    case 0:
      rect(x, y, size, size);
      break;
    case 1:
      ellipse(x + size/2, y + size/2, size, size);
      break;
    case 2:
      triangle(x, y + size, x + size/2, y, x + size, y + size);
      break;
    case 3:
      quad(x + size/2, y, x + size, y + size/2, x + size/2, y + size, x, y + size/2);
      break;
  }
}

void drawButtonLabel(String label, float x, float width) {
  fill(0);
  textAlign(CENTER);
  text(label, x + width/2, 45);
  textAlign(LEFT);
}

void drawPlayPauseButton() {
  fill(200);
  if (isPlaying) {
    rect(0, 0, 80, 30);
    fill(0);
    rect(20, 5, 15, 20);
    rect(45, 5, 15, 20);
  } else {
    rect(0, 0, 80, 30);
    fill(0);
    triangle(20, 5, 20, 25, 60, 15);
  }
  drawButtonLabel(isPlaying ? "Pause" : "Play", 0, 80);
}

void drawResetButton() {
  fill(200);
  rect(80, 0, 80, 30);
  fill(0);
  ellipse(120, 15, 20, 20);
  drawButtonLabel("Reset", 80, 80);
}

void drawStepButtons() {
  fill(200);
  rect(240, 0, 40, 30);
  rect(280, 0, 40, 30);
  fill(0);
  triangle(250, 15, 270, 5, 270, 25); 
  triangle(290, 5, 290, 25, 310, 15); 

  drawButtonLabel("Back", 240, 40);
  drawButtonLabel("Next", 280, 40);
}

void mousePressed() {
  if (mouseX >= 0 && mouseX <= 80 && mouseY >= 0 && mouseY <= 30) {
    isPlaying = !isPlaying;
  } else if (mouseX >= 80 && mouseX <= 160 && mouseY >= 0 && mouseY <= 30) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        grid[i][j] = 0;
      }
    }
  } else if (mouseX >= 240 && mouseX <= 280 && mouseY >= 0 && mouseY <= 30) {
    if (!isPlaying) {
      stepBackward();
    }
  } else if (mouseX >= 280 && mouseX <= 320 && mouseY >= 0 && mouseY <= 30) {
    if (!isPlaying) {
      nextGeneration();
    }
  } else if (mouseY > 30) {
    int row = mouseY / 10;
    int col = mouseX / 10;
    if (row < rows && col < cols) {
      grid[row][col] = 1 - grid[row][col];
      shapeType[row][col] = int(random(4)); // New shape when toggled
    }
    print(row, col);
  }
}

void keyPressed() {
  if (key == '+') speed++;
  if (key == '-' && speed > 1) speed--;
}

boolean isSame(int[][] a, int[][] b) {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (a[i][j] != b[i][j]) return false;
    }
  }
  return true;
}

