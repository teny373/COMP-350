PImage daiki, background, background_with_filter, compositeImage;
color chromaKeyColor = color(0, 255, 0);
int threshold = 50;

void setup() {
	size(900, 600);
	daiki = loadImage("../data/daiki_chroma.png");
	daiki.resize(width, height);
	background = loadImage("../data/mariokartbg.jpg");
	background.resize(width, height);
	
	background_with_filter = background.copy();
	background_with_filter.filter(GRAY);
	
	compositeImage = createImage(width, height, RGB);
	
	chromaKey(daiki, background, compositeImage, chromaKeyColor, threshold);
}

void draw() {	
	image(compositeImage, 0, 0);
    drawLegend();
}

void chromaKey(PImage chroma, PImage background, PImage compositeImage, color chromaKeyColor, int threshold) {
	chroma.loadPixels();
	background.loadPixels();
	compositeImage.loadPixels();
	
	for (int pos = 0; pos < chroma.pixels.length; pos++) {
		color c = chroma.pixels[pos];
		
		float d = dist(red(c), green(c), blue(c), red(chromaKeyColor), green(chromaKeyColor), blue(chromaKeyColor));
		
		if (d < threshold) {
			compositeImage.pixels[pos] = background.pixels[pos];
		} else {
			compositeImage.pixels[pos] = chroma.pixels[pos];
		}
	}
	
	compositeImage.updatePixels();	
}

PImage generateNoise() {
	PImage noise = createImage(width, height, RGB);
	noise.loadPixels();
	
	for (int pos = 0; pos < noise.pixels.length; pos++) {
	noise.pixels[pos] = color(random(255), random(255), random(255));
		}
	
	noise.updatePixels();
	
	return noise;
}

PImage generateBrightnessNoise(PImage img) {
	PImage noise;
	
	if (img != null) {
	noise = img.copy();
		} else {
	noise = createImage(width, height, RGB);
		}
	
	noise.loadPixels();
	
	float xoff = 0.0;
	float increment = random(0.01, 0.1);
	
	for (int x = 0; x < width; x++) {
	xoff += increment;
	float yoff = 0.0;  
	for (int y = 0; y < height; y++) {
	    yoff += increment;
	    float bright = noise(xoff,yoff) * 255;
	    color c = noise.pixels[x + y * width];
	    float r = red(c) + bright;
	    float g = green(c) + bright;
	    float b = blue(c) + bright;
	    noise.pixels[x + y * width] = color(constrain(r, 0, 255), constrain(g, 0, 255), constrain(b, 0, 255));
	}
		}
	
	noise.updatePixels();
	return noise;
}

void drawLegend() {
    fill(0, 60);
    rect(0, 0, 500, 200);
    fill(255);
    textSize(20);
    text("1: Chroma Key", 10, 20);
    text("2: Chroma Key with Gray Filter", 10, 40);
    text("3: Chroma Key with Invert Filter", 10, 60);
    text("4: Chroma Key with Threshold Filter", 10, 80);
    text("5: Chroma Key with Noise", 10, 100);
    text("6: Chroma Key with Brightness Noise", 10, 120);
    text("7: Chroma Key with Brightness Noise Background", 10, 140);
    text("S: Save Image", 10, 160);
    text("Q: Quit", 10, 180);
}

void keyPressed() {
	switch(key) {
		case '1':
			chromaKey(daiki, background, compositeImage, chromaKeyColor, threshold);
			break;
		case '2':
			background_with_filter = background.copy();
			background_with_filter.filter(GRAY);
			chromaKey(daiki, background_with_filter, compositeImage, chromaKeyColor, threshold);
			break;
		case '3':
			background_with_filter = background.copy();
			background_with_filter.filter(INVERT);
			chromaKey(daiki, background_with_filter, compositeImage, chromaKeyColor, threshold);
			break;	
		case '4':
			background_with_filter = background.copy();
			background_with_filter.filter(THRESHOLD);
			chromaKey(daiki, background_with_filter, compositeImage, chromaKeyColor, threshold);
			break;
		case '5':
			background_with_filter = generateNoise();
			chromaKey(daiki, background_with_filter, compositeImage, chromaKeyColor, threshold);
			break;
		case '6':
			background_with_filter = generateBrightnessNoise(null);
			chromaKey(daiki, background_with_filter, compositeImage, chromaKeyColor, threshold);
			break;	
		case '7':
			background_with_filter = generateBrightnessNoise(background.copy());
			chromaKey(daiki, background_with_filter, compositeImage, chromaKeyColor, threshold);
			break;
		
		case 'S':
			case 's':
			saveFrame("output.png");
			break;
		
		case 'Q':
			case 'q':
			exit();
			break;
	}
}
