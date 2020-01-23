//Likely to change general behavior of workers from now, maybe not the "happy" class as the sporadic nature  //<>// //<>// //<>// //<>// //<>// //<>// //<>//
//these are the artists, the movement they take shapes the art piece as do their general programming

//Worker sizes based on worker type
int happySize = 8;
int baseSize  = 10;
int wanderSize= 13;
int slowSize  = 16;

abstract class Worker {
  //this is a nicer way to accomplish a speed test
  int baseDuration = workTimer;
  //basic attributes for workers
  PVector position;
  float moveSpeed;
  float workDuration;
  color workerColor;
  //a color randomizer to get a color out of a short list for each species
  float colorRng;
  float workerSize;
  // this workers preferred bin, which will be set an initialization
  PVector targetBin;
  //Bin and Vector variables
  String prefType;
  Bin grabBin;
  PVector toBin;
  PVector toCanvasTarget;
  boolean isCarry = false;
  String  carryObj;
  boolean working = true;
  PVector canvasTarget;
  PVector toExitTarget;

  //x and y coordinates relating to the canvas
  float happyYPos;
  //a range to choose from so not every element is in the exact same place
  float hpyRange;

  //generic buffer for edges
  int buffer = 3;
  //x variables so the worker groups in a chosen part of the canvas
  float minCanvasX;
  float maxCanvasX;
  float midPointCanvas;
  //NEED REAL VALUES
  float realCanvasMinX;
  float realCanvasMaxX;
  //Lower Limit
  float lowerLimit = height/2 - (buffer*2);

  //length of the canvas to be used in calculations



  Worker() {    
    position = new PVector(factoryWall/2, height);
    toBin    = new PVector(0, 0);
    toCanvasTarget = new PVector(0, 0);
    chooseNewBin();
    //take note of one specific type of bin this worker will be more likely to use
    prefType = bins[floor(random((binNumber)))].type;
    // prefered locations on pseudo canvas
    minCanvasX = random(canvasMaxY + buffer, height/2);
    maxCanvasX = random(height/2, canvasMinY - buffer);
    //MidPoint calcuation I guess
    midPointCanvas = (canvasLimit - factoryWall)/2;
    //calculate the horizontal range in which the worker will work
    realCanvasMinX = map(minCanvasX, canvasMinY, canvasMaxY, factoryWall, canvasLimit);
    realCanvasMinX = map(maxCanvasX, canvasMinY, canvasMaxY, factoryWall, canvasLimit);
    working = true;
  }

  //a move function, picking new bins and targets on canvas as it goes
  void move() {
    if (!isCarry) {
      toBin = PVector.sub(targetBin, position);
      toBin.normalize();
      toBin.mult(moveSpeed);
      position.add(toBin);
    } else {
      toCanvasTarget = PVector.sub(canvasTarget, position);
      toCanvasTarget.normalize();
      toCanvasTarget.mult(moveSpeed);
      position.add(toCanvasTarget);
    }

    if (position.x <= bins[0].binWidth ) {
      isCarry = true;
      for (int i = 0; i < bins.length; i++) {
        getItem(bins[i]);
      }
      //go to a different spot on the canvas horizontally
      canvasTarget.y = random(minCanvasX, maxCanvasX);
    } else if (position.x >= factoryWall-canvasWidth/2-workerSize/2) {
      // put it on the canvas
      addElement();
      //not carrying anything anymore
      isCarry = false;
      carryObj = null;

      //change new bin to head to once youve deposited the element
      chooseNewBin();
    }
  }
  // a system to check for bins and pick one at random (for now)
  void chooseNewBin() {
    grabBin = bins[floor(random((binNumber)))];
    if (grabBin.type != prefType) { 
      grabBin = bins[floor(random((binNumber)))];
    }
    targetBin  = new PVector(grabBin.x, grabBin.y);
  }
  //this is the main control for the worker, basing lots of actions based whether or not it is "working" or not
  void update() {
    endWork();
    if (working) {
      move();
    } else {
      leave();
    }
  }

  //temp function for checking to see if worker should still be working
  void endWork() {
    if (workDuration + startCount <= frameCount  && isCarry == false) {
      working = false;
    } else {

      working = true;
    }
  }

  //what to do when worker finishes working
  void leave() {
    if (working != true) {
      toExitTarget = PVector.sub(exit, position);
      toExitTarget.normalize();
      toExitTarget.mult(moveSpeed);
      position.add(toExitTarget);
    }
  }

  //present worker unit on the screen
  void display() {
    strokeWeight(1);
    stroke(0);
    fill(workerColor);
    ellipse(position.x, position.y, workerSize, workerSize);
  }

  //when within a range of the bin, grab the type from the bin
  void getItem(Bin b) {
    if (b.y <= position.y + workerSize*2 && b.y >= position.y - workerSize*2) {
      if (b.x <= position.x + workerSize*2 && b.x >= position.x - workerSize*2) {
        carryObj = b.type;
      }
    }
  }

