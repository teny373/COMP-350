class PolygonCollection {
  String filePath;
  ArrayList<ArrayList<PVector>> polygons; 
  ArrayList<Integer> polygonColors; 

  PolygonCollection(String filePath) {
    this.filePath = filePath;
    polygons = new ArrayList<ArrayList<PVector>>();
    polygonColors = new ArrayList<Integer>();
    loadPolygons();
  }
  
  void loadPolygons() {
    String[] lines = loadStrings(filePath);
    ArrayList<PVector> currentPolygon = null;
    Integer currentColor = null;
    for (int i = 0; i < lines.length; i++) {
      String line = trim(lines[i]);
      if (line.startsWith("Polygon")) {
        if (currentPolygon != null && currentPolygon.size() > 0) {
          if (currentColor == null) { 
            currentColor = color(random(255), random(255), random(255));
          }
          polygons.add(currentPolygon);
          polygonColors.add(currentColor);
        }
        currentPolygon = new ArrayList<PVector>();
        currentColor = null;
        if (i + 1 < lines.length) {
          String nextLine = trim(lines[i + 1]);
          if (nextLine.startsWith("rgb(")) {
            nextLine = nextLine.substring(4, nextLine.length() - 1);
            String[] rgbValues = split(nextLine, ",");
            if (rgbValues != null && rgbValues.length == 3) {
              int r = int(trim(rgbValues[0]));
              int g = int(trim(rgbValues[1]));
              int b = int(trim(rgbValues[2]));
              currentColor = color(r, g, b);
            }
            i++; // Skip the color line
          }
        }
      }
      else if (line.length() == 0) {
        if (currentPolygon != null && currentPolygon.size() > 0) {
          if (currentColor == null) { 
            currentColor = color(random(255), random(255), random(255));
          }
          polygons.add(currentPolygon);
          polygonColors.add(currentColor);
          currentPolygon = null;
          currentColor = null;
        }
      }
      else {
        String[] parts = split(line, ",");
        if (parts != null && parts.length == 2) {
          float x = float(trim(parts[0]));
          float y = float(trim(parts[1]));
          if (currentPolygon == null) {
            currentPolygon = new ArrayList<PVector>();
          }
          currentPolygon.add(new PVector(x, y));
        }
      }
    }
    if (currentPolygon != null && currentPolygon.size() > 0) {
      if (currentColor == null) { 
        currentColor = color(random(255), random(255), random(255));
      }
      polygons.add(currentPolygon);
      polygonColors.add(currentColor);
    }
  }
  
  void drawPolygons() {
    for (int i = 0; i < polygons.size(); i++) {
      ArrayList<PVector> poly = polygons.get(i);
      fill(polygonColors.get(i));
      stroke(0);
      strokeWeight(1);
      beginShape();
      for (PVector v : poly) {
        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    }
  }
}
