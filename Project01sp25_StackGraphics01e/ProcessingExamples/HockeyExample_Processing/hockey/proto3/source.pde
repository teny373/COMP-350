// simpleAudio class SOURCE, representing an audio source

class source
{
  static final int NONE   = 0;     // Not defined.
  static final int EFFECT = 1;     // Snippet
  static final int SAMPLE = 2;     // Samples needed
  static final int STREAM = 3;     // Music

  boolean positional = false;
  int kind = NONE;       // What kind of sound is this?
  int xpos=0, ypos=0;       // Source position
  String fileName = "";     // Sound file associated
  Minim root;
  AudioSnippet se=null;
  AudioSample  sa=null;
  AudioPlayer  st=null;
  float[] leftChannel;
  float[] rightChannel;
  int Nsamples = 0;
  
// Basic constructor makes a snippet.
  source (Minim m, String name)
  {
    fileName = name;
    root = m;
    kind = EFFECT;
    loadSoundFile();
  }
  
// Constructor - Add KIND 
  source (Minim m, String name, int t)
  {
    fileName = name;
    root = m;
    kind = t;
    loadSoundFile();
  }
  
// Constructor - position
  source (Minim m, String name, int x, int y)
  {
    fileName = name;
    root = m;
    kind = EFFECT;
    xpos = x; ypos = y;
    positional = true;
    loadSoundFile();
  }
  
// Constructor - all major parameters
 source (Minim m, String name, int x, int y, int t)
 {
    fileName = name;
    root = m;
    kind = t;
    xpos = x; ypos = y;
    positional = true;
    loadSoundFile();
 } 
   
 void loadSoundFile ()
 {
    if (kind<=0 || kind>STREAM)
    {
      println ("ERROR: Bad kind of sound item "+kind);
      kind = EFFECT;
    }
    
    switch (kind)
    {
case EFFECT:  se = root.loadSnippet(fileName);
              if (se == null)
              {
                println ("ERROR: No sound file '"+fileName+"'.");
                se = root.loadSnippet ("null.mp3");
              }
              break;
case SAMPLE:  sa = root.loadSample (fileName); 
              if (sa == null)
              {
                println ("ERROR: No sound file '"+fileName+"'.");
                sa = root.loadSample ("null.mp3");
                leftChannel = sa.getChannel(AudioSample.LEFT);
                rightChannel = sa.getChannel(AudioSample.RIGHT);
                Nsamples = rightChannel.length;
              }
              break;
case STREAM:  st = root.loadFile (fileName);
              if (st == null)
              {
                println ("ERROR: No sound file '"+fileName+"'.");
                st = root.loadFile("null.mp3");
              }
              break;
    }
 }
 
