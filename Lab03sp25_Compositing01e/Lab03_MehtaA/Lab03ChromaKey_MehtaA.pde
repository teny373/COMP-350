PImage daiki, background, compositeImage;
color chromaKeyColor = color(0, 255, 0);
int threshold = 50;

void setup() {
	size(900, 600);
	daiki = loadImage("data/daiki_chroma.png");
	daiki.resize(width, height);
	background = loadImage("data/mariokartbg.jpg");
	background.resize(width, height);
	compositeImage = createImage(width, height, RGB);

    chromaKey();
}

void draw() {	
	image(compositeImage, 0, 0);
}

void chromaKey() {
	daiki.loadPixels();
	background.loadPixels();
	compositeImage.loadPixels();
	
	for (int pos = 0; pos < daiki.pixels.length; pos++) {
		color c = daiki.pixels[pos];
		
		float d = dist(red(c), green(c), blue(c), red(chromaKeyColor), green(chromaKeyColor), blue(chromaKeyColor));
		
		if (d < threshold) {
			compositeImage.pixels[pos] = background.pixels[pos];
		} else {
			compositeImage.pixels[pos] = daiki.pixels[pos];
		}
	}
	
	compositeImage.updatePixels();
	
}