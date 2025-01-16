size(400,400);
PImage img;
img = loadImage("Avengers-Academy.jpg");
image(img, 0, 0);
filter(INVERT);

image(img, 50, 50);
filter(POSTERIZE, 4);
