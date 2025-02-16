// Hockey Pong - Iteration 1

PImage rink;
int puckX, puckY;
int dx=5, dy = 6;

// Errors
final int NO_SUCH_SCREEN   = 100;
final int BAD_SCREEN_STATE = 101;

// Screen states
final int startState  = 0;
final int optionState = 1;
final int playState   = 2;
final int endState    = 3;
int screenState = startState;

PImage screen0;
PImage screen1;

// Buttons
PImage playButton;
PImage playButtonA;
PImage optionsButton;
PImage optionsButtonA;
PImage quitButton;
PImage quitButtonA;
PImage playerButton[]  = new PImage[2];
PImage playerButtonA[] = new PImage[2];
PImage soundButton[]   = new PImage[2];
PImage soundButtonA[]  = new PImage[2];
PImage teamButton []   = new PImage[4];
PImage selectImage;

final int y1button = 400;    // Start screen Y button coordinates
final int y2button = 428;
final int x1button = 120;    // Start screen button x coordinates
final int optionButtonx1 = 56;  
final int optionButtonx2 = 170;

final int playButtonx1 = 341;
final int playButtonx2 = 439;
final int playerButtony1 = 250;

final int quitButtonx1 = 630;
final int quitButtonx2 = 723;

final int soundButtony1  = 300;
final int teamButtony1 = 350;
final int team1x = 461;
final int team2x = 536;
final int team3x = 611;
final int team4x = 686;

int soundOn = 0;
int teamSelected = 0;
int players = 0;

void setup ()
{
  size (800, 600);
  
  rink = loadImage ("rink.bmp");
  puckX = 100; puckY = 100;
  playButton      = loadImage ("play.gif");
  playButtonA     = loadImage ("playA.gif");
  optionsButton   = loadImage ("options.gif");
  optionsButtonA  = loadImage ("optionsA.gif");
  playerButton[0] = loadImage ("single.gif");
  playerButtonA[0]= loadImage ("singleA.gif");
  playerButton[1] = loadImage ("double.gif");
  playerButtonA[1]= loadImage ("doubleA.gif");
  quitButton      = loadImage ("quit.gif");
  quitButtonA     = loadImage ("quitA.gif");
  soundButton[0]  = loadImage ("soundOn.gif");
  soundButton[1]  = loadImage ("soundOff.gif");
  soundButtonA[0] = loadImage ("soundOnA.gif");
  soundButtonA[1] = loadImage ("soundOffA.gif");
  teamButton[0]   = loadImage ("victorias.gif");  
  teamButton[1]   = loadImage ("OHC_logo.gif");
  teamButton[2]   = loadImage ("logo3.gif");
  teamButton[3]   = loadImage ("logo4.gif");
  selectImage     = loadImage ("select.gif");
  
  screen0 = loadImage ("screen0.png");
  screen1 = loadImage ("screen1.png");
}

void draw ()
{
  background(200);
  
  switch (screenState)
  {
case startState:
        startScreen();
        break;

case optionState:
        optionScreen();
        break;

case playState:
        playScreen();
        break;

case endState:
        endScreen();
        break;

default:
        error (NO_SUCH_SCREEN);
        break;
  }
}


void startScreen ()
{
  int x, y;
  
  image (screen0, 0, 0);
  
  image (optionsButton, optionButtonx1, y1button);
  image (playButton,    playButtonx1+playButton.width, y1button);
  image (quitButton,    quitButtonx1, y1button);
  
  x = mouseX; y = mouseY;
  if (y > y1button && y < y2button)
  {
    if (x>optionButtonx1 && x<optionButtonx2)
    {
        image (optionsButtonA, optionButtonx1, y1button);
    } else if (x>playButtonx1 && x<playButtonx1+playButton.width)
    {
        image (playerButtonA[players],    playButtonx1, y1button);
    } else if (x>quitButtonx1 && x<quitButtonx2)
    {
        image (quitButtonA,    quitButtonx1, y1button);
    } 
  } 
}