  //this is important! 
  //when worker meets the canvas, place the item being held onto the canvas
  void addElement() {
    float elementX = map(position.y, canvasMinY, canvasMaxY, factoryWall, width);
    elementX  = constrain(elementX, factoryWall, factoryWall+(canvasLimit));

    if (carryObj == "Splatter") {
      //(float workerY, float workerHappyY, float workerHappyRange, color workerColor)
      ImageElements.add(new Splatter(elementX, happyYPos, distributeNearHappyY(), workerColor));
    }

    if (carryObj == "Splatter Line") {
      //(float workerY, float workerHappyY, float workerHappyRange, color workerColor)
      ImageElements.add(new SplatterLine(elementX, distributeNearHappyY(), hpyRange, workerColor));
    }
    if (carryObj == "Splatter Dot") {
      //(float workerY, float workerHappyY, float workerHappyRange, color workerColor)
      ImageElements.add(new SplatterDot(elementX, happyYPos, hpyRange, workerColor));
    }
    if (carryObj == "Splatter Box") {
      //(float workerY, float workerHappyY, float workerHappyRange, color workerColor)
      ImageElements.add(new SplatterBox(elementX, happyYPos, hpyRange, workerColor));
    }
    if (carryObj == "Line") {
      //(float workerY, float workerHappyY, float workerHappyRange, color workerColor)
      ImageElements.add(new Line(elementX, happyYPos, hpyRange, workerColor));
    }
    if (carryObj == "Dot") {
      //(float workerY, float workerHappyY, float workerHappyRange, color workerColor)
      ImageElements.add(new Dot(elementX, happyYPos, hpyRange, workerColor));
    }
    if (carryObj == "Box") {
      //(float workerY, float workerHappyY, float workerHappyRange, color workerColor)
      ImageElements.add(new Box(elementX, happyYPos, hpyRange, workerColor));
    }
  }

  float distributeNearHappyY() {
    float tempHpyY;
    return tempHpyY = random((hpyRange*.75), (hpyRange*1.25));
  }
}

class Happy extends Worker {
  Happy() {
    ///  ---------------------------------------------
    /*colorRng = ceil(random(3));
     if (colorRng <= 1) {
     workerColor = color(103, 146, 103);
     } else if (colorRng <= 2) {
     workerColor = color(255, 223, 0);
     } else if (colorRng <= 3) {
     workerColor = color(255, 185, 36);
     }
     */
    workerColor = colors[floor(random(colors.length))];
    ///  --------------------------------------------
    workerSize = happySize;
    moveSpeed = random(4, 5);
    workDuration = baseDuration + (random(-200, 200));

    canvasTarget = new PVector(factoryWall, height/2);

    //testing a happy place
    hpyRange  = random(100);
    happyYPos = random(buffer, lowerLimit);
  }
}

class SlowNSteady extends Worker {


  SlowNSteady() {
    ///  ---------------------------------------------
    /*colorRng = ceil(random(3));
     if (colorRng <= 1) {
     workerColor = color(103, 146, 103);
     } else if (colorRng <= 2) {
     workerColor = color(106, 125, 125);
     } else if (colorRng <= 3) {
     workerColor = color(124, 105, 64);
     }
     */
    workerColor = colors[floor(random(colors.length))];
    ///  --------------------------------------------
    workerSize = slowSize;
    moveSpeed = random(2, 3);
    workDuration = baseDuration + baseDuration/10 + (random(-200, 10));


    canvasTarget = new PVector(factoryWall, height/2);

    hpyRange  = random(50, 175);
    happyYPos = random(height/8, height/2);
  }
}

class Base extends Worker {

  Base() {
    ///  ---------------------------------------------
    /*
    colorRng = ceil(random(3));
     if (colorRng <= 1) {
     workerColor = color(119, 136, 153);
     } else if (colorRng <= 2) {
     workerColor = color(175, 238, 238);
     } else if (colorRng <= 3) {
     workerColor = color(199, 199, 180);
     }
     */
    workerColor = colors[floor(random(colors.length))];

    ///  ---------------------------------------------
    workerSize = baseSize;
    moveSpeed = random(3, 4);
    workDuration = baseDuration - baseDuration/5 + (random(-200, 200));


    toCanvasTarget = new PVector(0, 0);
    toExitTarget   = new PVector(0, 0);

    hpyRange  = random(10);
    happyYPos = random(height/4, height/2);

    canvasTarget = new PVector(factoryWall, height/2);
  }
}

class Wander extends Worker {

  Wander() {
    ///  ---------------------------------------------

    /* Screw the old ways for color
     colorRng = ceil(random(3));
     if (colorRng == 1) {
     workerColor = color(236, 171, 212);
     } else if (colorRng == 2) {
     workerColor = color(137, 215, 240);
     } else if (colorRng == 3) {
     workerColor = color(34, 205, 104);
     }
     */
    workerColor = colors[floor(random(colors.length))];
    ///  ---------------------------------------------
    workerSize = wanderSize;
    moveSpeed = random(1, 5);
    workDuration = baseDuration - baseDuration/5 + (random(-800, 800));

    toCanvasTarget = new PVector(0, 0);
    toExitTarget   = new PVector(0, 0);

    hpyRange  = random(50);
    happyYPos = random(0, height/2);

    canvasTarget = new PVector(factoryWall, height/2);
  }
}