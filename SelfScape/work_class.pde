class place {
  //shitty named location variables
  int    placeX, placeY;
  float  placeW;
  float  placeH;
  color  placeMood;
  //won't need these rn
  //  ArrayList<agent> agents;
  //  int agentCount;

  place( int _x, int _y) {
    placeX = _x;
    placeY = _y;
    placeW = random((buildingSize/4)*3, buildingSize);
    placeH = random((buildingSize/4)*3, buildingSize);
    placeMood = color(random(255), random(255), random(140));
  }

  void display() {
    rectMode(CENTER);
    fill(placeMood);
    rect(placeX, placeY, placeW, placeH);
  }
}

class work extends place {

  work( int _x, int _y) {
    super(_x, _y);
    placeW = buildingSize*1.2;
    placeH = buildingSize*1.2;
    placeMood = color(88, 87, 75, 100);
  }
}

class school extends place {

  school( int _x, int _y) {
    super(_x, _y);
    placeH = buildingSize;
    placeW = buildingSize*1.5;
    placeMood = color(0, 101, 169, 100);
  }
}