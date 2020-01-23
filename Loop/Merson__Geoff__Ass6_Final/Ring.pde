// ---- THE TAB FOR THE RING AND RELATED FUNCTIONS ---- //

//the function that draws a background for the ring scene
void drawRingBack() { 
  //color it grey and use the opacity variable
  fill(20, ringBackOpacity);
  //draw it in the corner and make it fill the screen
  rect(0, 0, width, height); 
  //if progress is greater or equal to one
  if (progress == 1) {
    //reduce the opacity
    ringBackOpacity -= 0.05;
  }
  //if the s7P3 textbox object's opacity is greater than 240,
  if (s7P3.opacity >= 240) {
    //increase the background opacity
    ringBackOpacity += 2;
  }
  //if the background opacity reaches the maximum
  if (ringBackOpacity >= 255) {
    //keep it there
    ringBackOpacity = 255;
  }
}

//the object for the ring
class Ring {
  //---- PROPERTIES ----//
  //variables for x and y position
  float ringGlobalX;
  float ringGlobalY;
  //variables for the size of the dots in each ring
  int dotOuterSize;
  int dotInnerSize;
  int dotCenterSize;

  //a variable used for the parametric equations used later
  float t;

  //flag whether or not the center has been reached
  boolean push = false;
  boolean advance = false;
  //a variable that makes the rings expand
  float expand;
  //a variable for easing
  float easing;
  //a variable that holds the distance between the mouse and the center
  float distance;
  //a variable used to determine the frequency of sine and cosine waves
  float frequency = 10;
  //a variable used to determine the amplitude of sine and cosine waves
  float amplitude = 200;
  //a cap for the amplitude that does not change
  float maxAmplitude = 200;

  //DOT
  //a variable for the array length
  int dotMax = 70;
  //an array of dots to make the rings
  Dot[] dotArray = new Dot[dotMax];

  //a variable that tracks how far we have moved through this scene
  float sceneProgress;

