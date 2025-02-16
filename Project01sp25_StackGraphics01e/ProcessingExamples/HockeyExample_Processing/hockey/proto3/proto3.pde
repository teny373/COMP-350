// Hockey Pong - Iteration 1

PImage rink;
int puckX, puckY;                 // Puck position
int dx=3, dy = 3;                 // puck x,y speed
int puckSpeed = 6;
int lpaddlex=50, lpaddley=200;    // Left paddle position
int lpaddledy = 0;                // Left paddle speed
int rpaddlex=733, rpaddley=200;   // Right paddle position
int rpaddledy = 6;                // right paddle speed.
int paddleSpeed = 6;              // How fast can a paddle move?
int pmaxy=350, pminy=60;          // Paddle motion extent
int myFrameRate = 45;

timer T = new timer(6);           // Game event timer

// Errors
final int NO_SUCH_SCREEN   = 100;
final int BAD_SCREEN_STATE = 101;

// Screen states
final int startState  = 0;    // Start screen
final int optionState = 1;    // Option screen
final int playState   = 2;    // Play screen
final int endState    = 3;    // Terminal screen, credits
int screenState = startState;

// The play screen has internal states
final int gameStateStart        = 0;  // Game is beginning; countdown to faceoff, scores are 0-0
final int gameStateStartPeriod  = 1;  // Period begins, timer reset
final int gameStateFaceoff      = 2;  // Obvious
final int gameStatePlay         = 3;  // Play is happening; scores are being kepts, puck is moving.
final int gameStateEndPeriod    = 4;  // End of a period. Like state 2.
final int gameStateDone         = 5;  // End of game; go back to Start state in a few seconds.
int gameState = gameStateStart;       // The game state variable           
boolean fflag = false;                // Faceoff flag - winner sets it to true;
boolean greenLight = false;           // Play light/goal light
int spot1x=100, spot1y=140, spot2x=600, spot2y=360;   // Spotlights
int sdx1=4, sdy1=-5, sdx2=-4, sdy2=3;
PFont clockFont, signFont;

final int START_TIMER        = 0;     // Timers - start of game
final int START_PERIOD_TIMER = 1;     // Beginning of period
final int FACEOFF_TIMER      = 2;
final int PERIOD_TIMER       = 3;
final int END_TIMER          = 4;
final int END_PERIOD_TIMER   = 5;


// Game values
int scoreLeft = 0;         // Left player score
int scoreRight = 0;        // Right player score
int timeSecs = 120;        // Time remaining in this period
int timeFrac = 0;          // Fractions of a second
int period = 1;                       // Which period?

PImage screen0;   // Start
PImage screen1;   // Options
PImage screen3;   // Quit

// Buttons
PImage playButton;          // Start screen, play
PImage playButtonA;         // Start screen, play (armed) 
PImage optionsButton;       // Start screen, Options
PImage optionsButtonA;      // Start screen, options (armed)
PImage quitButton;          // Start screen, quit
PImage quitButtonA;         // Start scree(Armed)
PImage playerButton[]  = new PImage[2];  // Options screen, 1/2 player
PImage playerButtonA[] = new PImage[2];  // Above, armed
PImage soundButton[]   = new PImage[2];  // Options screen, sound on/off
PImage soundButtonA[]  = new PImage[2];  // Above, armed
PImage teamButton []   = new PImage[4];  // Logos for home team
PImage back;                             // Back to start screen
PImage backA;
PImage selectImage;                      // Which logo was chosen

final int y1button = 400;       // Start screen Y button coordinates
final int y2button = 428;
final int x1button = 120;       // Start screen button x coordinates
final int optionButtonx1 = 56;  // Start/end X for options button on strart screen 
final int optionButtonx2 = 170;
final int playButtonx1 = 341;   // Start/end X for play button on start screen
final int playButtonx2 = 439;
final int quitButtonx1 = 630;   // Start/end X for Quit button on start screen
final int quitButtonx2 = 723;

final int playerButtony1 = 250; // Y coordinate for 1/2 player button, options screen
final int soundButtony1  = 300; // Y coordinate for sound on/off button, options screen
final int teamButtony1 = 350;   // Team selection coordinates, option screen
final int team1x = 461;
final int team2x = 536;
final int team3x = 611;
final int team4x = 686;
final int backX = 120; 
final int backY = 400;

