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
