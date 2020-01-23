// ---- THE TAB FOR THE STAR OBJECTS AND FUNCTIONS ---- //

//the function that initializes stars
void addStars() {
  //if we haven't exceeded the maximum number of stars...
  if (starCount < starArray.length) {
    //make more at random positions and with a random size
    starArray[starCount] = new Star(random(width), random(-25, 0), random(2));
    //increase the star count 
    starCount++;
    //...otherwise loop back to the start of the array
  } else {   
    //flag the array as being full
    starArrayFull = true; 
    //reset the star count
    starCount = 0;
  }
}

//the class for stars
class Star {
  // --- PROPERTIES --- //
  //a variable for the x position
  float starX;
  //a variable for the y position
  float starY;
  //a variable for the size
  float starSize;
  // a variable for the movement
  float moveY;

  // --- CONSTRUCTOR --- //
  //takes variables for position and size
  Star(float xPos, float yPos, float size) {
    //map the variables in the constructor to the properties
    starX = xPos;
    starY = yPos;
    starSize = size;
    //assign a value to moveY
    moveY = 0.5;
  }
  // --- METHODS --- //
  //the function to display the stars
  void display() {
    //color the stars white
    stroke(255);
    //give them their size
    strokeWeight(starSize);
    //draw them at their position
    point(starX, starY);
  }

  //a function to make the stars fall
  void fall() {
    //increase the y position with moveY
    starY = starY + moveY;
  }
}

