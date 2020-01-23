// ---- THE TAB FOR THE RIVER ---- //

//the class for the River
class River {
  // ---- PROPERTIES ---- //
  //variables for the x and y position
  float riverXPos;
  float riverYPos;
  int riverOpacity = 70;

  //a variable used for the parametric equations used later
  float t;
  //a variable to control the amplitude of the sine and cosine functions in the parametric equations
  float amplitude = 100;
  //a variable to control the frequency of the functions in the same equations
  float frequency = 20;


  //the limit for the array
  int maxPulses = 50;
  //the number of Pulse objects created
  int pulseCount = 0;
  //a variable to track how full the array is
  int pulseIndex = 0;
  //a variable for the size of the pulse, set to 10
  int pulseScale = 10;
  //a color for the river
  color riverColor;
  //flags whether or not the array has been filled
  boolean arrayFull = false;
  //initialize the array of pulses
  Pulse[] pulseArray = new Pulse[maxPulses];
  //flag if the river has touched the stars
  boolean touchStars;

  // ---- CONSTRUCTOR ---- //
  River() {
    //initialize touchStars to false
    touchStars = false;
  }

  // ---- METHODS ---- //
  //the function to display the river
  void display() {
    //check that the array has NOT been filled...
    if (!arrayFull) {
      //walk through the array with the limit being the number of existing pulses
      pulseIndex = pulseCount;
    }
    //walk through the array
    for (int i = 0; i < pulseIndex; i++) {
      //remove the stroke
      noStroke();
      //display each pulse element
      pulseArray[i].display();
    }

    //set the strokeWeight to 5
    strokeWeight(5);
    //create a new x position and constrain it using parametric equations
    //in addition, confine it to the middle of the screen
    float xPos = constrain(riverXPos, x(t) + (width / 2 - 50), x(t) + (width / 2 + 50));
    //create a new y position and confine it to go no higher than the height and no lower than the middle of the canvas
    float yPos = constrain(riverYPos, height, height / 2);
    //assign these new variables, with added modifications, to newer ones
    //start the x in a random location
    float newX = xPos + random(10, 90);
    //have the y move in a wave both horizontally and vertically
    float newY = y(-t) + (y1(t) + yPos);
    //decrease the y position
    yPos--;
    //if the y position has not reached 360
    if (y(-t) + (y1(t) + yPos) >= 360) {
      //give it the color white
      riverColor = color(255, riverOpacity);
      //if it has, and if the progress is equal to three,
    } else if (y(-t) + (y1(t) + yPos) < 361 && progress == 3) {
      //reset the amplitude, frequency, and t values to their original ones
      amplitude = 100;
      frequency = 20;
      t = 0;
      //if the same occurs but progress is equal to five,
    } else if (y(-t) + (y1(t) + yPos) < 361 && progress == 5) {
      //keep the color white and let the river keep moving
      riverColor = color(255, riverOpacity);
      //once it nears the top of the canvas,
      if (y(-t) + (y1(t) + yPos) < 100) {
        //reset the values again
        amplitude = 100;
        frequency = 20;
        t = 0;
        //set touchStars to true
        touchStars = true;
      }
    }

    //if the length of the array hasn't been exceeded,
    if (pulseCount < pulseArray.length) {
      //instantiate another pulse object
      pulseArray[pulseCount] = new Pulse(newX, newY, pulseScale, riverColor);
      //and increase the pulseCount variable
      pulseCount++;
      //if the length has been exceeded,
    } else {
      //flag the array as being full
      arrayFull = true;
      //reset the count
      pulseCount = 0;
    }
    //increase the value of t in order to have animated sine and cosine functions
    t += 0.8;
    //decrease the values of amplitude and frequency in order to have more dynamic waves
    amplitude -= 0.3;
    frequency -= 0.025;
  }

  //the class for Pulse objects
  class Pulse {
    // ---- PROPERTIES ---- //
    //variables for the x and y position of the pulse  
    float pulseX;               
    float pulseY;      
    //a variable for the scaling of the pulse
    int pulseScale = 25;         

    //a variable for the diameter of the pulse  
    float pulseDiam;                  
    //a variable for the size of the pulse  
    float pulseSize;      
    //a color for the pulse
    color pulseColor;   

    // ---- CONSTRUCTOR ---- //
    //takes variables for position, scale, and color
    Pulse(float xPos, float yPos, int newPulseScale, color newColor) {
      //map the variables from the constructor to the class properties
      pulseX = xPos;
      pulseY = yPos;
      pulseScale = newPulseScale;
      pulseColor = newColor;
      //set the pulse size to zero
      pulseSize = 0;
    }

    // ---- METHODS ---- //
    //the function to display the pulses
    void display() {
      //set the diameter of the pulse using the sine function 
      pulseDiam = sin(pulseSize) * pulseScale;

      // draw the ellipse at the center
      ellipseMode(CENTER);
      //use the color variable to color the pulse
      fill(pulseColor);
      //draw an ellipse according to the class properties
      ellipse(pulseX, pulseY, pulseDiam, pulseDiam);

      //if the y position is greater or equal to 365
      if (pulseY >= 365) {
        //increase the size
        pulseSize = pulseSize + 0.1;
        //if not,
      } else {
        //set it to 0.3
        pulseSize = 0.3;
      }
    }
  }

  // ---- INSPIRED BY ALEXANDER MILLER ---- //
  //PARAMETRIC EQUATIONS
  //a function that returns a variable used for the river x position
  float x(float t) {
    //the variable returned is modified by a sine wave
    //the attributes of the sine wave are determined by the frequency and amplitude variables
    return sin(t / frequency) * (amplitude * 1.5);
  }

  //a function that returns a variable used for the river y position
  float y(float t) {
    //only t is returned, but t is incremented at another point in the code
    return t;
  } 

  //another function that returns a variable used for the river y position
  float y1(float t) {
    //the variable returned is modified by a sine wave
    //the attributes of the sine wave are determined by the frequency and amplitude variables
    return sin(t / (frequency / 2)) * (amplitude * 0.3);
  }
  // ---- END OF REFERENCE ---- //
}

