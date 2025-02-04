class MousePolygon {
  boolean recording = false;
  boolean polygonDrawn = false;
  ArrayList<PVector> vertices;
  ArrayList<ArrayList<PVector>> drawnPolygons;

  MousePolygon() {
    vertices = new ArrayList<PVector>();
    drawnPolygons = new ArrayList<ArrayList<PVector>>();
  }
  
  void handleKey(char keyChar) {
    if (keyChar == '1') {
      vertices.clear();
      recording = true;
      polygonDrawn = false;
      println("Recording started. Click to add vertices.");
    }
    else if (keyChar == 'q' && recording) {
      recording = false;
      polygonDrawn = true;
      drawnPolygons.add(new ArrayList<PVector>(vertices));
      println("Recording stopped. Polygon vertices:");
      for (PVector v : vertices) {
        println("new PVector(" + v.x + ", " + v.y + ")");
      }
    }
    else if (keyChar == 'z') {
      if (!vertices.isEmpty()) {
        vertices.remove(vertices.size() - 1);
        println("Undo last vertex.");
      }
    }
    else if (keyChar == 's') {
      exportPolygons();
      println("Exported polygons to polygon_output.txt");
    }
  }
  
  void handleMouseClick(int mx, int my) {
    if (recording && !polygonDrawn) {
      vertices.add(new PVector(mx, my));
    }
  }
  
  void drawPolygon() {
    for (ArrayList<PVector> poly : drawnPolygons) {
      fill(poly.get(0).x % 255, poly.get(0).y % 255, 100);
      stroke(0);
      beginShape();
      for (PVector v : poly) {
        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    }
    
    if (!vertices.isEmpty() && !polygonDrawn) {
      fill(0);
      noStroke();
      for (PVector v : vertices) {
        ellipse(v.x, v.y, 5, 5);
      }
    }
  }
  
  void exportPolygons() {
    ArrayList<String> lines = new ArrayList<String>();
    int polyCount = 1;
    for (ArrayList<PVector> poly : drawnPolygons) {
      lines.add("Polygon " + polyCount + ":");
      for (PVector v : poly) {
        lines.add(v.x + ", " + v.y);
      }
      polyCount++;
      lines.add("");
    }
    if (!vertices.isEmpty() && !polygonDrawn) {
      lines.add("Current Polygon:");
      for (PVector v : vertices) {
        lines.add(v.x + ", " + v.y);
      }
      lines.add("");
    }
    String[] output = new String[lines.size()];
    output = lines.toArray(output);
    saveStrings("polygon_output.txt", output);
  }
}
