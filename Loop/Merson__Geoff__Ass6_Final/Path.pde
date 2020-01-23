// ---- THE TAB FOR THE PATH OBJECTS AND FUNCTIONS ---- //

//a function that initializes the path objects
void setupPath() {
  //set a random x location
  float startX = random(150, 400);
  //set a random y location 
  float startY = random(height, height + 50); 
  //use a for loop to walk through the array
  for ( int i = 0; i < path.length; i++) {
    //create a fragment object for each element
    //and pass i into the constructor to determine the shape
    path[i] = new Fragment(startX, startY, i);
  }
}

//a function that displays and floats the path
void drawPath() {
  //walk through the array
  for ( int i = 0; i < path.length; i++) {
    //display each element
    path[i].display();
    //make each element move up to its target
    path[i].floatUp();
  }
}

//a function that makes the path objects start to fall
void fallPath() {
  //increase fallPos slowly so that the path does not fall too fast
  fallPos = fallPos + 0.075; 
  //if fallPos is still within the length of the array
  if (fallPos < path.length-1) {
    //because we're using a decimal value, round it to the nearest int
    //the element in the array that corresponds to that int will start to fall
    path[round(fallPos)].fall = true;
  }
}

//the class for the fragments
class Fragment {
  // ---- PROPERTIES ---- //
  //a variable used to cycle through the switch cases
  int whichOne;
  //a variable to move the fragments
  float ySpeed; 
  //a variable for the position of the fragments after they teleport to the top of the canvas
  float finalPos;

  //flag whether or not the pieces are falling
  boolean fall = false;

  //set the initial opacity to 0
  int fragOpacity = 0;
  //check if we've reached the end of the canvas
  boolean theresMore = false;
  //where do we stop
  float fallLimit = 250;
  //the colors for the fragments
  //they are split into two variables because some will be colored differently
  //in order to give a sense of depth
  color primaryColor;
  color secondaryColor;
  //since the colors change, this variables control which colors are being used at different times
  color currentFill1;
  color currentFill2;
  //color for the aurora fragments
  color auroraColor = color(60, 255, 100);

  //flag when the fragment has disappeared
  boolean gone = false;

  //TARGETING SYSTEM
  //make a variable for easing
  float easing;
  //set the length of the following arrays with the length of the path array
  int fragArrayMax = maxFragments;
  //create an array of floats for the fragment x positions
  float[] fragXPos = new float[fragArrayMax];
  //create an array of floats for the fragment y positions
  float[] fragYPos = new float[fragArrayMax];
  //flag whether or not the target has been reached
  boolean targetReached = false;
  //an offset to lower the fragments by their y
  int yOffset = 50;
  //an array of integers for the fragment x targets (where they will end up on screen)
  int[] xTargets = { 
    369, 347, 327, 350, 401, 303, 331, 433, 434, 415, 272, 289, 373, 392, 263, 288, 263, 331, 401, 403, 409
  }; 
  //an array of integers for the fragment y targets (where they will end up on screen)
  int[] yTargets = { 
    336 + yOffset, 335 + yOffset, 338 + yOffset, 341 + yOffset, 351 + yOffset, 345 + yOffset, 348 + yOffset, 366 + yOffset, 366 + yOffset, 371 + yOffset, 
    351 + yOffset, 389 + yOffset, 389 + yOffset, 411 + yOffset, 397 + yOffset, 383 + yOffset, 399 + yOffset, 422 + yOffset, 427 + yOffset, 425 + yOffset, 431 + yOffset
  };
  //an array to give each fragment an x direction to move in
  float[] xDirection = new float[fragArrayMax];
  //an array to give each fragment a y direction to move in
  float[] yDirection = new float[fragArrayMax];

  //PARTICLE
  //set a max for the particle array
  int maxParticle = 18;
  //make an array of particles
  Particle[][] parArray;
  //make a color for the particles
  color particleColor = color(44, 117, 255, 30);
  //create a float that will be used for incrementation later on
  float t;

  // ---- CONSTRUCTOR ---- //
  //pas in variables for position and shape (used in the switch case)
  Fragment(float newX, float newY, int thatOne) {
    //give easing a value
    easing = 0.025;
    //whichOne is used for the switch case, 
    //so this sets the case number to the i value passed down to thatOne
    whichOne = thatOne;
    //assign a random value to finalPos
    finalPos = random(width / 8, (width / 8) * 7);

    // ---- INSPIRED BY ADAM LASTOWKA ---- //
    //set the length and type for the particle array
    parArray = new Particle[maxParticle][maxParticle];
    //walk through the array
    for (int i = 0; i < parArray.length * parArray.length; i++) {
      //fill the array with particle objects
      parArray[i / parArray.length][i % parArray.length] = new Particle();
    }
    // ---- END OF REFERENCE ---- //

    //walk through the fragment arrays
    for (int i = 0; i < fragArrayMax; i++) {
      // ---- INSPIRED BY BLINDFISH ---- //
      //set the X and Y to random values passed into the constructor
      fragXPos[i] = newX;
      fragYPos[i] = newY;
      //give each direction variable a value based on the respective targets and positions
      //increment with easing
      xDirection[i] = (xTargets[i] - fragXPos[i]) * easing;
      yDirection[i] = (yTargets[i] - fragYPos[i]) * easing;
      // ---- END OF REFERENCE ---- //
    }
  }