  //set the starting color to white
  color startFill = 255;
  //variables for the colors of the different rings
  color outFill;
  color midFill;
  color inFill;
  //variable to control the opacity of the dots, set to full
  float dotOpacity = 255;
  //set the final colors of the rings to shades of green
  color finalOut = color(#2A391F);
  color finalMid = color(#4B8620);
  color finalIn = color(#6D9242);

  //---- CONSTRUCTOR ----//
  //takes variables for position
  Ring(float xPos, float yPos) {
    //assign a value to easing
    easing = 0.025;
    //set the progress of the scene to zero at the start
    sceneProgress = 0;
    //set all the rings to white at the start
    outFill = midFill = inFill = startFill;

    //map the position variables from the constructor to the position properties
    ringGlobalX = xPos;
    ringGlobalY = yPos;

    //set the sizes for the rings
    dotOuterSize = width / (width / 10);
    dotInnerSize = width / (width / 5);
    dotCenterSize = width / (width / 2);

    //set the starting amplitude to 200
    amplitude = 200;
  }
  //---- METHODS ----//
  //the function to display the rings
  void display() {
    //walk through the array of dots
    for (int i = 0; i < dotArray.length; i++) {
      //initialize the outer ring using parametric equations to affect the position
      dotArray[i] = new Dot(dotOuterXPos(t) + ringGlobalX, dotOuterYPos(t) + ringGlobalY, dotOuterSize);
      //initialize the inner ring using parametric equations to affect the position
      //this ring is smaller, so it does not have as many dots as the array allows
      dotArray[i / 2] = new Dot(dotInnerXPos(t) + ringGlobalX, dotInnerYPos(t) + ringGlobalY, dotInnerSize);
      //initialize the center ring using parametric equations to affect the position
      //this ring is smaller, so it does not have as many dots as the array allows
      dotArray[i / 4] = new Dot(dotCenterXPos(t) + ringGlobalX, dotCenterYPos(t) + ringGlobalY, dotCenterSize);
      //set the color for the outer ring
      fill(outFill, dotOpacity);
      dotArray[i].display();
      //set the color for the inner ring
      fill(midFill, dotOpacity);
      dotArray[i / 2].display();
      //set the color for the center ring
      fill(inFill, dotOpacity);
      dotArray[i / 4].display();
      //increase t to affect the parametric equations
      t++;
      //if global progress is greater than 1
      if (progress >= 1) {
        //start reducing the opacity
        dotOpacity -= 0.015;
      }
    }
    //show the text for the introduction
    intro.showText();
    //if the scene progress is greater or equal to one,
    if (sceneProgress >= 1) {
      //set the color for the outer ring to green
      outFill = finalOut;
      //show the first line of text
      s1P1.showText();
    }
    //if the scene progress is greater or equal to two,
    if (sceneProgress >= 2) {
      //set the color for the inner ring to green
      midFill = finalMid;
      //show the second line of text
      s1P2.showText();
    }
    //if the scene progress is greater or equal to three,
    if (sceneProgress >= 3) {
      //set the color for the center ring to green
      inFill = finalIn;
      //show the third line of text
      s1P3.showText();
    }
    //if the scene progress is greater or equal to four,
    if (sceneProgress >= 4) {
      //show the fourth line of text
      s1P4.showText();
    }
  }

  //a function to animation the ring
  void breathe() {
    //a variable to confine the mouse's interaction with the rings to a smaller area
    int innerLimit = 180;
    //assign the distance between the mouse and the center to the distance variable
    distance = dist(mouseX, mouseY, centerX, centerY);
    //if the distance is less or equal to 50
    if (distance <= 50) {
      //set push to true
      push = true;
      //but if the amplitude is near the size of the maxAmplitude and the distance is between 179 and 215,
    } else if ((maxAmplitude - amplitude) < 3 && distance >= innerLimit-1 && distance <= 215) {
      //set push to false
      push = false;
      //set advance to true
      advance = true;
    } 
    //if advance is true and the amplitude is less than 179
    if (advance && amplitude < innerLimit) {
      //move the scene progress forward
      progress();
      //set advance to false
      advance = false;
    }
    //if push is true
    if (push) {
      //assign the difference between maxAmplitude and amplitude, multiplied by easing, to the expand variable
      expand = (maxAmplitude - amplitude) * easing;
      //increase amplitude with expand
      amplitude += expand;
      //otherwise,
    } else {
      //the amplitude should be equivalent to the distance
      amplitude = distance;
    }
  }

  //the function that makes the scene progress increase
  void progress() {
    //increase the scene progress by one
    sceneProgress += 1;
  }

  // ---- INSPIRED BY ALEXANDER MILLER ---- //
  //PARAMETRIC EQUATIONS
  //a function for the outer ring's x position
  float dotOuterXPos(float t) {
    //returns a value based on a sine function
    return sin(t / frequency) * amplitude;
  }
  //a function for the outer ring's y position
  float dotOuterYPos(float t) {
    //returns a value based on a cosine function
    return cos(t / frequency) * amplitude;
  }
  //a function for the inner ring's x position
  float dotInnerXPos(float t) {
    //returns a value based on a sine function with the amplitude made smaller
    return sin(t / frequency) * (amplitude / 2);
  }
  //a function for the inner ring's y position
  float dotInnerYPos(float t) {
    //returns a value based on a cosine function with the amplitude made smaller
    return cos(t / frequency) * (amplitude / 2);
  }
  //a function for the center ring's x position
  float dotCenterXPos(float t) {
    //returns a value based on a sine function with the amplitude made smaller again
    return sin(t / frequency) * (amplitude / 4);
  }
  //a function for the inner ring's y position
  float dotCenterYPos(float t) {
    //returns a value based on a cosine function with the amplitude made smaller again
    return cos(t / frequency) * (amplitude / 4);
  }
  // ---- END OF REFERENCE ---- //
}

//the class for the dot
class Dot {
  //---- PROPERTIES ----//
  //variables for the dot location
  float dotX;
  float dotY;
  //a variable for the opacity
  int dotOpacity;
  //a variable for the size
  int dotSize;

  //---- CONSTRUCTOR ----//
  //takes variables for position and size
  Dot(float xPos, float yPos, int size) {
    //map the values from the constructor to the appropriate properties
    dotX = xPos;
    dotY = yPos;
    dotSize = size;
    //set the opacity to full to start
    dotOpacity = 255;
  }

  //---- METHODS ----//
  //the function to display the dots
  void display() {
    //remove the stroke
    noStroke();
    //draw an ellipse at the assigned position using the assigned size
    ellipse(dotX, dotY, dotSize, dotSize);
  }

  //a function that updates the position of the dots
  void updatePos() {
    //set the new dot location to that of the mouse
    dotX = mouseX;
    dotY = mouseY;
  }
}

