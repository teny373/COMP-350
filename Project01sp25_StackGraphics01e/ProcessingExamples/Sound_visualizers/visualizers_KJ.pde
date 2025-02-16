import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Visualizer viz;
Visualizer[] visualizers; 

Minim minim;
AudioPlayer player;

void setup() {
  size(300,300);
  
  minim = new Minim( this );
  player = minim.loadFile( "EndlessLove.mp3", 1024);
  
  BeatVisualizer bv = new BeatVisualizer();
  player.addListener( bv );
  
  FFTVisualizer fv = new FFTVisualizer( player );
  player.addListener( fv );
  
  visualizers = new Visualizer[] { 
    new SpiralIn(),  
    new BarHorizontal(), 
    new Alternate(), 
    bv, 
    fv 
  };
  
  viz = bv;
  viz.setActive( true );
  Thread t = new Thread() {
    public void run() {
      for(;;) {
        viz.tick();
        delay(125);
      }
    }
  };
  t.start();
  
  
  Thread t2 = new Thread() {
    public void run() {
      for(;;) {
        viz.setActive( false );
        viz = visualizers[ int(random( visualizers.length))];
        viz.init();
        viz.setActive( true );
        delay(8000);
      }
    }
  };
  t2.start();
  player.loop();
}

void draw() {
  background(0);
  float w= 300/8;
  for( int x = 0; x < 8; x++ ){
    for( int y = 0; y< 8; y++) {
      stroke( 255 );
      fill( viz.tiles[x][y],0,0 );
      fill( viz.tiles[x][y],0,0 );
      fill(int(random(100)) ,viz.tiles[x][y],viz.tiles[y][x] );
      if ( viz.tiles[x][y] > 32 ) { viz.tiles[x][y] -= ( viz.tiles[x][y] -32)/25; }
      rect( w * x, w*y, w, w );
    }
  } 
}
