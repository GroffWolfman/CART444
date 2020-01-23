// ---- THE TAB FOR THE TEXTBOX CLASS ---- //

//the class for the textbox
class TextBox {
  // ---- PROPERTIES ---- //
  //variables for the x and y positions
  float x;
  float y;
  //a variable for the size of the text
  int fontSize;
  //to make sure the box we have is clickable, restrict the text to a certain area
  //a variable to control the width of the box
  float boxWidth;
  //a variable to control the height of the box
  float boxHeight;
  //create a new font object
  PFont font1;

  //pick the text for the box
  String instanceText;

  //set the color fo the text to white
  color textFill =  (255);
  //a variable to control the opacity
  int opacity;

  //our ability to choose whether we want the boxes to be reactive
  boolean alive = true;
  //flags whether or not the opacity value of the text should be changed
  boolean lower =  false;

  // ---- CONSTRUCTOR ---- //
  //takes variables for text, position, and dimensions
  TextBox(String tempText, int tempX, int tempY, float tempWidth, float tempHeight) {
    //map the variables from the constructor to the properties of the class
    x = tempX;
    y = tempY;
    boxWidth =  tempWidth;
    boxHeight = tempHeight;
    //assign the given string 
    instanceText = tempText;
    //set the size of the font to 30
    fontSize = 30;
    //load the font into the font object
    font1 = loadFont("CordiaUPC-Bold-48.vlw");
    //set the opacity to 10
    opacity = 10;
  }

  // ---- METHODS ---- //
  //the function to display the text
  void showText() {
    //position the text from the left
    textAlign(LEFT);
    //apply the font family and size to the text
    textFont(font1, fontSize);
    //if alive is true,
    if (alive) {
      //color the text with textFill and opacity
      fill(textFill, opacity);
      //if opacity is less than full,
      if (opacity < 255) {
        //increase it
        opacity += 2;
      }
      //if alive is not true,
    } else {
      //color the text with textFill and opacity
      fill(textFill, opacity);
      //and if opacity is greater than zero,
      if (opacity > 0) {
        //reduce the opacity
        opacity -= 2;
      }
    }
    //set the text to match whatever was inputed through the constructor
    text(instanceText, x, y, boxWidth, boxHeight);
  }


  //checks to see if the mouse is over a textbox
  boolean isOver(int mouseXPos, int mouseYPos) {
    //if the textbox is alive
    if (alive) {
      //and the mouse is over the textbox space
      if (mouseXPos > x 
        && mouseXPos < x + boxWidth
        && mouseYPos > y
        && mouseYPos < y + boxHeight) {
        //set isOver to true
        return true;
        //if not,
      } else {
        //set isOver to false
        return false;
      }
      //if the textbox is dead
    } else {
      //set isOver to false
      return false;
    }
  }

  //the function to change the opacity
  void colorChange() {
    //if the textbox is alive
    if (alive) {
      //and if textFill is inferior to 155 and lower is true
      if ( textFill > 155  && lower) {
        //decrease the value of textFill
        textFill -= 5;
      }
      //and if textFill is inferior to 255 and lower is false
      if (textFill < 255 && !lower) {
        //increase the value of textFill
        textFill += 5;
      }
      //if textFill is equal to 155 or 255
      if (textFill == 155 || textFill == 255) {
        //switch the state of lower
        lower = !lower;
      }
    }
  }

  //the function to make the text darker
  void setFillToBlack() {
    //set textFill to dark grey
    textFill = color(#3D3D3D);
  }
}