// Sounds
simpleAudio z;
int puckBoards[] = new int[12];        // Sound of puck hitting boards
int ambient[]    = new int[6];         // Audience sounds                // Which audience sound is current?
int faceoff[]    = new int[6];         // faceoff sounds
int goal;                              // Goal horn
int periodHorn;                        // End of period horn
int playing = 0;                       // Which audience sound is current?
int entry;                             // Start state, audience
int whistle;                           // referee
int soundOn = 0;              // Is sound on or off?
int teamSelected = -1;        // Which team has been selected as HOME?
int players = 0;              // how many players?

void setup ()
{
  size (800, 600);
  z = new simpleAudio(this);     // Initialize audio system
  puckX = 400; puckY = 225;      // Puck coordinates
  getImages ();                  // Read in graphics
  getSounds();                   // Read in sounds
  clockFont = loadFont ("Quartz-Regular-48.vlw");
  signFont  = loadFont ("ArialMT-48.vlw");
  frameRate(myFrameRate);
}

void getImages ()
{
  rink = loadImage ("rink.bmp");
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
  back            = loadImage ("back.gif");
  backA           = loadImage ("backA.gif");
  screen0 = loadImage ("screen0.png");
  screen1 = loadImage ("screen1.png");
  screen3 = loadImage ("screen3.bmp");  
}

void getSounds ()
{
  puckBoards[0] = z.addSound("sounds/bang00.mp3");
  puckBoards[1] = z.addSound("sounds/bang01.mp3");
  puckBoards[2] = z.addSound("sounds/bang02.mp3");
  puckBoards[3] = z.addSound("sounds/bang03.mp3");
  puckBoards[4] = z.addSound("sounds/bang04.mp3");
  puckBoards[5] = z.addSound("sounds/bang05.mp3");
  puckBoards[6] = z.addSound("sounds/bang07.mp3");
  puckBoards[7] = z.addSound("sounds/bang08.mp3");
  puckBoards[8] = z.addSound("sounds/bang09.mp3");
  puckBoards[9] = z.addSound("sounds/bang10.mp3");
  
  ambient[0] = z.addSound("sounds/amb-aud01.mp3");
  ambient[1] = z.addSound("sounds/amb-aud02.mp3");
  ambient[2] = z.addSound("sounds/amb-aud03.mp3");
  ambient[3] = z.addSound("sounds/amb-aud04.mp3");
  ambient[4] = z.addSound("sounds/amb-aud05.mp3");
  ambient[5] = z.addSound("sounds/amb-aud06.mp3");
  
  faceoff[0] = z.addSound("sounds/sfx-fo01.mp3"); 
  faceoff[1] = z.addSound("sounds/sfx-fo02.mp3"); 
  faceoff[2] = z.addSound("sounds/sfx-fo03.mp3"); 
  faceoff[3] = z.addSound("sounds/sfx-fo04.mp3");   
  
  entry = z.addSound("sounds/entry.mp3");
  periodHorn = z.addSound("sounds/endPeriod.mp3");
  whistle =  z.addSound("sounds/sfx-whistle.mp3");

}

// Main loop - display appropriate screen.
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

void drawLight()
{
  if (greenLight)
    fill (0, 255, 0);
  else
    fill (255, 0, 0);
  ellipse (10, 225, 10, 10);
  ellipse (790, 225, 10, 10);
}

// Display the START screen and buttons
void startScreen ()
{
  int x, y;
  
  image (screen0, 0, 0);
  
  image (optionsButton, optionButtonx1, y1button);
  image (playButton,    playButtonx1, y1button);
  image (quitButton,    quitButtonx1, y1button);
  
  x = mouseX; y = mouseY;
  if (y > y1button && y < y2button)
  {
    if (x>optionButtonx1 && x<optionButtonx2)
    {
        image (optionsButtonA, optionButtonx1, y1button);
    } else if (x>playButtonx1 && x<playButtonx1+playButton.width)
    {
        image (playButtonA,    playButtonx1, y1button);
    } else if (x>quitButtonx1 && x<quitButtonx2)
    {
        image (quitButtonA,    quitButtonx1, y1button);
    } 
  } 
}

