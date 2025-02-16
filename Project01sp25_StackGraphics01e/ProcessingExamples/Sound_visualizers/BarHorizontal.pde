public class BarHorizontal implements Visualizer {
  int px = 0;
  int count = 0;

  public BarHorizontal() {
    init();
  }

  public void tick() {
    count++;
    if (count < 4) return;

    count = 0;
    for ( int i=0; i<8; i++) { 
      tiles[min(7, px)][i] = 255;
    }
    
    if ( px >=  8 && tiles[7][7] != 0) {
      init();
    } else {
      px += 1;
    }
  }


  public void init() {
    px = 0;
    for ( int x = 0; x < 8; x++ ) {
      for ( int y = 0; y< 8; y++) {
        tiles[x][y] = 0;
      }
    }
  }
  
  public void setActive( boolean active ) {
  }
}

