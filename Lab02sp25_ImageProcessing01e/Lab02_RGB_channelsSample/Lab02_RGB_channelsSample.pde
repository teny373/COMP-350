PImage source, imgRed;
PFont font;
 
void setup() {
  frameRate(24);
  size(900, 600);
  source = loadImage("superMarioSmall.png");
  imgRed= createImage(source.width, source.height, RGB);
  font = createFont("Arial", 11);
}

void draw(){
  color p01;
  float r01=0, g01=0,b01=0;
  background(150,150,150);
  image(source, 0, 0);
  image(imgRed, 0, 300);
  
  source.loadPixels();
  imgRed.loadPixels();
  
   for (int x = 0; x < source.width; x++) {
    for (int y = 0; y < source.height; y++ ) {
      int loc = x + y*source.width;
       p01 = source.pixels[loc];  // Read color from source01
       r01 = red(p01);       
       g01 = green(p01);     
       b01 = blue(p01);    
       imgRed.pixels[loc] = color(r01,0,0);     
    }
  }  
     
  imgRed.updatePixels();
  image(imgRed, 0, 300);
  
  int rectangleY= 100;
 
  textFont(font, 30);
  text("Dynamic RGB Bar Graph", width/2, rectangleY - 10);
 
  color p = get(mouseX, mouseY);
  float redValue = red(p);
  float greenValue = green(p);
  float blueValue = blue(p);
  println(redValue +" " +greenValue+" " + blueValue );    

}