// Display the OPTIONS screen amd buttons
void optionScreen ()
{
  int x, y;
  
// Basic Options screen image  
  image (screen1, 0, 0);
  
// Place button images on the screen
//  image (playerButton[players], x1button, playerButtony1);
  image (soundButton[soundOn],   x1button, soundButtony1);
  image (selectImage, x1button, teamButtony1);
  
  for (int i=0; i<4; i++)    // Logos. First one is larger.
  {
    if (i == 0)
      image (teamButton[i],    x1button+75*i+selectImage.width+40, teamButtony1-20, 
            teamButton[i].width*2, teamButton[i].height*2);
    else
      image (teamButton[i],    x1button+75*i+selectImage.width+150, teamButtony1);
  }
  
  x = mouseX; y = mouseY;
  if (x > x1button && x < x1button+playerButton[0].width)  // 1 or 2 player?
  {
    if (y>playerButtony1 && y<playerButtony1+playerButton[0].height)
    {
        image (playerButtonA[players], x1button, playerButtony1);
    } else image (playerButton[players], x1button, playerButtony1);
  } else image (playerButton[players], x1button, playerButtony1);
  
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
  
  if ((y>backY && y<backY+back.height) && (x>backX && x<backX+back.width))
    image (backA, backX, backY);                        
  else image (back, backX, backY);                         // Back to main screen
  
}

// Display the PLAY screen: play the game, internal state transitions
void playScreen ()
{
  float t=0.0;
  int min, sec, sec0;
/*
final int gameStateStart        = 0;  // Game is beginning; countdown to faceoff, scores are 0-0
final int gameStateStartPeriod  = 1;  // Period begins, timer reset
final int GameStateFaceoff      = 2;  // Obvious
final int gameStatePlay         = 3;  // Play is happening; scores are being kepts, puck is moving.
final int gameStateEndPeriod    = 4;  // End of a period. Like state 2.
final int gameStateDone         = 5;  // End of game; go back to Start state in a few seconds.
int gameState = gameStateStart;  // The gane state variable           
*/
    T.tick();            // Timer next clock tick
    image (rink, 0,0);  
    stroke (100, 0, 0);
    line (lpaddlex-7, pminy+1, lpaddlex+3, pminy+1);  // Draw the paddle limits
    line (lpaddlex-7, pmaxy+30, lpaddlex+3, pmaxy+30); 
    line (rpaddlex+7, pminy+1, rpaddlex+17, pminy+1); 
    line (rpaddlex+7, pmaxy+30, rpaddlex+17, pmaxy+30); 
    drawLight();
    
// Paddle control first
   fill (0);
   lpaddle();
   rpaddle();
   
   switch (gameState)         // What's going on in the game?
   {
case gameStateStart:
       if (T.finished(START_TIMER))
       {
         gameState = gameStateStartPeriod;
         T.start(START_PERIOD_TIMER, -5);
         if (soundOn==0) z.play(whistle);                     // play whistle
       }
       fill (100, 100, 100, 128);
       rect (0, 0, 800, 450);

// Spotlights - common between-period treat
       noStroke();
       fill (255, 255,255, 128);
       spot1x += sdx1; spot1y += sdy1;
       if (spot1x < 45 || spot1x > 755) sdx1 = -sdx1;
       if (spot1y < 45 || spot1y > 405) sdy1 = -sdy1;
       ellipse (spot1x, spot1y, 90, 90);
       
       spot2x += sdx2; spot2y += sdy2;
       if (spot2x < 45 || spot2x > 755) sdx2 = -sdx2;
       if (spot2y < 45 || spot2y > 405) sdy2 = -sdy2;
       ellipse (spot2x, spot2y, 90, 90); 
       break;

case gameStateStartPeriod:
      if (T.finished(START_PERIOD_TIMER))
      {
        T.start(FACEOFF_TIMER, -(int)(random(3)+2+0.5));
        gameState = gameStateFaceoff;
      }
      noStroke();
      fill (100, 100, 100, 128);
      rect (0, 0, 800, 450);
      fill (255, 255,255, 128);
      ellipse (400, 225, 90, 90);
      ellipse (420, 210, 90, 90);
      ellipse (380, 230, 90, 90);
      break;

case gameStateFaceoff:
    if  (T.finished(FACEOFF_TIMER))   // Transition to PLAY state
    {
      greenLight = true;
      if (soundOn==0) z.play(faceoff[(int)random(4)]);
      fflag = true;              // Faceoff flag. First key press sets it to false.
      gameState = gameStatePlay;
      puckX = 400; puckY = 225;
      if (soundOn==0) 
      {
        playing = (int)random(6);
        z.play(ambient[playing]);
      }
      if (T.finished(PERIOD_TIMER)) T.start(PERIOD_TIMER, -120);
    }
    break;
    
case gameStatePlay:
       puck (puckX, puckY);       // Puck 
       fflag = false;
       if (T.finished(PERIOD_TIMER))  // End of period
       {
         if (soundOn==0) z.play(periodHorn);
         greenLight = false;
         gameState = gameStateEndPeriod;
         T.start(END_PERIOD_TIMER, -3);
       }
       break;

case gameStateEndPeriod:
       if (T.finished(END_PERIOD_TIMER))
       {
         period = period + 1;
         if (period > 3) 
         {
           gameState = gameStateDone;
           period = 3;
           T.start(END_TIMER, -5);
         } else
         {
           gameState = gameStateStartPeriod;
           T.start(START_PERIOD_TIMER, -5);
         }
       }
       if (soundOn==0) z.pause(ambient[playing]);
       break;
       
case gameStateDone:
       if (T.finished (END_TIMER))
       {
         gameState = gameStateStart;
         screenState = startState;
       } 
       break;
    }
    
// screen scoreboard ----------------
  fill (100, 90, 200);        // Background
  rect (0, 450, 800, 150);
  fill (0);
  rect (300, 460, 200, 88);   // Clock 
  rect (100, 490, 100, 100);  // Score
  rect (600, 490, 100, 100);
  rect (430, 551, 50, 45);    // Period
  
  if (greenLight)
    fill (0, 255, 0);
  else
    fill (255, 0, 0);
  ellipse (50, 500, 20, 20);
  
// Fixed Text
  fill (255);
  textFont (signFont, 40);
  text ("Period ", 300, 590);
  text ("HOME", 95, 483);
  text ("GUEST", 580, 483);

// Variable text  
  fill (255, 0, 0);
  textFont (clockFont, 70);
  text (""+scoreLeft, 105, 580);      // Scores
  text (""+scoreRight, 605, 580);
  
  sec = (int)(T.time(PERIOD_TIMER)/myFrameRate + 0.5);
  min = sec/60;
  sec = sec%60;
  sec0 = sec%10;
  sec = sec/10;
  text (""+min+":"+sec+""+sec0, 320, 530);
  
  textFont (clockFont, 40);           // Period
  text (""+period, 450, 590);
  
  if (soundOn==0)
  {
    t = (float)(z.length(ambient[playing]) - z.position(ambient[playing]))/1000.0;
    if (t<1) 
    { 
      playing = (int)random(6);
      z.play(ambient[playing]);
    }
  }
}

