public class FFTVisualizer implements Visualizer, AudioListener {
  boolean active = false;
  FFT fft;
  public FFTVisualizer( AudioPlayer player ) {
    init();
    fft = new FFT( player.bufferSize(), player.sampleRate());
    fft.logAverages(11, 1);
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

  void   samples(float[] samp) {
    samples( samp, samp );
  }

  void   samples(float[] sampL, float[] sampR) {
    if ( active ) {
      fft.forward( sampL );

      for ( int x = 0; x < 8; x++ ) {
        float val = fft.getAvg(x)/20;
        for ( int y = 0; y< 8; y++) {
          if (val > y) {  
            tiles[x][7-y] = 255;
          } else {
            tiles[x][7-y] -= tiles[x][7-y]/4;
          }
        }
      }
    }
  }
  
  public void setActive( boolean active ) {
    this.active = active;
  }
}

