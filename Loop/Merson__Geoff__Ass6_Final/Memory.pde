// ---- THE TAB FOR THE MEMORY OBJECTS AND RELATED FUNCTIONS ---- //

//the function that draws a background for the memory scene
void drawMemoryBack() { 
  //color it white and use the opacity variable
  fill(255, memBackOpacity);
  //draw it in the corner and make it fill the screen
  rect(0, 0, width, height);
  //if progress is equal to six
  if (progress == 6) {
    //increase the opacity
    memBackOpacity += 2;
  }
  if (memBackOpacity >= 255) {
    memBackOpacity = 255;
  }
  //if progress is greater than 6
  if (progress == 7) {
    //reduce the opacity
    memBackOpacity -= 3;
  }
}

//the function that initializes all the fragments
void setupMemory() {
  //walk through the array
  for (int i = 0; i < memoryRight.length; i++) {
    //set random starting positions off screen
    //one for the left
    float startX1 = random(-100, -50);
    //and another for the right
    float startX2 = random(width + 50, width + 100);
    //set a random y value
    float startY = random(height);
    //make every element in the arrays a fragment
    //and pass in location values and the i value,
    //which will be used to determine shape
    memoryRight[i] = new memFrag(startX1, startY, i);
    memoryLeft[i] = new memFrag(startX2, startY, i);
  }
}

//the function that calls the memFrag methods
void loseMemory() {
  //walk through the array but stop before it ends
  for (int i = 0; i < memoryRight.length - 1; i++) {
    //display the first fragment in the arrays
    memoryRight[0].display();
    memoryLeft[0].display();
    //make it move in and fade
    memoryRight[0].flyIn(); 
    memoryLeft[0].flyIn();
    //if the distance of the memFrag from the center is less than one, 
    if (dist(memoryRight[i].fragXPos[i], memoryRight[i].fragYPos[i], memoryRight[i].xTarget, memoryRight[i].yTarget) < 1) {
      //draw and launch launch the next ones
      memoryRight[i + 1].display();
      memoryRight[i + 1].flyIn();
      memoryLeft[i + 1].display();
      memoryLeft[i + 1].flyIn();
    }
    if (dist(memoryRight[5].fragXPos[5], memoryRight[5].fragYPos[5], memoryRight[5].xTarget, memoryRight[5].yTarget) < 5) {
      endMemory = true;
    }
  }
}

//the class for the memory fragments
class memFrag {
  // ---- PROPERTIES ---- //
  //a variable used to cycle through the switch cases
  int whichOne;
  //a variable for the opacity, set to full
  float fragOpacity = 255;
  //a variable to move the y position
  float ySpeed; 
  //a variable to make the shapes shrink
  float reduce;

  //TARGETING SYSTEM
  //a variable for the easing
  float easing;
  //a variable for the length of the following arrays
  int fragArrayMax = 6;
  //an array for the x position
  float[] fragXPos = new float[fragArrayMax];
  //an array for the y position
  float[] fragYPos = new float[fragArrayMax];
  //the targets for the fragments, in the center of the screen
  float xTarget = width / 2;
  float yTarget = height / 2;
  //arrays for the x and y directions of the fragments
  float[] xDirection = new float[fragArrayMax];
  float[] yDirection = new float[fragArrayMax];

  // ---- CONSTRUCTOR ---- //
  //takes variables for position and the i value, to determine the chosen case
  memFrag(float newX, float newY, int thatOne) {
    //assign a value to the easing
    easing = 0.025;
    //whichOne is used for the switch case, 
    //so this sets the case number to the i value passed down to thatOne
    whichOne = thatOne;
    //set the value of reduce, which will affect the speed at which the fragments shrink
    reduce = 2;

    //walk through the arrays
    for (int i = 0; i < fragArrayMax; i++) {
      // ---- INSPIRED BY BLINDFISH ---- //
      //map the position values passed to the constructor to the position array elements
      fragXPos[i] = newX;
      fragYPos[i] = newY;
      //assign positions and targets to their respective direction
      xDirection[i] = (xTarget - fragXPos[i]) * easing;
      yDirection[i] = (yTarget - fragYPos[i]) * easing;
      // ---- END OF REFERENCE ---- //
    }
  }