// Move the left paddle
void lpaddle()
{
   lpaddley += lpaddledy;                 // Move left paddle up or down
   if (lpaddley>pmaxy || lpaddley<pminy)  // limits?
       lpaddley -= lpaddledy;             // Move it back
   rect (lpaddlex, lpaddley, 10, 30);     // Draw it, a filled rectangle
}

// Move the right paddle. Is sometimes automatic.
void rpaddle()
{  
// PLAYERS = 0 implies a one player game (no human opponent)
  if (players != 0)
  {
    rpaddley += rpaddledy;                 // Move left paddle up or down
    if (rpaddley>pmaxy || rpaddley<pminy)  // limits?
       rpaddley -= rpaddledy;             // Move it back
    rect (rpaddlex, rpaddley, 10, 30);     // Draw it, a filled rectangle
    return;
  }
  
  if (players == 0 && dx>0)
  {
    if (puckX > 600)
    {
    if ((rpaddley+15)-puckY >10) rpaddledy = -paddleSpeed;
     else if ((rpaddley+15)-puckY <10) rpaddledy = paddleSpeed;
     else rpaddledy = 0;
    }
     
    rpaddley += rpaddledy;                 // Move the paddle
    
    if (rpaddley>pmaxy || rpaddley<pminy)  // limits?
        rpaddley -= rpaddledy;             // Move it back
    rect (rpaddlex, rpaddley, 10, 30);    
  } 
  
  else   // player = 1 means an opponent exists. Make the right player's move
  {
    rpaddley += rpaddledy;                 // Move the paddle
    if (rpaddley>pmaxy || rpaddley<pminy)  // limits?
        rpaddley -= rpaddledy;             // Move it back
    rect (rpaddlex, rpaddley, 10, 30);
  }
}

