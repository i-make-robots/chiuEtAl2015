class WangTiles {
  int NUM_POINTS = 20000;
  
  
  // VARIABLES
  
  ArrayList<Point2D> pointsOut;
  
  
  // METHODS
  
  WangTiles(int arg0) {
    NUM_POINTS = arg0;
  }
  
  void prepare() {
    pointsOut = new ArrayList<Point2D>();
    
    File f = new File(sketchPath("wangTiles.txt"));
    if(f.exists()) {
      // read in the points from the file
      BufferedReader reader = createReader(sketchPath("wangTiles.txt"));
      String line = null;
      try {
        while ((line = reader.readLine()) != null) {
          String[] pieces = split(line, TAB);
          int x = int(pieces[0]);
          int y = int(pieces[1]);
          pointsOut.add(new Point2D(x, y));
        }
        reader.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    } else {
      // no file exists
      for(int j=0;j<NUM_POINTS;++j) {
        int x,y;
        do {
          x=1+(int)random(width-2);
          y=1+(int)random(height-2);
        } while( sampleLuminosity(x,y) < random(256) );
        //} while(sampleLuminosity(x,y)<(Math.pow(Math.random(),1.01)*256));
        pointsOut.add( new Point2D(x,y) );
      }
    }
  }
  
  void render() {
    strokeWeight(1);
    stroke(255,0,0);
    for(int j=0;j<NUM_POINTS;++j) {
      Point2D p = pointsOut.get(j);
      point(p.x,p.y);
    }
  }
  
  boolean step() {
    return false;
  }
  
  void finish() {
    PrintWriter output = createWriter(sketchPath("wangTiles.txt"));
    for( Point2D p : pointsOut ) {
      output.println(p.x+"\t"+p.y);
    }
    output.flush();
    output.close();
  }
}
