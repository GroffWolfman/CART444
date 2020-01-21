float shapeX, shapeY, shapeW, opacity, startingShapeW;
int frameWallX1, frameWallX2, frameWallY1, frameWallY2, frameWidth, frameHeight;

void setup() {

  size(750, 250);
  background(255);
  noStroke();

  //for the lines
  frameWallX1 = 0;
  frameWallX2 = width;
  frameWallY1 = 0;
  frameWallY2 = height;

  frameWidth = frameWallX2-frameWallX1;
  frameHeight = frameWallY2-frameWallY1;

  //For Solid splatter (very little opacity) ((YO THIS ONE IS GOOD THO))
  //opacity = 125;
  //for very light, watercoloury splatter
  opacity = 50;
  shapeX = width/2;
  shapeY = height/2;
  //starting shapeW is 75 for the purposes of the picture generation on its own.
  startingShapeW = 75;
  //find shapeW below after the ArrayList Poly is init.

  // Violet Colour fill(238, 130, 238, opacity);

  float limit = random(2, 4);
  for (int i =0; i < limit; i++) {
    randomCrossingLine();
  }
  for (int a = 0; a < 16; a++) {
    templateShape(random(width), (random(height)));
  }

  //the next two lines are great if you just want to spam art generation
  save(str(int(random(1000, 100000)))+ ".jpg");
  //exit();
}

void templateShape(float tempX, float tempY) {
  ArrayList<PVector> poly;
  shapeW = startingShapeW;
  noStroke();

  fill(random(100, 200), random(100, 200), random(100, 200), opacity);
  for ( int j = 0; j < (random(1, 5)); j++) {
    poly = create_base_poly(tempX, tempY, shapeW, int(random(8, 10)));
    beginShape();
    for (int i = 0; i < poly.size(); i++)
      vertex(poly.get(i).x, poly.get(i).y);
    endShape(CLOSE);

    tempX += random(-shapeW, shapeW);
    tempY += random(-shapeW, shapeW);
    shapeW -= j*2;
    //opacity -= j*2;
  }
}

ArrayList<PVector> rpoly(float x, float y, float r, int nsides) {
  ArrayList<PVector> points = new ArrayList<PVector>();
  float sx, sy;
  float angle = TWO_PI / nsides;

  /* Iterate over edges in a pairwise fashion. */
  for (float a = 0; a < TWO_PI; a += angle) {
    sx = x + cos(a) * r;
    sy = y + sin(a) * r;
    points.add(new PVector(sx, sy));
  }
  return points;
}

ArrayList<PVector> create_base_poly(float x, float y, 
  float r, int nsides) {
  ArrayList<PVector> bp;
  bp = rpoly(x, y, r, nsides);
  bp = deform(bp, 5, r/10, 2);
  return bp;
}

ArrayList<PVector> deform(ArrayList<PVector> points, int depth, 
  float variance, float vdiv) {

  float sx1, sy1, sx2 = 0, sy2 = 0;
  ArrayList<PVector> new_points = new ArrayList<PVector>();

  if (points.size() == 0)
    return new_points;

  /* Iterate over existing edges in a pairwise fashion. */
  for (int i = 0; i < points.size(); i++) {
    sx1 = points.get(i).x;
    sy1 = points.get(i).y;
    sx2 = points.get((i + 1) % points.size()).x;
    sy2 = points.get((i + 1) % points.size()).y;

    new_points.add(new PVector(sx1, sy1));
    subdivide(new_points, sx1, sy1, sx2, sy2, 
      depth, variance, vdiv);
  }

  return new_points;
}

/*
 * Recursively subdivide a line from (x1, y1) to (x2, y2) to a
 * given depth using a specified variance.
 */
void subdivide(ArrayList<PVector> new_points, 
  float x1, float y1, float x2, float y2, 
  int depth, float variance, float vdiv) {
  float midx, midy;
  float nx, ny;

  if (depth >= 0) {
    /* Find the midpoint of the two points comprising the edge */
    midx = (x1 + x2) / 2;
    midy = (y1 + y2) / 2;

    /* Move the midpoint by a Gaussian variance */
    nx = midx + randomGaussian() * variance;
    ny = midy + randomGaussian() * variance;

    /* Add two new edges which are recursively subdivided */
    subdivide(new_points, x1, y1, nx, ny, 
      depth - 1, variance/vdiv, vdiv);
    new_points.add(new PVector(nx, ny));
    subdivide(new_points, nx, ny, x2, y2, 
      depth - 1, variance/vdiv, vdiv);
  }
}

void randomCrossingLine() {
  float rng = random(0, 10);

  stroke(55, 0, 0);
  strokeWeight(15);
  if (rng < 5) {
    float startX = random(frameWallX1, frameWallX2);
    float endX = random(frameWallX1, frameWallX2);
    line(startX, frameWallY1, endX, frameWallY2);
  } else {
    float startY = random(frameWallY1, frameWallY2);
    float endY = random(frameWallY1, frameWallY2);
    line(frameWallX1, startY, frameWallX2, endY);
  }
}