// Display the closing (scredits) screen
void endScreen ()
{
  image (screen3, 0, 0);
}

// Display an error message
void error (int e)
{
}

// Draw the puck in the current position, other puck issues
void puck (int x, int y)
{
  int odx, ody;          // Current puck speeds
  int ox, oy;            // Current position
  
  odx = dx; ody = dy;    // Save current speed
  ox  = puckX;  oy = puckY;
  
  fill(0);
  puckX += dx; puckY += dy;               // Move
  ellipse (x, y, 10, 10);                 // Draw the puck

  if (puckX<=6 || puckX>=width-6)     // Hit end boards?
  { 
    if (soundOn==0) 
      z.play(puckBoards[(int)random(10)]);   // play sound
    if (puckX>=400)                          // Right end
      dx = -(int)(random(puckSpeed)+3);      // Bounce
    else
      dx = (int)random(puckSpeed)+3;
  }
  else if (puckY<=6 || puckY>=444)  // Side boards?
  {
    if (soundOn==0) 
      z.play(puckBoards[(int)random(10)]);   // play sound
    if (puckY > 200)                         // Lower boards
      dy = -(int)(random(puckSpeed)+3);
    else
      dy = (int)(random(puckSpeed)+3);                                // Bounce
  }  
  
  else if (dx < 0)              // Puck moving left
  {
    if ((puckX<=lpaddlex+10 && ox>=lpaddlex+10) &&
        (puckY>=(lpaddley-4) && puckY<(lpaddley+34))  )
                dx = -dx;                               // Puck hits left paddle
    else if ((ox >= lpaddlex+10 && puckX <= lpaddlex+10) &&
             (puckY >= pminy && puckY < pmaxy) )         // Goal
    {
      greenLight = false;
      scoreRight += 1;
      gameState = gameStateFaceoff;
      T.start(FACEOFF_TIMER, -(int)(random(3)+2+0.5));
      puckX = 400; puckY = 225; dx = dy = 0;
      return;
    }
  }
  
  else if (dx > 0)              // Puck moving right
  { 
     if ((puckX >=rpaddlex && ox<=rpaddlex) &&
         (puckY>=(rpaddley-4) && puckY<=(rpaddley+34)) )
                 dx = -dx;                                 // Puck hits right paddle
     else if ((ox <=rpaddlex && puckX >= rpaddlex) &&
             (puckY >= pminy && puckY < pmaxy) )         // Goal
    {
      greenLight = false;
      scoreLeft += 1;
      gameState = gameStateFaceoff;
      T.start(FACEOFF_TIMER, -(int)(random(3)+2+0.5));
      puckX = 400; puckY = 225; dx = dy = 0;
      return;
    }

  }
  
  if ((odx != dx) || (ody != dy))          // A bounce occurred - randomize
  {
    dx = dx + sign(dx)*((int)random(5)-2);
    dy = dy + sign(dy)*((int)random(5)-2);
     
    if (puckX < lpaddlex && dx <= 0) dx = 2;        // Don't allow puck to stay
    else if (puckX > rpaddlex && dx >= 0) dx = -2;  // behind the net too long.
    if (dx == 0) 
    {
      if (random(100) < 50) dx = 2;
      else dx = -2;
    }
  }

// Not too slow or too fast 
  if (dx < -puckSpeed) dx = -puckSpeed;
   else if (dx > puckSpeed) dx = puckSpeed;
   else if (dx == 0) dx = -sign(odx)*3;
     
  if (dy < -puckSpeed) dy = -puckSpeed;
    else if (dy > puckSpeed) dy = puckSpeed;
    else if (dy == 0) dy = -sign(ody)*3;
    
  if (puckX < 6) puckX=6;            // Make certain the puck is on the rink.
  else if (puckX > 794) puckX = 794;
  if (puckY < 6) puckY=6;
  else if (puckY > 794) puckY = 794;
} 

