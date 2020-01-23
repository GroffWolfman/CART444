// ---- THE TAB FOR THE SUN AND RELATED OBJECTS ---- //

//the function that draws the horizon
void drawHorizon() {
  //if progress is greater or equal to one
  if (progress >= 1) {
    //set the color
    fill(20);
    //remove the stroke
    noStroke();
    //and draw a rectangle filling the bottom of the screen
    rect(0, horizonLine, width, (height-horizonLine));
  }
}

//the function that draws the day sky
void drawSky() {
  //set the color and opacity
  fill(#24A3D3, skyOpacity);
  //draw a rect filling the top of the screen
  rect(0, 0, width, (height - (height - horizonLine)));
  //if progress is greater or equal to two
  if (progress >= 2) {
    //begin reducing the opacity
    skyOpacity-= 0.7;
  }
}

//the class for the sun
class Sun {
  // --- PROPERTIES --- //
  //a variable for the x position
  int sunX;
  //a variable for the y position
  float sunY;
  //a variable for the size
  int sunSize;
  //a variable to move the sun
  float moveY;
  //a variable for the opacity
  float auraOpacity;

  // --- CONSTRUCTOR --- //
  //takes variables for position and size
  Sun(int xPos, float yPos, int size) {
    //map the variables in the constructor to the properties
    sunX = xPos;
    sunY = yPos;
    sunSize = size;
    //assign a value to moveY
    moveY = 0.25;
    //assign an initial opacity to the aura
    auraOpacity = 45;
  }
  // --- METHODS --- //
  //the function to display the sun
  void display() {
    //remove the stroke
    noStroke();
    //set the color and the opacity
    fill(#E06E18, auraOpacity);
    //draw an ellipse at the position, using an increased version of the size
    ellipse(sunX, sunY, sunSize + 40, sunSize + 40);
    //repeat but raise the opacity
    fill(#F47500, auraOpacity + 5);
    //repeat but lessen the size increase
    ellipse(sunX, sunY, sunSize + 25, sunSize + 25);
    //repeat but raise the opacity
    fill(#FF9100, auraOpacity + 35);
    //repeat but lessen the size increase
    ellipse(sunX, sunY, sunSize + 10, sunSize + 10);
    //repeat but use a full opacity
    fill(#FFC200);
    //repeat but use the original size
    ellipse(sunX, sunY, sunSize, sunSize);
    //repeat but decrease the opacity
    fill(#FFFFB5, auraOpacity - 15);
    //repeat but decrease the size
    ellipse(sunX, sunY, sunSize - 20, sunSize - 20);
  }

  //a function to make the sun set
  void fall() {
    //decrease the opacity 
    auraOpacity -= 0.1;
    //increase the y position with moveY
    sunY = sunY + moveY;
  }
}

