//Boards are the subwindows of the sketch (Canvas, Frames and Gallery, its basically a rectangle)
class Board {
  //variables because its a rectangle
  int cX, cY, cWidth, cHeight;
  color boardCol;

  Board(int tempX, int tempY, int tempW, int tempH) {
    cX = tempX;
    cY = tempY;
    cWidth = tempW;
    cHeight = tempH;
    boardCol = factoryCol;
  }

  void display() {
    rectMode(CORNER);
    fill(boardCol);
    stroke(0);
    strokeWeight(1);
    rect(cX, cY, cWidth, cHeight);
  }
}

class canvas extends Board {
  //variables because its a rectangle
  int cX, cY, cWidth, cHeight;

  canvas(int tempX, int tempY, int tempW, int tempH) {
    super(tempX, tempY, tempW, tempH);
    boardCol =canvasCol;
  }

  void capture() {
    PImage img  =get(factoryWall, 0, canvasLimit, height/2);
    img.save(galleryPath + fileName + ".jpg");
    //inWhichPileSingleFile(fileName + ".jpg");
    imageNames.add(fileName+ ".jpg");
  }
}

class frame extends Board {

  frame(int tempX, int tempY, int tempW, int tempH) {
    super(tempX, tempY, tempW, tempH);
    boardCol = 0;
  }
}

class gallery extends Board {

  gallery(int tempX, int tempY, int tempW, int tempH) {
    super(tempX, tempY, tempW, tempH);
  }
}