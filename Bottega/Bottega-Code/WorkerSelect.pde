class WorkerSelectModel {
  int    listLength= 5;
  ArrayList<Worker>  possibleW   = new ArrayList<Worker>();

  WorkerSelectModel() {
    possibleW  = populatePossible();
  }

  ArrayList<Worker> populatePossible() {

    ArrayList<Worker>  tempPossibles  = new ArrayList<Worker>();
    for (int j = 0; j < listLength; j++) {
      int rng = floor(random(0, 4));
      if (rng == 0) {
        tempPossibles.add(new Base());
      } else if (rng == 1) {
        tempPossibles.add(new Happy());
      } else if (rng == 2) {
        tempPossibles.add(new SlowNSteady());
      } else if (rng == 3) {
        tempPossibles.add(new Wander());
      }
    }
    return tempPossibles;
  }
}




class WorkerSelectView {
  WorkerSelectModel ourModel;
  ArrayList<SelectSquare>  squares  = new ArrayList<SelectSquare>();
  float goX = width/8 *   7;
  float goY = height/4  * 3.5;
  float goWidth = 65;
  float goHeight = 40;
  boolean goFlagged = false;

  WorkerSelectView(WorkerSelectModel _Model) {
    ourModel = _Model;
    squares();
  }

  void display() {
    fill(0);
    textSize(20);
    textAlign(LEFT);
    text("Highlight a Worker by clicking on them", 10, 40);
    text("Click again to select them", 10, 80);
    for (SelectSquare s : squares) {
      s.run();
    }
    if (WorkerList.size() >= 3) {
      fill(7, 237, 0);
      rectMode(CENTER);
      rect(goX, goY, goWidth, goHeight);
      fill(0);
      textAlign(LEFT);
      text("GO", goX - 15, goY + 8);
      text("Add more workers -or- press GO now", width/3, goY + 8);
    }
    checkCompletion();
  }

  void squares() {
    int workerCounter = 0;
    for (float x = width/6; x < width- 50; x += width/6) {
      Worker  tempW = ourModel.possibleW.get(workerCounter);
      squares.add(new SelectSquare(x, float(height/2), 100.00, tempW));
      workerCounter++;
    }
  }
  void mousePressed() {
    if (mouseX > goX - goWidth/2 && mouseX < goX + goWidth/2
      &&  mouseY > goY - goHeight/2 && mouseY < goY + goHeight/2) {
      goFlagged = true;
    }
  }

  void checkCompletion() {
    if  (goFlagged == true || WorkerList.size() >= 17) {
      listFinished = true;
      startCount = frameCount;
      //create the file name while the list is at its fullest
      fileName = fileName();
    }
  }
}

class SelectSquare {
  float xPos;
  float yPos;
  float size;
  color squareFill = color(255);
  boolean isClicked = false;
  Worker  workerShown;
  color wColor;
  float wSize;
  float wShowSize;

  SelectSquare(float _x, float _y, float _size, Worker occupant) {
    xPos =    _x;
    yPos =    _y;
    size = _size;
    workerShown = occupant;
  }

  void run() {
    activated();
    fill(squareFill);
    rectMode(CENTER);
    rect(xPos, yPos, size, size); 
    if (workerShown != null) {
      wSize  = workerShown.workerSize;
      wShowSize = wSize * 1.5;
      wColor = workerShown.workerColor;
      fill(wColor);
      ellipse(xPos, yPos, wShowSize, wShowSize);
    }
    if (isClicked) {
      String descriptor = "This Worker likes to use " + workerShown.prefType + " brushes";
      fill(0);
      rect(width/2, height/4 *3 - 8, descriptor.length()* 12, 25);
      textAlign(CENTER);
      fill(wColor);
      text(descriptor, width/2, height/4 * 3);
    }
  }

  void mousePressed() {
    if (mouseX > xPos - size/2 && mouseX < xPos + size/2
      &&  mouseY > yPos - size/2 && mouseY < yPos + size/2) {
      if (isClicked) {
        WorkerList.add(workerShown);
        model = new WorkerSelectModel(); 
        view  = new WorkerSelectView(model);
      }
      isClicked = true;
    } else {
      isClicked = false;
    }
  }
  void activated() {
    if (isClicked == true) {
      squareFill = color(200);
    } else {
      squareFill = color(255);
    }
  }
}