public class BeatVisualizer implements Visualizer, AudioListener {
  boolean active = false;
  public BeatVisualizer() {
    init();
  }

  public void tick() {
  }

  public void init() {
    for ( int x = 0; x < 8; x++ ) {
      for ( int y = 0; y< 8; y++) {
        tiles[x][y] = 0;
      }
    }
  }

  void samples(float[] samp) {
    samples( samp, samp );
  }

  void samples(float[] sampL, float[] sampR) {
    if ( active ) {
      for ( int x = 0; x < 8; x++ ) {
        float val = 0;
        for ( int i =0; i<5; i++) {
          val = sampL[x*5+i] * 8;
        }
        
        for ( int y = -4; y< 4; y++) {
          if (val > y && val < y+1) {  
            tiles[x][4+y] = 255;
          } 
          else {
            tiles[x][4+y] -= tiles[x][4+y]/4;
          }
        }
      }
    }
  }
  
  public void setActive( boolean active ) {
    this.active = active;
  }
}