void optionScreen ()
{
  int x, y;
  
// Basic Options screen image  
  image (screen1, 0, 0);
  
// Place button images on the screen
  image (playerButton[players], x1button, playerButtony1);
  image (soundButton[soundOn],   x1button, soundButtony1);
  image (selectImage, x1button, teamButtony1);
  for (int i=0; i<4; i++)    // Logos. First one is larger.
  {
    if (i == 0)
      image (teamButton[i],    x1button+75*i+selectImage.width+40, teamButtony1-20, 
            teamButton[i].width*2, teamButton[i].height*2);
    else
      image (teamButton[i],    x1button+75*i+selectImage.width+150, teamButtony1);
//    println ("team "+i+ " at "+(x1button+75*i+selectImage.width+150)+","+teamButtony1);
  }
  x = mouseX; y = mouseY;
  if (x > x1button && x < x1button+playerButton[0].width)  // 1 or 2 player?
  {
    if (y>playerButtony1 && y<playerButtony1+playerButton[0].height)
    {
        image (playerButtonA[players], x1button, playerButtony1);
    }
  } 
  
  if (x > x1button &&  x < (x1button+soundButton[soundOn].width))  // Sound on/off
  {  
      if (y>soundButtony1 && y<(soundButtony1+soundButton[0].height))
      {                                                          // Toggle sound flag
         image (soundButtonA[soundOn], x1button, soundButtony1);
      }
  } 
  if (x > x1button &&  x < x1button+soundButton[soundOn].width)  // Sound on/off
  {  
      if (y>soundButtony1 && y<soundButtony1+soundButton[soundOn].height)
         image (soundButtonA[soundOn], x1button, soundButtony1);
  } 
  
  if (y>teamButtony1 && y<teamButtony1+selectImage.height)  // Team selection?
  {
    
  }
  
}

void playScreen ()
{
    image (rink, 0,0);  
    
// Puck control
  puck (puckX, puckY);
  puckX += dx; puckY += dy;
  if (puckX<3 || puckX>width) dx = -dx;
  if (puckY<3 || puckY>443) dy = -dy; 
  
// screen Text 
  text ("Hockey Pong Proto 1.0. Screens, background, moving puck.", 50, 500);
  text ("X: "+puckX, 60, 530);  text ("Y: "+puckY, 100, 530);
  text ("Dx: "+dx, 60, 550);    text ("Dy: "+dy, 100, 550);
}

void endScreen ()
{
  
}

void error (int e)
{
}

// Draw the puck in the current position.
void puck (int x, int y)
{
  fill(0);
  ellipse (x, y, 10, 10);
}

void mouseReleased ()
{
  switch (screenState)
  {
case startState:
        mouseScreenStart(); break;
case optionState:
        mouseScreenOption(); break;
case playState:
        mouseScreenPlay(); break;
case endState:
        mouseScreenEnd(); break;
default:
        error (BAD_SCREEN_STATE);
        break;
  }
}

void mouseScreenStart ()
{
  int x, y;
  
  x = mouseX; y = mouseY;
  if (y > y1button && y < y2button)
  {
    if (x>optionButtonx1 && x<optionButtonx2)
    {
      screenState = optionState;
    } else if (x>playButtonx1 && x<playButtonx1+playButton.width)
    {
      screenState = playState;
    } else if (x>quitButtonx1 && x<quitButtonx1+quitButton.width)
    {
      screenState = startState;
    }
  }
}
void mouseScreenOption ()
{
  int x, y, t= -1;
  PImage xim;
  
  x = mouseX; y = mouseY;
  println ("Option screen click at ("+x+","+y+")");
  
  if (x > x1button && x < x1button+playerButton[players].width)  // 1 or 2 player?
  {
    if (y>playerButtony1 && y<playerButtony1+playerButton[players].height)
    {
        players = 1 - players;                               // Toggle No of players
        image (playerButtonA[players], x1button, playerButtony1);
    }
  } 
  
  if (x > x1button &&  x < (x1button+soundButton[soundOn].width))  // Sound on/off
  {  
      if (y>soundButtony1 && y<(soundButtony1+soundButton[0].height))
      {
         soundOn = 1 - soundOn;                          // Toggle sound flag
         image (soundButtonA[soundOn], x1button, soundButtony1);
      }
  } 
  
  if (y>teamButtony1 && y<teamButtony1+selectImage.height)  // Team selection?
  {
    if (x>team2x && x<team2x+teamButton[1].width)
      t = 1;
    else if (x>team3x && x<team3x+teamButton[2].width)
      t = 2;
    else if (x>team4x && x<team4x+teamButton[3].width)
      t = 3;
    if (t>0)
    {
      xim = teamButton[0];
      teamButton[0] = teamButton[t];
      teamButton[t] = xim;
    }
  }
  
  println ("Sound should be between X = "+x1button+" and "+(x1button+soundButton[soundOn].width));
  println ("on="+soundOn+"           and Y = "+soundButtony1+" and "+(soundButtony1+soundButton[0].height));
}
void mouseScreenPlay ()
{
}
void mouseScreenEnd ()
{
}

