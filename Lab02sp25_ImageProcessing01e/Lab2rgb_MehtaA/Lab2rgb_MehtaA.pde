import controlP5.*;

PImage original, redVersion, greenVersion, blueVersion;
PImage sample1;
int sectionWidth, sectionHeight;

ControlP5 cp5;
String currentFilter = "NONE";

void setup() {
    size(1000, 600);
    sectionWidth = width / 3;
    sectionHeight = height / 2;

    sample1 = loadImage("data/sample1.jpg");
    original = createImage(sample1.width, sample1.height, RGB);
    redVersion = createImage(original.width, original.height, RGB);
    greenVersion = createImage(original.width, original.height, RGB);
    blueVersion = createImage(original.width, original.height, RGB);
 
    cp5 = new ControlP5(this);
    
    int radioX = sectionWidth + 50;
    int radioY = sectionHeight/2;
 
    cp5.addRadioButton("filterSelection")
       .setPosition(radioX, radioY)
       .setSize(20, 20)
       .setItemsPerRow(2)
       .setSpacingRow(10)
       .setSpacingColumn(50)
       .addItem("0: NONE", 0)
       .addItem("1: THRESHOLD", 1)
       .addItem("2: GRAY", 2)
       .addItem("3: OPAQUE", 3)
       .addItem("4: INVERT", 4)
       .addItem("5: POSTERIZE", 5)
       .addItem("6: BLUR", 6)
       .addItem("7: ERODE", 7)
       .addItem("8: DILATE", 8)
       .addItem("9: CUSTOM", 9)
       .activate(0);
       
    loadRedImage();
    loadGreenImage();
    loadBlueImage();
    
    calculateAndDrawColorGraph();
}

void draw() {
    background(0);
    
    image(sample1, 0, 0, sectionWidth, sectionHeight);
    image(redVersion, 0, sectionHeight, sectionWidth, sectionHeight);
    image(blueVersion, sectionWidth, sectionHeight, sectionWidth, sectionHeight);
    image(greenVersion, sectionWidth*2, sectionHeight, sectionWidth, sectionHeight);

    switch(currentFilter) {
        case "THRESHOLD": 
            filter(THRESHOLD);
            break;
        case "GRAY": 
            filter(GRAY);
            break;
        case "OPAQUE": 
            filter(OPAQUE);
            break;
        case "INVERT": 
            filter(INVERT);
            break;
        case "POSTERIZE": 
            filter(POSTERIZE, 4);
            break;
        case "BLUR": 
            filter(BLUR, 3);
            break;
        case "ERODE": 
            filter(ERODE);
            break;
        case "DILATE": 
            filter(DILATE);
            break;
        case "CUSTOM": 
            // TODO: Implement custom filter 
            break;
        } 
 
    fill(255);
    textSize(12);
    text("Select a filter | press keys 0-9 to apply filters", sectionWidth + 50, sectionHeight/2 - 10);
      
    calculateAndDrawColorGraph();
}

void loadRedImage() {
    sample1.loadPixels();
    redVersion.loadPixels();
    for (int i = 0; i < sample1.pixels.length; i++) {
        color c = sample1.pixels[i];
        redVersion.pixels[i] = color(red(c), 0, 0);
    }
    redVersion.updatePixels();
}

void loadGreenImage() {
    sample1.loadPixels();
    greenVersion.loadPixels();
    for (int i = 0; i < sample1.pixels.length; i++) {
        color c = sample1.pixels[i];
        greenVersion.pixels[i] = color(0, green(c), 0);
    }
    greenVersion.updatePixels();
}

void loadBlueImage() {
    sample1.loadPixels();
    blueVersion.loadPixels();
    for (int i = 0; i < sample1.pixels.length; i++) {
        color c = sample1.pixels[i];
        blueVersion.pixels[i] = color(0, 0, blue(c));
    }
    blueVersion.updatePixels();
}

void calculateAndDrawColorGraph() {
    float totalRed = 0, totalGreen = 0, totalBlue = 0;
    sample1.loadPixels();
    
    for (int i = 0; i < sample1.pixels.length; i++) {
        color c = sample1.pixels[i];
        totalRed += red(c);
        totalGreen += green(c);
        totalBlue += blue(c);
    }
    
    float total = totalRed + totalGreen + totalBlue;
    float redPercent = (totalRed / total) * 100;
    float greenPercent = (totalGreen / total) * 100;
    float bluePercent = (totalBlue / total) * 100;
    
    int graphY = 10;
    int graphX = sectionWidth + 50;
    int barHeight = 30;
    int maxWidth = (width- sectionWidth) - 100; 
    
    fill(255, 0, 0);
    rect(graphX + 70, graphY, (maxWidth * redPercent/100), barHeight);
    fill(0, 255, 0);
    rect(graphX + 70, graphY + barHeight, (maxWidth * greenPercent/100), barHeight);
    fill(0, 0, 255);
    rect(graphX + 70, graphY + barHeight*2, (maxWidth * bluePercent/100), barHeight);
    
    fill(255);
    textSize(12);
    text(String.format("Red: %.1f%%", redPercent), graphX, graphY + 20);
    text(String.format("Green: %.1f%%", greenPercent), graphX, graphY + barHeight + 20);
    text(String.format("Blue: %.1f%%", bluePercent), graphX, graphY + barHeight*2 + 20);
}

void filterSelection(int value) {
    cp5.get(RadioButton.class, "filterSelection").activate(value);
    switch(value) {
        case 0: currentFilter = "NONE"; break;
        case 1: currentFilter = "THRESHOLD"; break;
        case 2: currentFilter = "GRAY"; break;
        case 3: currentFilter = "OPAQUE"; break;
        case 4: currentFilter = "INVERT"; break;
        case 5: currentFilter = "POSTERIZE"; break;
        case 6: currentFilter = "BLUR"; break;
        case 7: currentFilter = "ERODE"; break;
        case 8: currentFilter = "DILATE"; break;
        case 9: currentFilter = "CUSTOM"; break;
    }
}

void keyPressed() {
    if (key == 's' || key == 'S') {
        save("output.jpg");
    }
    switch(key) {
        case '0': filterSelection(0); break;
        case '1': filterSelection(1); break;
        case '2': filterSelection(2); break;
        case '3': filterSelection(3); break;
        case '4': filterSelection(4); break;
        case '5': filterSelection(5); break;
        case '6': filterSelection(6); break;
        case '7': filterSelection(7); break;
        case '8': filterSelection(8); break;
        case '9': filterSelection(9); break;
    }
}

