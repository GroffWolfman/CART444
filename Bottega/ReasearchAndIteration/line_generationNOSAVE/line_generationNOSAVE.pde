int frameWallX1, frameWallX2, frameWallY1, frameWallY2, frameWidth, frameHeight;

void setup() {
  size(400, 400);
  background(255);
  frameWallX1 = 0;
  frameWallX2 = width;
  frameWallY1 = 0;
  frameWallY2 = height;

  frameWidth = frameWallX2-frameWallX1;
  frameHeight = frameWallY2-frameWallY1;

  rect(frameWallX1, frameWallY1, frameWidth, frameHeight);

 float limit = random(8);
 for (int i =0; i < limit; i++){
  randomCrossingLine();
 }
}

void draw() {
  //background(255);

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