  // ---- METHODS ---- //
  //the function to display the fragments
  void display() {
    //walk through the array  
    for (int i = 0; i < fragArrayMax; i++) { 
      //and if a fragment is marked as being gone
      if (gone) {
        //remove and update opacity
        fragOpacity = 0;
        //keep the auroraColor for all, even  if the opacity is at zero
        primaryColor = color(auroraColor, fragOpacity);       
        secondaryColor = color(auroraColor, fragOpacity);
        //set the current colors to the ones assigned above
        currentFill1 = color(primaryColor);
        currentFill2 = color(secondaryColor);
        //if the opacity is less than full... (a sign that the fragments have just been drawn)
      } else if (fragOpacity < 255) {
        //fade in the path
        fragOpacity += 2;
        //set the colors for the fragments and use the increasing opacity
        primaryColor = color(#C8372C, fragOpacity);
        secondaryColor = color(#832C2C, fragOpacity);
      }
      //if the y position is inferior to the limit set
      if (fragYPos[i] < fallLimit) {
        //change the color as the fragments fall
        //make then translucent
        currentFill1 = color(auroraColor, 50);
        currentFill2 = color(auroraColor, 50);
        //but if the y position is greater than the fallLimit
      } else if (fragYPos[i] >= fallLimit + 5) {
        //keep the original color and opacity
        currentFill1 = color(#C8372C, fragOpacity);
        currentFill2 = color(#832C2C, fragOpacity);
      }

      //set the stroke to one
      strokeWeight(1);
      //use the currentFill1 value to color both stroke and fill 
      stroke(currentFill1);
      fill(currentFill1);
      //starting at case 15, we will be using the currentFill2 value to do this
    }

    //a switch case that uses the whichOne value to cycle
    //each case is a specific fragment type, that uses the x and y position values
    //that were created in an array earlier
    switch(whichOne) {
    case 0:
      float frag1X = fragXPos[0];
      float frag1Y = fragYPos[0];
      triangle(frag1X, frag1Y, frag1X * 0.94, frag1Y * 0.99, frag1X * 1.02, frag1Y * 1.01);
      break;

    case 1:
      float frag2X = fragXPos[1];
      float frag2Y = fragYPos[1];
      quad(frag2X, frag2Y, frag2X * 0.94, frag2Y * 1.002, frag2X * 1.005, frag2Y * 1.014, frag2X * 1.1, frag2Y * 1.02);      
      break;

    case 2:
      float frag3X = fragXPos[2];
      float frag3Y = fragYPos[2];
      quad(frag3X, frag3Y, frag3X * 0.93, frag3Y * 1.014, frag3X * 1.09, frag3Y * 1.023, frag3X * 1.06, frag3Y * 1.008);
      break;

    case 3:
      float frag4X = fragXPos[3];
      float frag4Y = fragYPos[3];
      quad(frag4X, frag4Y, frag4X * 1.028, frag4Y * 1.017, frag4X * 1.137, frag4Y * 1.026, frag4X * 1.102, frag4Y * 1.008);
      break;

    case 4:
      float frag5X = fragXPos[4];
      float frag5Y = fragYPos[4];
      triangle(frag5X, frag5Y, frag5X * 0.807, frag5Y * 0.982, frag5X * 1.074, frag5Y * 1.034); 
      break;

    case 5:
      float frag6X = fragXPos[5];
      float frag6Y = fragYPos[5];
      quad(frag6X, frag6Y, frag6X * 0.9, frag6Y * 1.014, frag6X * 1.102, frag6Y * 1.031, frag6X * 1.085, frag6Y * 1.011); 
      break;

    case 6:
      float frag7X = fragXPos[6];
      float frag7Y = fragYPos[6];
      quad(frag7X, frag7Y, frag7X * 1.015, frag7Y * 1.022, frag7X * 1.23, frag7Y * 1.057, frag7X * 1.214, frag7Y * 1.037);       
      break;

    case 7:
      float frag8X = fragXPos[7];
      float frag8Y = fragYPos[7];
      quad(frag8X, frag8Y, frag8X * 0.93, frag8Y * 0.986, frag8X * 0.94, frag8Y * 1.01, frag8X * 0.961, frag8Y * 1.011);  
      break;

    case 8:
      float frag9X = fragXPos[8];
      float frag9Y = fragYPos[8];
      triangle(frag9X, frag9Y, frag9X * 0.96, frag9Y * 1.011, frag9X * 1.03, frag9Y * 1.112);      
      break;

    case 9:
      float frag10X = fragXPos[9];
      float frag10Y = fragYPos[9];
      quad(frag10X, frag10Y, frag10X * 0.838, frag10Y * 0.965, frag10X * 0.892, frag10Y * 1.035, frag10X * 1.07, frag10Y * 1.097);      
      break;

    case 10:
      float frag11X = fragXPos[10];
      float frag11Y = fragYPos[10];
      quad(frag11X, frag11Y, frag11X * 0.967, frag11Y * 1.079, frag11X * 1.37, frag11Y * 1.12, frag11X * 1.272, frag11Y * 1.02);      
      break;

    case 11:
      float frag12X = fragXPos[11];
      float frag12Y = fragYPos[11];
      quad(frag12X, frag12Y, frag12X * 0.906, frag12Y * 1.017, frag12X * 1.387, frag12Y * 1.09, frag12X * 1.304, frag12Y * 1.013);  
      break;

    case 12:
      float frag13X = fragXPos[12];
      float frag13Y = fragYPos[12];
      triangle(frag13X, frag13Y, frag13X * 1.05, frag13Y * 1.05, frag13X * 1.185, frag13Y * 1.05);      
      break;

    case 13:
      float frag14X = fragXPos[13];
      float frag14Y = fragYPos[13];
      quad(frag14X, frag14Y, frag14X * 1.038, frag14Y * 1.044, frag14X * 1.138, frag14Y * 0.995, frag14X * 1.089, frag14Y);      
      break;

    case 14:
      float frag15X = fragXPos[14];
      float frag15Y = fragYPos[14];
      triangle(frag15X, frag15Y, frag15X * 1.255, frag15Y * 1.058, frag15X * 1.517, frag15Y * 1.071);
      break;

    case 15:
      stroke(currentFill2);
      fill(currentFill2);
      float frag16X = fragXPos[15];
      float frag16Y = fragYPos[15];
      triangle(frag16X, frag16Y, frag16X * 0.913, frag16Y * 0.989, frag16X * 0.924, frag16Y * 1.026);
      break;

    case 16:
      stroke(currentFill2);
      fill(currentFill2);
      float frag17X = fragXPos[16];
      float frag17Y = fragYPos[16];
      triangle(frag17X, frag17Y, frag17X * 1.247, frag17Y * 1.17, frag17X * 1.247, frag17Y * 1.057);      
      break;

    case 17:
      stroke(currentFill2);
      fill(currentFill2);
      float frag18X = fragXPos[17];
      float frag18Y = fragYPos[17];
      triangle(frag18X, frag18Y, frag18X, frag18Y * 1.097, frag18X * 1.199, frag18Y * 1.012);
      break;

    case 18:
      stroke(currentFill2);
      fill(currentFill2);
      float frag19X = fragXPos[18];
      float frag19Y = fragYPos[18];
      triangle(frag19X, frag19Y, frag19X * 0.93, frag19Y * 1.037, frag19X * 0.965, frag19Y * 1.077);      
      break;

    case 19:
      stroke(currentFill2);
      fill(currentFill2);
      float frag20X = fragXPos[19];
      float frag20Y = fragYPos[19];
      quad(frag20X, frag20Y, frag20X * 0.977, frag20Y * 1.054, frag20X * 1.009, frag20Y * 1.047, frag20X * 1.009, frag20Y * 1.014);      
      break;

    case 20:
      stroke(currentFill2);
      fill(currentFill2);
      float frag21X = fragXPos[20];
      float frag21Y = fragYPos[20];
      quad(frag21X, frag21Y, frag21X, frag21Y * 1.05, frag21X * 1.08, frag21Y * 1.013, frag21X * 1.09, frag21Y * 0.95);
      break;
    }
    //call the reachTop function
    reachTop();
    //call the fallDown function
    fallDown();
  }

  //the function that makes the fragments float up at the beginning
  void floatUp() {
    //walk through the array
    for (int i = 0; i < fragArrayMax; i++) {
      //assign each position value a direction
      fragXPos[i] += xDirection[i];
      fragYPos[i] += yDirection[i];
      //if the distance between the current position and the target is less than one
      if (dist(fragXPos[i], fragYPos[i], xTargets[i], yTargets[i]) < 1) {
        //stop the movement
        xDirection[i] = 0;
        yDirection[i] = 0;
        //tell the sketch that the target has been reached
        targetReached = true;
      }
    }
  }

  //the function that makes the fragments fall
  void fallDown() {
    //if fall is true
    if (fall) {
      //set the speed of the y to 1.5
      ySpeed = 1.5;
      //if not,
    } else {
      //the y will not move
      ySpeed = 0;
    }
    //walk through the array
    for (int i = 0; i < fragArrayMax; i++) {
      //increase each y position with the speed variable, regardless of what it is
      fragYPos[i] = fragYPos[i] + ySpeed;
    }
  }

  //the function that teleports the fragments to the top of the canvas
  void reachTop() {
    //walk through the array
    for (int i = 0; i < fragArrayMax; i++) {
      //if the y position is greater than height and the target has been reached
      if (fragYPos[i] > height && targetReached == true) {
        //set the y to a point above the canvas
        fragYPos[i] = -50;
        //set the x to a random position
        fragXPos[i] = finalPos;
        //increase the y with the speed variable
        fragYPos[i] += ySpeed;
      }
      //if the fragment reaches the y limit
      if (fragYPos[i] < fallLimit + 5 && fragYPos[i] > fallLimit - 1) {
        //set gone to true to change the opacity
        gone = true;
        //set fall to false to stop the increasing of the y
        fall = false;
        //call the evaporate function
        evaporate();
      }
    }
  }

  //the function that makes the fragments evaporate
  void evaporate() {
    //give the particles their color
    stroke(particleColor); 
    //increase t to affect the display function
    t += 0.01;
    //if progress is greater or equal to 4
    if (progress >= 4) {
      //walk through the array's first dimension
      for (int i = 0; i < parArray.length; i++) {
        //walk through the second dimension
        for (int j = 0; j < parArray.length; j++) {
          //make each particle display
          parArray[i][j].display();
        }
      }
    }
  }

  // ---- INSPIRED BY ADAM LASTOWKA ---- //
  //the class for the particle objects
  class Particle {
    // ---- PROPERTIES ---- //
    //a vector for the location
    PVector location;
    //a vector for the speed
    PVector velocity = new PVector(0, 0);
    // a vector the for target
    PVector target = new PVector(0, 0);
    //a variable that is used to affect future operations
    float multiplier;
    //a variable that is used to exponentially increase future numbers
    float exponent;

    // ---- CONSTRUCTOR ---- //
    Particle() {
      //walk through the array of fragments
      for (int i = 0; i < fragArrayMax; i++) {
        //for each one, create a new location vector that uses the approximate x and y of the fragment
        location = new PVector(finalPos, fallLimit - 50);
      }

      //set a random value for the multiplier
      multiplier = random(0.3, 1.5);
      //set a random value for the exponent
      exponent = random(-1, 1);
    }

    // ---- METHODS ---- //
    //the function to display the particles
    void display() {
      if (progress <= 6) {
        //if the mouse is in the sky
        if (mouseY <= horizonLine - 20) {
          //set the target to the mouse coordinates
          target = new PVector(mouseX, mouseY);
          //if not,
        } else {
          //set the target to a random point
          target = new PVector(round(random(width)), round(random(height / 2)));
        }
        //set the color
        stroke(60 * (multiplier + 1), 255, 100 * (exponent + 1), 50);
        //a variable that represents the length of the particle array
        float arrayLength = 75;
        //create a float that uses the distance between the current location and the target
        float distance = dist(location.x / arrayLength, location.y / arrayLength, target.x / arrayLength, target.y / arrayLength);
        //set the speed for the x and y using the distance variable, the difference between the target and the current location,
        //as well as other modifiers including multiplying the distance exponentially 
        velocity.x += 0.001 * (target.x - location.x) * pow(distance, exponent) * multiplier;
        velocity.y += 0.001 * (target.y - location.y) * pow(distance, exponent) * multiplier;
        //set a drag using perlin and the t value set earlier
        float drag = (noise(location.x / 20 + 492, location.y / 20 + 490, t * 2.2)-0.5) / 500 + 1.05;
        //have the drag affect the speed
        velocity.div(drag);
        //increase the velocity with perlin noise and the t value set earlier
        velocity.x += noise(location.x / 20, location.y / 20, t) - 0.5;
        velocity.y += noise(location.x / 20, location.y / 20 + 424, t) - 0.5;
        //increase the location with the velocity
        location.add(velocity);
        //draw the shape between the current location and the previous one divided by five
        line(location.x, location.y, location.x - velocity.x / 5, location.y - velocity.y / 5);
      }
    }
  }
  // ---- END OF REFERENCE ---- //
}

