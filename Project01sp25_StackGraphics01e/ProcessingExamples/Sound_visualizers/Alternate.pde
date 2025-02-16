public class Alternate implements Visualizer {
  
  int p = 1;
  int count = 0;
  
  public Alternate() {    
    init();
  }

  public void tick() {
    count ++;
    if ( count < 4 ) return;
    
    count =0;
    if ( p == 1 ) { p = 0; } else { p = 1; }
      for ( int x = 0; x < 8; x++ ) {
        for ( int y = 0; y< 8; y++) {
          tiles[x][y] = 255 * ( (x+y+p) % 2 );
        }
      }
  }
  
  public void init() {
      for ( int x = 0; x < 8; x++ ) {
        for ( int y = 0; y< 8; y++) {
          tiles[x][y] = 0;
        }
      }
  }
  
  public void setActive( boolean active ) {
  }
}