  // ---- METHODS ---- //
  //the function to display the memFrags
  void display() {  
    //remove the stroke
    noStroke();
    //set the color and opacity
    fill(#37ACF7, fragOpacity);
    //change the extent to which the fragments are reduced
    reduce -= 0.3;

    //a switch case that uses the whichOne value to cycle
    //each case is a specific fragment type, that uses the x and y position values
    //that were created in an array earlier
    switch(whichOne) {
    case 0:
      //#1
      float memFrag1X = fragXPos[0];
      float memFrag1Y = fragYPos[0];
      beginShape();
      vertex(memFrag1X, memFrag1Y);
      vertex(memFrag1X + 13 / reduce, memFrag1Y + 49 / reduce);
      vertex(memFrag1X + 37 / reduce, memFrag1Y + 64 / reduce);
      vertex(memFrag1X + 55 / reduce, memFrag1Y + 32 / reduce);
      vertex(memFrag1X + 43 / reduce, memFrag1Y + 8 / reduce);
      endShape(CLOSE);
      break;

    case 1:
      //#2
      float memFrag2X = fragXPos[1];
      float memFrag2Y = fragYPos[1];
      beginShape();
      vertex(memFrag2X, memFrag2Y);
      vertex(memFrag2X - 7 / reduce, memFrag2Y + 33 / reduce);
      vertex(memFrag2X + 41 / reduce, memFrag2Y + 51 / reduce);
      vertex(memFrag2X + 36 / reduce, memFrag2Y + 21 / reduce);
      vertex(memFrag2X + 24 / reduce, memFrag2Y - 9 / reduce);
      endShape(CLOSE);
      break;

    case 2:
      //#3
      float memFrag3X = fragXPos[2];
      float memFrag3Y = fragYPos[2];
      beginShape();
      vertex(memFrag3X, memFrag3Y);
      vertex(memFrag3X + 5 / reduce, memFrag3Y + 38 / reduce);
      vertex(memFrag3X + 51 / reduce, memFrag3Y + 48 / reduce);
      vertex(memFrag3X + 31 / reduce, memFrag3Y + 29 / reduce);
      vertex(memFrag3X + 19 / reduce, memFrag3Y + 24 / reduce);
      endShape(CLOSE);
      break;

    case 3:
      //#4
      float memFrag4X = fragXPos[3];
      float memFrag4Y = fragYPos[3];
      quad(memFrag4X, memFrag4Y, memFrag4X - 22 / reduce, memFrag4Y + 52 / reduce, memFrag4X + 18 / reduce, memFrag4Y + 43 / reduce, memFrag4X + 28 / reduce, memFrag4Y - 20 / reduce);      
      break;

    case 4:
      //#5
      float memFrag5X = fragXPos[4];
      float memFrag5Y = fragYPos[4];
      quad(memFrag5X, memFrag5Y, memFrag5X - 22 / reduce, memFrag5Y + 53 / reduce, memFrag5X + 9 / reduce, memFrag5Y + 20 / reduce, memFrag5X + 32 / reduce, memFrag5Y - 19 / reduce);
      break;

    case 5:
      //#6
      float memFrag6X = fragXPos[5];
      float memFrag6Y = fragYPos[5];
      triangle(memFrag6X, memFrag6Y, memFrag6X + 48 / reduce, memFrag6Y + 62 / reduce, memFrag6X + 41 / reduce, memFrag6Y + 16 / reduce);
      break;

    case 6:
      //#7
      float memFrag7X = fragXPos[6];
      float memFrag7Y = fragYPos[6];
      triangle(memFrag7X, memFrag7Y, memFrag7X + 30 / reduce, memFrag7Y + 39 / reduce, memFrag7X + 36 / reduce, memFrag7Y / reduce);
      break;
    }
  }

  //the function that makes the fragments move and fade
  void flyIn() {
    //reduce the opacity
    fragOpacity -= 3;
    //walk through the array
    for (int i = 0; i < fragArrayMax; i++) {
      //move the x and y positions with their respective directions
      fragXPos[i] += xDirection[i] * 0.5;
      fragYPos[i] += yDirection[i] / 2;
      //if the fragments near the center of the canvas,
      if (dist(fragXPos[i], fragYPos[i], xTarget, yTarget) < 1) {
        //set the directions to 0 to stop movement
        xDirection[i] = 0;
        yDirection[i] = 0;
      }
    }
  }
}

