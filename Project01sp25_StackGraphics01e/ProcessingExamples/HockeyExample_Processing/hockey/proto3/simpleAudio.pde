////////////////////////////////////////////////////////////////////////////////////////////////

// Base class for the game audio system. Contains all sounds.

////////////////////////////////////////////////////////////////////////////////////////////////
import ddf.minim.*;
class simpleAudio 
{
  source sounds[] = new source [16];       // Array of all sounds. Will change size.
  source tmp[];
  int Nsounds = 0;                         // How many sounds exist now?
  int maxSounds = 16;                      // How many CAN exist?
  Minim root;                              // Processing sound base
  processing.core.PApplet parent;
  
  int maxSoundDistance = 300;              // How far away can a sound be heard?
  int minSoundDistance = 0;                // How near for zero attenuation?
  int minGain = -80;                       // Minim smallest gain value
  int maxGain = 6;                         // Minim largest gain value
  
  int listenerX=0, listenerY=0;            // Position of the listener
  float facingAngle = 0.0;                 // Where is listener facing?
  int faceX, faceY;                        // Facing point
  boolean positional = false;
  float panVol[] = new float[360];         // Pan as a function of angle.
  
  simpleAudio (processing.core.PApplet p)
  { 
    parent = p;
    root = new Minim(parent);
    initialize ();
    if (root == null) println ("Constructor simpleAudio fails.");
  }
  
  void initialize ()
  {
// Pan setting indexed by angle in degrees.
    panVol[0] = 0.0; 
    for (int i=1; i<=90; i++)
      panVol[i] = panVol[i-1] + (1.0/90.0);
      
//    println ("PanVol[90] is "+panVol[90]+" should be "+1.0);
    
    panVol[90] = 1.0;
    for (int i=91; i<=180; i++)
      panVol[i] = panVol[i-1] - (0.5/45.0);
      
//    println ("panVol[180] = "+panVol[180]+" should be 0.");
    
    panVol[180] = 0.0;
    for (int i=181; i<=270; i++)
      panVol[i] = panVol[i-1] - (0.5/45.0);
//     println ("panVol[270] = "+panVol[270]+ " should be -1.");
     
     panVol[270] = -1.0;
     for (int i=271; i<360; i++)
      panVol[i] = panVol[i-1] +(0.5/45.0);
      
//     println ("panVol[0] = "+(panVol[359]+(0.5/45.0))+" should be 1.");
  }   
 
  void extend ()        // Double the size of the sound array
  {
    tmp = new source[maxSounds*2];
    for (int i=0; i<maxSounds; i++)
      tmp[i] = sounds[i];
    sounds = tmp;
    maxSounds = maxSounds * 2;
  }

// Set position of the listener  
  void updateListener (int x, int y)
  {
    float a, d;
    int ia;
    
    listenerX = x;
    listenerY = y;
    
    print ("UPDATE ("+listenerX+","+listenerY+") ");
    for (int i=0; i<Nsounds; i++)
     if (sounds[i].positional)
     {
         // Compute distance attenuation
         d = distance (listenerX, listenerY, sounds[i].xpos, sounds[i].ypos);
         a = (minSoundDistance-d)/(minSoundDistance-maxSoundDistance);
         if (a <= 0) a = 0;
          else if (a>=1) a = 1;
         d = minGain+(maxGain-minGain)*(1.0-a);
//  println ("Attenuation = "+a+"   Gain = "+d);
         sounds[i].setGain(d);
         
         a = sourceAngle (listenerX, listenerY, faceX, faceY, sounds[i].xpos, sounds[i].ypos);
         ia = (int)(a+360)%360;
         setPan (i, panVol[ia]);
     }

  }
  
// Update position and facing angle of the listener.
void updateListener (int x, int y, float fa)
{
  float dtor = 3.1415926535/180.0;
  
  facingAngle = fa;
  faceX = (int)(x + cos(fa*dtor)*40);
  faceY = (int)(y + sin(fa*dtor)*40);
  updateListener (x, y);
}

// Update position and facing point of the listener
void updateListener (int x, int y, int fx, int fy)
{

  faceX = fx;
  faceY = fy;
  updateListener (x, y);
}

// Add a sound to the collection, return index
  int addSound ( String name )
  {
    if (Nsounds >= maxSounds) extend();         // Make array larger
    sounds[Nsounds++] = new source (root, name);
//    println ("Adding sound "+(Nsounds-1));
    return Nsounds-1;
  }
  
// POSITIONAL AUDIO core routines ----------------------------------------

//  Return the angle the source makes wrt the player
// -ve is left, +ve is right
float sourceAngle (int ax, int ay,  int bx, int by, int cx, int cy)
{
  int side = 0;
  float angle;
  side = whichSide (ax, ay, bx, by, cx, cy);
  angle = angle_3pt (cx, cy, ax, ay, bx, by);

  return side * angle; 
}

// Return -1 if (cx, cy) is on the left of the line, 1 otherwise.
int whichSide( int ax, int ay,  int bx, int by, int cx, int cy) 
{
    final int LEFT = -1;
    final int RIGHT = 1;
    float m, b, res;
    
// Test to see if the line is vertical. If so, slope is infinite!    
    if (ax == bx) 
    { 
        if (cx < bx) 
        {
           if (by > ay) return RIGHT;
            else return LEFT;
        }
        if (cx > bx) 
        {
            if (by > ay) return LEFT;
             else return RIGHT;
        } 
        return LEFT;
    }

// If the slope is 0 then line is horizontal, and test is also easy.
    if (ay == by) 
    {
        if (cy < by) 
        {
           if (bx > ax) return LEFT;
            else return RIGHT;
        }
        if (cy > by) 
        {
            if (bx > ax) return RIGHT;
           else return LEFT;
        } 
        return LEFT;
    }
    
// Now calculate the line equation parameters
    m = (float)(by - ay) / (float)(bx - ax);
    b = (float)ay - ax * m;
    
// Plug in test point to see what the equation says.
    res = (m*cx) + b;
    
    if (m != 0) 
    {
        if (cy > res) 
        {     
           if (bx > ax) return RIGHT; 
            else return LEFT;  
        }
        if (cy < res) 
        {        
           if (bx > ax) return LEFT;  
            else return RIGHT; 
        }
        return RIGHT;
    }
    return RIGHT;
}

float angle_3pt (int x1, int y1, int x2, int y2, int x3, int y3)
{
  float ax, ay, bx, by;
  float da, db, dot, r, theta;
  
  ax = x2-x3; ay = y2-y3;
  da = sqrt(ax*ax + ay*ay);  // Length of a
  bx = x2-x1; by = y2 - y1;
  db = sqrt(bx*bx+by*by);    // Length of b
  dot = ax*bx + ay*by;       // Dot product
  if (da*db == 0) r = 10000.;
   else  r = dot/(da*db);
  theta = acos (r);
//  println ("Theta is "+theta+" (or + "+(theta*180.0/3.1415926)+" degrees.");
  return ( theta * 180.0/3.1415926 );
}