 // Play the sound file, whatever type it is
 void play ()             
 {
    switch (kind)
    {
case EFFECT:  se.play();  se.rewind();  break;
case SAMPLE:  sa.trigger(); break;
case STREAM:  st.play();    break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
 }

 void play (int m)             
 {
    switch (kind)
    {
case EFFECT:  se.play(m);    break;
case SAMPLE:  sa.trigger(); break;
case STREAM:  st.play(m);    break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
 }

// Return the name of the original sound file
  String getName ()
  {
    return fileName;
  }

void pause ()
{
      switch (kind)
    {
case EFFECT:  se.pause();    break;
case SAMPLE:  sa.stop();     break;
case STREAM:  st.pause();    break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
}

void cue (int m)
{
      switch (kind)
    {
case EFFECT:  se.cue(m);    break;
case SAMPLE:  break;
case STREAM:  st.cue(m);    break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
}  

// Returns FALSE for a SAMPLE
boolean isLooping ()
{
    switch (kind)
    {
case EFFECT:  return se.isLooping();
case STREAM:  return st.isLooping();
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
   return false;
}

// NOTE: Can't tell is a SAMLE is playing, so return false.
boolean isPlaying ()
{
    switch (kind)
    {
case EFFECT:  return se.isLooping();
case STREAM:  return st.isLooping();
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
   return false;
}

// NOTE: Can't tell length of a SAMPLE, return 0.
int length ()
{
    switch (kind)
    {
case EFFECT:  return se.length();
case STREAM:  return st.length();
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
   return 0;
}

// NOTE: Can't loop SAMPLE, play it.
void loop ()
{
    switch (kind)
    {
case EFFECT:   se.loop(); break;
case SAMPLE:   sa.trigger(); break;
case STREAM:   st.loop(); break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
}

// NOTE: Can't loop SAMPLE, play it.
void loop (int n)
{
    switch (kind)
    {
case EFFECT:   se.loop(n); break;
case SAMPLE:   sa.trigger(); break;
case STREAM:   st.loop(n); break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
}

int loopCount()
{
    switch (kind)
    {
case EFFECT:  return se.loopCount();
case STREAM:  return st.loopCount();
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
   return 0;
}

int position()
{
    switch (kind)
    {
case EFFECT:  return se.position();
case STREAM:  return st.position();
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
   return 0;
}

void rewind (int n)
{
    switch (kind)
    {
case EFFECT:   se.rewind(); break;
case SAMPLE:     break;
case STREAM:   st.rewind(); break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
}

void skip (int m)
{
    switch (kind)
    {
case EFFECT:   se.skip(m); break;
case SAMPLE:     break;
case STREAM:   st.skip(m); break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
}

int bufferSize ()
{
      switch (kind)
    {
case EFFECT:  return 0;
case SAMPLE:  return sa.bufferSize();
case STREAM:  return st.bufferSize();
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
   return 0;
}

float sampleRate ()
{
    switch (kind)
    {
case EFFECT:  return 0.0;
case SAMPLE:  return sa.sampleRate();
case STREAM:  return st.sampleRate();
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
   return 0.0;
}

float getBalance ()
{
    switch (kind)
    {
case EFFECT:  return se.getBalance();
case SAMPLE:  return sa.getBalance();
case STREAM:  return st.getBalance();
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
   return 0.0;  
}

float getGain ()
{
    switch (kind)
    {
case EFFECT:  return se.getGain();
case SAMPLE:  return sa.getGain();
case STREAM:  return st.getGain();
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
   return 0.0;  
}

float getPan ()
{
    switch (kind)
    {
case EFFECT:  return se.getPan();
case SAMPLE:  return sa.getPan();
case STREAM:  return st.getPan();
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
   return 0.0;  
}

boolean isMuted ()
{
    switch (kind)
    {
case EFFECT:  return se.isMuted();
case SAMPLE:  return sa.isMuted();
case STREAM:  return st.isMuted();
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
   return false;
}

void mute ()
{
    switch (kind)
    {
case EFFECT:   se.mute();  break;
case SAMPLE:   sa.mute();  break;
case STREAM:   st.mute();  break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
}

void setBalance (float b)
{
    switch (kind)
    {
case EFFECT:   se.setBalance(b);  break;
case SAMPLE:   sa.setBalance(b);  break;
case STREAM:   st.setBalance(b);  break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
}

void setGain (float b)
{
      switch (kind)
    {
case EFFECT:   se.setGain(b);  break;
case SAMPLE:   sa.setGain(b);  break;
case STREAM:   st.setGain(b);  break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
}

void setPan (float b)
{
      switch (kind)
    {
case EFFECT:   se.setPan(b);  break;
case SAMPLE:   sa.setPan(b);  break;
case STREAM:   st.setPan(b);  break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
}

void unmute()
{
    switch (kind)
    {
case EFFECT:   se.unmute();  break;
case SAMPLE:   sa.unmute();  break;
case STREAM:   st.unmute();  break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
}

  void close ()
  {
        switch (kind)
    {
case EFFECT:  se.close();    break;
case SAMPLE:  sa.close();    break;
case STREAM:  st.close();    break;
default:  println ("ERROR: Bad kind of sound item "+kind);
          terminate();
   }
  }
    
 void terminate ()
 {
   println ("Fatal error in sound system.");
   exit();
 }
}
