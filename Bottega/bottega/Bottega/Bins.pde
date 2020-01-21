//bins for factory
// Bins are basically rectangle containers for the String "type" and they allow it to have a visible presence 
class Bin {
  float x;
  float y;
  float fraction = 1/binNumber;
  int yMult;
  final float binWidth = 6;
  final float binHeight = 20;
  color binColor;
  String type;


  Bin(int yPosMultiplier) {
    x = binWidth/2;
    yMult = yPosMultiplier;
    y = firstBinY*yMult;
  }


  void display() {
    rectMode(CENTER);
    fill(binColor);
    stroke(0);
    strokeWeight(1);
    rect(x, y, binWidth, binHeight);
  }
}

class SplatterBin extends DotBin {
  //this bin will hold dot shapes
  SplatterBin(int yPosMultiplier) {
    super(yPosMultiplier);
    binColor =  color(12, 100, 255);
    type = "Splatter";
  }
}

//these bins hold Dot shapes in them
class DotBin extends Bin {
  //this bin will hold dot shapes
  DotBin(int yPosMultiplier) {
    super(yPosMultiplier);
    binColor =  color(12, 0, 255);
    type = "Dot";
  }
}

class SplatterDotBin extends DotBin {
  //this bin will hold dot shapes
  SplatterDotBin(int yPosMultiplier) {
    super(yPosMultiplier);
    binColor =  color(12, 100, 255);
    type = "Splatter Dot";
  }
}

//these bins hold Line shapes in them
class LineBin extends Bin {
  //this bin will hold line shapes
  LineBin(int yPosMultiplier) {
    super(yPosMultiplier);
    binColor = color(255, 128, 0);
    type = "Line";
  }
}

class SplatterLineBin extends LineBin {
  //this bin will hold line shapes
  SplatterLineBin(int yPosMultiplier) {
    super(yPosMultiplier);
    binColor = color(255, 128, 100);
    type = "Splatter Line";
  }
}

//these bins hold Box and SplatterBox shapes in them
class BoxBin extends Bin {
  //this bin will hold line shapes
  BoxBin(int yPosMultiplier) {
    super(yPosMultiplier);
    binColor = color(255, 128, 0);
    type = "Box";
  }
}

class SplatterBoxBin extends BoxBin {
  //this bin will hold line shapes
  SplatterBoxBin(int yPosMultiplier) {
    super(yPosMultiplier);
    binColor = color(255, 0, 100);
    type = "Splatter Box";
  }
}