  int addSound ( String name, int t )
  {
    if (Nsounds >= maxSounds) extend();         // Make array larger
    sounds[Nsounds++] = new source (root, name, t);
    return Nsounds-1;
  }
  
  int addSound ( String name, int x, int y )
  {
    if (Nsounds >= maxSounds) extend();         // Make array larger
    sounds[Nsounds++] = new source (root, name, x, y);
    positional = true;
    return Nsounds-1;
  }
  
  int addSound ( String name, int x, int y, int t )
  {
    if (Nsounds >= maxSounds) extend();         // Make array larger
    sounds[Nsounds++] = new source (root, name, x, y, t);
    positional = true;
    return Nsounds-1;
  }
  
  void setClip (int min, int max)
  {
    minSoundDistance = min;
    maxSoundDistance = max;
  }
  
  int posX (int i)
  {
    if (i>=0 && i<Nsounds)
      return sounds[i].xpos;
    else return -1;
  }
  
  int posY (int i)
  {
    if (i>=0 && i<Nsounds)
      return sounds[i].ypos;
    else return -1;
  }
  
float distance (int x1, int y1, int x2, int y2)
{
   float x;
  
  x = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return sqrt(x);
}   

 // Play the sound file, whatever type it is
 void play (int i)             
 {
   if (i>=0 && i<Nsounds)
    sounds[i].play();
 }

 void play (int i, int m)             
 {
   if (i>=0 && i<Nsounds)
    sounds[i].play(m);
 }

// Return the name of the original sound file
  String getName (int i)
  {
    return sounds[i].fileName;
  }

void pause (int i)
{
   if (i>=0 && i<Nsounds)
    sounds[i].pause();
}

void cue (int i, int m)
{
   if (i>=0 && i<Nsounds)
    sounds[i].cue(m);
}  

boolean isLooping (int i)
{
   if (i>=0 && i<Nsounds)
    return sounds[i].isLooping();
   return false;
}

boolean isPlaying (int i)
{
   if (i>=0 && i<Nsounds)
    return sounds[i].isPlaying();
   return false;
}

int length (int i)
{
   if (i>=0 && i<Nsounds)
    return sounds[i].length();
   return 0;
}

// NOTE: Can't loop SAMPLE, play it.
void loop (int i)
{
   if (i>=0 && i<Nsounds)
    sounds[i].loop();
}

void loop (int i, int n)
{
   if (i>=0 && i<Nsounds)
    sounds[i].loop(n);
}

int loopCount(int i)
{
   if (i>=0 && i<Nsounds)
    sounds[i].loopCount();
   return 0;
}

int position(int i)
{
   if (i>=0 && i<Nsounds)
    return sounds[i].position();
   return 0;
}

void rewind (int i, int n)
{
   if (i>=0 && i<Nsounds)
    sounds[i].rewind(n);
}

void skip (int i, int m)
{
   if (i>=0 && i<Nsounds)
    sounds[i].skip(m);
}

int bufferSize (int i)
{
   if (i>=0 && i<Nsounds)
    return sounds[i].bufferSize();
   return 0;
}

float sampleRate (int i)
{
   if (i>=0 && i<Nsounds)
    return sounds[i].sampleRate();
   return 0.0;
}

float getBalance (int i)
{
   if (i>=0 && i<Nsounds)
    return sounds[i].getBalance();
   return 0.0;  
}

float getGain (int i)
{
   if (i>=0 && i<Nsounds)
    return sounds[i].getGain();
   return 0.0;  
}

float getPan (int i)
{
    if (i>=0 && i<Nsounds)
      return sounds[i].getPan();
    return 0.0;  
}

boolean isMuted (int i)
{
    if (i>=0 && i<Nsounds)
      return sounds[i].isMuted();
    return false;
}

void mute (int i)
{
  if (i>=0 && i<Nsounds)
    sounds[i].mute();
}

void setBalance (int i, float b)
{
    if (i>=0 && i<Nsounds)
      sounds[i].setBalance(b);
}

void setGain (int i, float b)
{
    if (i>=0 && i<Nsounds)
      sounds[i].setGain(b);
}

void setPan (int i, float b)
{
    if (i>=0 && i<Nsounds)
      sounds[i].setPan(b);
}

void unmute(int i)
{
  if (i>=0 && i<Nsounds)
    sounds[i].unmute();
}

  void terminate ()          // End all sounds
  {
    for (int i=0; i<Nsounds; i++) sounds[i].close();
    root.stop();
    parent.stop();
  }
}
   
  
