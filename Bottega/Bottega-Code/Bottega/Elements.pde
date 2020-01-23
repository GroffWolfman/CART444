//these are the main point of the project, these elements will be displayed on the canvas as art created by the workers
abstract class Element {
  float x;
  float y;
  color elemColor;
  float workerAllowance;
  String type;

  //the elements take on attributes based on the workers at the moment of creation
  Element( float locationX, float workerHappyY, float workerHappyRange, color workerColor ) {
    workerAllowance = workerHappyRange;
    //take the current worker position and correspond it to an x location on the canvas
    x = locationX;
    //x = map(workerY, canvasMinY, canvasMaxY, 0, (canvasMaxY-canvasMinY)) + random(- workerAllowance/3, workerAllowance/3);
    y = workerHappyY + random(- workerAllowance/2, workerAllowance/2);
    y = constrain(y, 0+50, height - 50) + random (-height/8, height/8);
    workerAllowance = constrain(workerHappyRange, 0, 20);

    elemColor = color(workerColor, 100);
  }

  abstract void display() ;
}

class Dot extends Element {
  float dotHeight;
  float dotWidth;
  //take an arg for which worker dropped it
  Dot(float locationX, float workerHappyY, float workerHappyRange, color workerColor) {
    super( locationX, workerHappyY, workerHappyRange, workerColor);
    dotHeight = (random(workerAllowance/2, workerAllowance));
    dotWidth = (random(workerAllowance/2, workerAllowance));
    type = "Dot";
  }

  void display() {
    fill(elemColor);
    strokeWeight(0);
    stroke(elemColor);
    //the dot element is an ellipse
    ellipse(x, y, dotWidth, dotHeight);
  }
}

class SplatterDot extends Dot {
  int levelValue; 
  float lineEndX;
  float lineEndY;


  SplatterDot(float locationX, float workerHappyY, float workerHappyRange, color workerColor) {
    super( locationX, workerHappyY, workerHappyRange, workerColor);
    lineEndX = x + random(-workerAllowance, workerAllowance);
    lineEndY = y + random(-workerAllowance, workerAllowance);
    levelValue = int(random(2, 4));
    elemColor = color(workerColor, 100);
    type = "SplatterDot";
  }

  void display() {
    workerAllowance = constrain(workerAllowance, 10, 50);
    strokeWeight(0);
    stroke(elemColor, 100);
    if (levelValue > 1) {
      addDot(levelValue);
      levelValue --;
    }
  }

  void addDot(int level) {
    if (level > 1) {
      ImageElements.add(new Dot(x - (random(10)-level), y, workerAllowance - (random(10)-level), elemColor));
      level--;
      addDot(level);
    }
  }
}
// --------------------------------------------- Line ----------------------------------------------------- //
class Line extends Element {
  float lineEndX;
  float lineEndY;

  Line(float locationX, float workerHappyY, float workerHappyRange, color workerColor) {
    super( locationX, workerHappyY, workerHappyRange, workerColor);
    lineEndX = x + random(-workerAllowance, workerAllowance);
    lineEndY = y + random(-workerAllowance, workerAllowance);
    type = "Line";
  }

  void display() {
    workerAllowance = constrain(workerAllowance, 10, 50);
    strokeWeight(workerAllowance);
    stroke(elemColor);
    //Line element is a diagonal line
    line(x, y, lineEndX, lineEndY);
  }
}

class SplatterLine extends Line {
  int levelValue; 
  float lineEndX;
  float lineEndY;


  SplatterLine(float locationX, float workerHappyY, float workerHappyRange, color workerColor) {
    super( locationX, workerHappyY, workerHappyRange, workerColor);
    lineEndX = x + random(-workerAllowance, workerAllowance);
    lineEndY = y + random(-workerAllowance, workerAllowance);
    levelValue = int(random(2, 4));
    type = "SplatterLine";
  }

  void display() {
    workerAllowance = constrain(workerAllowance, 10, 50);
    strokeWeight(workerAllowance);
    stroke(elemColor);
    //Line element is a diagonal line
    if (levelValue > 1) {
      addLine(levelValue);
      levelValue --;
    }
  }

  void addLine(int level) {
    if (level > 1) {
      ImageElements.add(new Line(x, y, workerAllowance - (random(10)-level), elemColor));
      level--;
      addLine(level);
    }
  }
}

// --------------------------------------------- Box ----------------------------------------------------- //

class Box extends Element {
  float rotateValue; 

  Box(float locationX, float workerHappyY, float workerHappyRange, color workerColor) {
    super( locationX, workerHappyY, workerHappyRange, workerColor);
    rotateValue = random(-0.1, 0.1);
    type = "Box";
  }

  void display() {
    workerAllowance = constrain(workerAllowance, 5, 150);
    strokeWeight(0);
    stroke(elemColor);
    fill(elemColor);
    rectMode(CENTER);
    pushMatrix();
    rotate(rotateValue);
    rect(x, y, workerAllowance, workerAllowance);
    popMatrix();
  }
}

class SplatterBox extends Box {
  int levelValue; 
  float change;

  SplatterBox(float locationX, float workerHappyY, float workerHappyRange, color workerColor) {
    super( locationX, workerHappyY, workerHappyRange, workerColor);
    levelValue = int(random(4, 6));
    change = workerAllowance;
    type = "SplatterBox";
  }

  void display() {
    stroke(elemColor);
    fill(elemColor);
    addBox(levelValue);
    levelValue--;
  }


  void addBox(int level) {
    if (level > 1) {
      if (random(3)<1) {
        ImageElements.add(new Box(x, y, workerAllowance/2 - (random(10)-level), elemColor));
      } else {
        ImageElements.add(new Box(x +(workerAllowance/2- ((random(10)-level)*2)), y, workerAllowance/2, elemColor));
      }
      level--;
      addBox(level);
    }
  }
}