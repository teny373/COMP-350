
color[] crowds = {#678C8B, #8FA89B, #A2BAB0, #D0EDDE, #B3B597};
color[] palette = crowds;

void setup(){
  size(600, 1000);
  
  String[] gameSalary = loadStrings("gameSalary.txt");
  println(gameSalary);
  PFont font;
  font = loadFont("ARBLANCA-20.vlw");
  textFont(font);
}

void draw(){
  background(palette[0]);
  fill(palette[2]);
  String[] gameSalary = loadStrings("gameSalary.txt");
  text(3 + ":"+gameSalary[2], mouseX, mouseY);
  int i =0;
  int x=0, y=0;
  
  for( i = 0; i < gameSalary.length; i++){
    text(i+1 +"." + gameSalary[i], x+10, y=y+20);
  }    
}