int sign (int x)
{
  if (x < 0) return -1;
  return 1;
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
        exit();  break;
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
      screenState = playState;  // Transition to game screen
      gameState = 0;            // the game screen has states: this is START
      T.start(START_TIMER, -5); // play start timer
      if (soundOn==0) z.play(entry);  // +++++++++++++++++
    } else if (x>quitButtonx1 && x<quitButtonx1+quitButton.width)
    {
      screenState = endState;
    } 
  }
}

void mouseScreenOption ()
{
  int x, y, t= -1;
  PImage xim;
  
  x = mouseX; y = mouseY;
  
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
    
  if (y>backY && y<backY+back.height)    // Back
    if (x>backX && x<backX+back.width)
      screenState = startState;
    
}

void mouseScreenPlay ()
{

}

void keyPressed ()
{
    switch (screenState)
  {
case startState:   break;
case optionState:  break;
case playState:
        if (key == 'w') 
          if (fflag)
          { 
            fflag = false;
            puckX = 400; puckY = 225;
            dx = (int)random(4)+3;
            dy = (int)random(3)+1;
          } else lpaddledy = -paddleSpeed;
        else if (key == 's') 
          if (fflag)
          {
            fflag = false;
            puckX = 400; puckY = 225;
            dx = (int)random(4)+3;
            dy = (int)random(3)+1;
          } else lpaddledy = paddleSpeed;
          
        if (players == 0) 
        {
          if (fflag && (random(100)<3))
          {
               fflag = false;
               puckX = 400; puckY = 225;
               dx = -((int)random(4)+3);
               dy = ((int)random(3)+1);
          }
          return;
        }
        
        if (key == CODED) 
        {
          if (keyCode == UP) 
          {
             if (fflag) 
             {
               fflag = false;
               puckX = 400; puckY = 225;
               dx = -((int)random(4)+2);
               dy = -((int)random(3)+2);
             } else rpaddledy = -paddleSpeed;
          } else if (keyCode == DOWN) 
          {
             if (fflag)
             {
               puckX = 400; puckY = 225;
               dx = -((int)random(4)+2);
               dy = -((int)random(3)+2);
               fflag = false;
             } else rpaddledy = paddleSpeed;
          }
        }
        break;
case endState: break;
default: error (NO_SUCH_SCREEN);  break;
  }
}

void keyReleased ()
{
    switch (screenState)
  {
case startState: break;
case optionState:  break;
case playState:
        if ((key == 'w')||(key == 's')) lpaddledy = 0;
        if (players == 0) return;
        if (key == CODED) 
        {
          if ((keyCode == UP) || (keyCode==DOWN))
             rpaddledy = 0;
        }
        break;

case endState:  break;
default:  error (NO_SUCH_SCREEN); break;
  }
}

class timer 
{
  int Ntimers = 0;         // How many timers?
  int counts[];            // Current timer i count
  int times[];             // Terminal value
  boolean done[];          // Has counted to completion
  boolean active[];        // Has been set
  boolean countdown[];     // If true, counts down to 0
  
  timer (int n)
  {
    Ntimers = n;
    counts = new int[n];
    countdown = new boolean[n];
    times = new int[n];
    done = new boolean[n];
    active = new boolean[n];
    for (int i=0; i<n; i++)
    {
      counts[i] = times[i] = -1;
      countdown[i] = false;
      done[i] = true;
      active[i] = false;
    }
  }
  
  void start (int i, int tt)
  {
    int t = 0;
    
    if (i<Ntimers)
    {
      t = (int)(tt * frameRate);     // seconds to frames
      if (t<0)                       // count down
      {
        times[i] = 0;
        countdown[i] = true;
        counts[i] = -t;
      } else
      {
        times[i] = t;
        countdown[i] = false;
        counts[i] = 0;
      }
      done[i] = false;
      active[i] = true;
    }
  }
  
  int time (int i)
  {
    if (active[i]) return counts[i];
     else return 0;
  }
  
   boolean finished (int i)
   {
     return done[i];
   }
   
   void tick()
   {
     for (int i=0; i<Ntimers; i++)
       if (active[i])
       {
         if (countdown[i]) 
         {
           counts[i] -= 1;
           if (counts[i] <= 0) 
           {
             done[i] = true;
             active[i] = false; 
           }
         }
       }
       else 
       {
         counts[i] += 1;
         if (counts[i] >= times[i]) 
         {
           done[i] = true;
           active[i] = false;
         }
       }
   }
}

