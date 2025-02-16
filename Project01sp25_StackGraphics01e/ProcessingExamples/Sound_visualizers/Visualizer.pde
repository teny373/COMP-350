interface Visualizer {
  public int[][] tiles = new int[8][8];
  public void init();
  public void tick();
  public void setActive( boolean active );
}


