/**
 * Title: 6 <br>
 * Name: Alexander Charette & Geoff Merson <br>
 * Date: 15/12/15 <br>
 * Description: Open Brief <br>
 **/

// ----------------------------------------------------------------------
// COMPUTATIONAL REFERENCES
// ----------------------------------------------------------------------
/*
 * The path finding method used in this code to move fragments around is based on code by blindfish, at processing.org.
 * url: https://processing.org/discourse/beta/num_1247174364.html
 * The parametric equations used for sine waves are based on a tutorial by Alexander Miller entitled "Recreating Vintage Computer Art with Processing".
 * url: https://www.youtube.com/watch?v=LaarVR1AOvs
 * The particle system used is based on code entitled Majyk by Adam Lastowka, at openprocessing.org.
 * url: http://www.openprocessing.org/sketch/95650
 * Computational references within the code will be highlighted. All comments included within those spaces are, however, original. 
 */
// ----------------------------------------------------------------------
// GLOBAL VARIABLES
// ----------------------------------------------------------------------
//make a color for the background
color backgroundColor = #333645;
//make a progress counter to move the story along
int progress;
//make a variable to mark the center of the x axis
int centerX;
//make a variable to mark the center of the y axis
int centerY;
//make a variable to control the opacity of the ring background
int ringBackOpacity;
//make a variable to control the opacity of the memory scene background
int memBackOpacity;

// ---- VARIABLES RELATED TO THE PATH ---- //
//set the length of the array
int maxFragments = 21;
//create an array of fragments
Fragment[] path = new Fragment[maxFragments];
//a variable to initiate the falling of the different path fragments
float fallPos;

// ---- VARIABLES RELATED TO THE SUN ---- //
//declare a new Sun object
Sun mySun;
//a variable to control the opacity of the blue sky
float skyOpacity;
//a variable to set the position and height of the horizon
int horizonLine;

// ---- VARIABLES RELATED TO THE LEAVES ---- //
//a variable to control the red value
float red;
//a variable to control the green value
float green;
//a variable to control the blue value
float blue;
//a variable to increment those colors
float colChange;
//a variable to control the opacity of the leaves
int leafOpacity;

// ---- VARIABLES RELATED TO THE STARS ---- //
//set a the length of the starArray
int maxStars = 750;
//a variable to count the number of stars
int starCount;
//a variable to keep track of how full the array is
int starIndex;
//a boolean to flag when the array is full
boolean starArrayFull = false;
//declare an array of stars
Star[] starArray = new Star[maxStars];

// ---- VARIABLES RELATED TO THE MUSIC ---- //
//import the minim library
import ddf.minim.*;
//declare a new minim object
Minim minim;
//declare a new audioplayer object to establish how we will be using minim
AudioPlayer song;

// ---- VARIABLES RELATED TO THE RING ---- //
//declare a new Ring object
Ring breatheRing;

// ---- VARIABLES RELATED TO THE RIVER ---- //
River myRiver;

// ---- VARIABLES RELATED TO THE MEMORY ---- //
//set a length for the memory arrays
int memoryLength = 6;
//declare an array of fragments to be launched from the right side
memFrag[] memoryRight = new memFrag[memoryLength];
//delcare an array of fragments to be launched from the left side
memFrag[] memoryLeft = new memFrag[memoryLength];
boolean endMemory;

// ---- VARIABLES RELATED TO THE TEXT ---- //
//flag whether or not we will show the second part of scene three
boolean showS32;
//flag whether or not we will show the third part of scene three
boolean showS33;
//flag whether or not we will show the fourth part of scene three
boolean showS34;
//flag whether or not we will show the second part of scene six
boolean showS62;
//flag whether or not we will show the third part of scene six
boolean showS63;

// ---- VARIABLES RELATED TO THE PATH TEXT ---- //
//a variable for the text width
float textW;
//a variable for the height width
float textH;
//a variable for the size of the first item
int size;
//a variable for the size of the second item
int size2;
//a variable for the size of the third item
int size3;
//a variable for the size of the fourth item
int size4;
//a variable for the size of the fifth item
int size5;
//a variable to increase or decrease any other related variables
float incr = 10;
//variables for the x and y positions
int pathTxtX;
int pathTxtY;
//a variable to control the speed
float speed;
//a variable for easing
float easing;
//flag if 4 is done
boolean scene4Done = false;
// ----------------------------------------------------------------------
// BUILT-IN FUNCTIONS
// ----------------------------------------------------------------------
void setup() {
  //set the size of the canvas and use the 2D renderer
  //without the renderer, the particle effects become too slow
  size(700, 550, P2D);
  //set the background using the color variable
  background(backgroundColor); 
  smooth();
  //initialize the TextBox objects
  initText();
  setupPathTxt();
  //set the progress counter to zero
  progress = 0;  

  //set the ring background's opacity to full
  ringBackOpacity = 255;
  //set the memory background's opacity to none
  memBackOpacity = 0;

  //give the center position variables their appropriate values 
  //by dividing the canvas dimensions by two
  centerX = width / 2;
  centerY = height / 2;

  // ---- VARIABLES RELATED TO THE PATH ---- //
  //call this function to initialize the path elements
  setupPath();
  //set the variable used to increase the Y of the path to zero
  fallPos = 0;
  //give every path element a fall value of false
  //to indicate that the fragments are not falling
  for ( int i = 0; i < path.length; i++) {
    path[i].fall = false;
  }

  // ---- VARIABLES RELATED TO THE SUN ---- //
  //initialize the Sun object and give it location and size
  mySun = new Sun(centerX, centerY, 70);
  //set the initial opacity for the blue sky
  skyOpacity = 160;
  //set the height of the horizon
  horizonLine = 360;

  // ---- VARIABLES RELATED TO THE LEAVES ---- //
  //set the red value to 48
  red = 48;
  //set the green value to 110
  green = 110;
  //set the blue value to 54
  blue = 54;
  //set the increment to 0.3
  colChange = 0.3;
  //set the opacity of the leaves to zero, to start
  leafOpacity = 0;

  // ---- VARIABLES RELATED TO THE STARS ---- //
  //set a the length of the starArray
  maxStars = 750;
  //set the number of starts to zero
  starCount = 0;
  //mark the array as being empty
  starIndex = 0;
  //a boolean to flag when the array is full
  starArrayFull = false;
  //declare an array of stars
  Star[] starArray = new Star[maxStars];


  // ---- VARIABLES RELATED TO THE RING ---- //
  //initialize ring
  breatheRing = new Ring(centerX, centerY);

  // ---- VARIABLES RELATED TO THE RIVER ---- //
  myRiver = new River();

  // ---- VARIABLES RELATED TO THE MUSIC ---- //
  //initialize the minim object and make it reference this sketch
  minim = new Minim(this);
  //load the sound file to be used for the song object
  song = minim.loadFile("mysong.mp3");

  // ---- VARIABLES RELATED TO THE MEMORY ---- //
  //call this function to initialize all the fragments in the memory array
  setupMemory();
  endMemory = false;

  // ---- VARIABLES RELATED TO THE TEXT ---- //
  //set the scene three text booleans to false, since we are not showing it at setup
  showS32 = false;
  showS33 = false;
  showS34 = false;
  showS62 = false;
  showS63 = false;
  //flag whether or not scene 4 is complete
  scene4Done = false;
}

void draw() {
  //redraw the background for animation
  background(backgroundColor);

  //if progress is greater or equal to one
  if (progress >= 1) {
    //show s2P1
    s2P1.showText();
    //draw the sky
    drawSky();
    //draw the sun
    mySun.display();
    //if s2P1 is clicked
    if (s2P1.isOver(mouseX, mouseY) && mousePressed) {
      //set progress to two
      progress = 2;
    }
  } 

  //if the song exceeds a time limit
  if (song.position() >= (song.length())- 13000 ) {
    //rewind it and play it again
    song.rewind();
    song.play();
    //if not,
  } else {
    //play the song
    song.play();
  }

  // --- STAR OPERATIONS --- //
  //if progress is between two and six
  if (progress >= 2 && progress <= 6) {
    //set s2P1 to dead
    s2P1.alive = false;
    //call the function to make more stars
    addStars();
    //check that the array has NOT been filled...
    if (!starArrayFull) {
      //set the index for walking the array equal to the number of stars
      starIndex = starCount;
    }
    //walk through the array, telling each star
    //to display and fall
    for (int i = 0; i < starIndex; i++) {
      starArray[i].display();
      starArray[i].fall();
    }
    //MAKE SUN FALL
    mySun.fall();
  }

  //if progress is greater or equal to seven,
  if (progress >= 7) {
    //show s7P1
    s7P1.showText();
    //if the opacity of s7P1 is greater than 255,
    if (s7P1.opacity > 255) {
      //show s7P2
      s7P2.showText();
    }
    //if the opacity of s7P2 is greater than 255,
    if (s7P2.opacity > 255) {
      //show s7P3
      s7P3.showText();
    }
  }

  //call the function to draw the horizon
  drawHorizon();
  //call the function to draw the ring background
  drawRingBack();

  // the opacity of s7P3 is greater than 240,
  if (s7P3.opacity >= 240) {
    //show s8P1
    s8P1.showText();
  }
  //if the opacity of s8P1 is greater or equal to 250,
  if (s8P1.opacity >= 250) {
    //set the progress counter to -1
    progress = -1;
  }

  //if progress is greater or equal to zero,
  if (progress >= 0) {
    //show and animation the breatheRing object
    breatheRing.display();
    breatheRing.breathe();
  }

  //if the sun object's y position is greater than the halfway point,
  if (mySun.sunY > height / 2 + 10) {
    //show s3P1
    s3P1.showText();
  }
  //if progress is equal to three or five,
  if (progress == 3 || progress == 5) {
    //display the river object
    myRiver.display();
    //if progress is equal to three,
    if (progress == 3) {
      //and s4P2 is clicked,
      if (s4P2.isOver(mouseX, mouseY) && mousePressed) {
        //set progress to 4
        progress = 4;
      }
    }
    //if progress is equal to five,
    if (progress == 5) {
      //and the river object is touching the stars,
      if (myRiver.touchStars) {
        //set progress to 6
        progress = 6;
      }
    }
  }

  //call the functions that show text for progress 2 and 3
  progress2Text();
  progress3Text();

  //if progress is greater or equal to 4,
  if (progress >= 4 ) {
    //set s4P2 to dead
    s4P2.alive = false;
    //draw the path
    drawPath();
    //display the text for the path
    writePathTxt();
    //show s4P3
    s4P3.showText();
    //and make it flicker
    s4P3.colorChange();
  }
  //if progress is equal to four,
  if (progress == 4) {
    //and all the path objects are set to gone
    if (path[path.length-1].gone) {
      //flag scene 4 as being completed
      scene4Done = true;
    }
    //if scene 4 has been completed,
    if (scene4Done) {
      //set progress to five
      progress = 5;
      //set scene4Done to false
      scene4Done = false;
    }
  }

  //if progress is greater or equal to five
  if (progress >= 5) {
    //set s4P3 to dead
    s4P3.alive = false;
    //show s5P1
    s5P1.showText();
  }

  //if progress is equal to zero
  if (progress == 0) {
    //call the startup function
    startup();
  }
  //if progress is between one and seven
  if (progress >= 1 && progress < 7) {
    //draw the leaves
    drawLeaves();
  }

  //if progress is greater than 6,
  if (progress >= 6) {
    //set s5P1 to dead
    s5P1.alive = false;

    //set the color for the scene 6 text objects to black
    s6P1.setFillToBlack();
    s6P2.setFillToBlack();
    s6P3.setFillToBlack();

    //if the opacity of s6P1 is greater than 255,
    if (s6P1.opacity > 255) {
      //draw the memory scene background
      drawMemoryBack();
      //prepare to show the next text object
      showS62 = true;
    }

    //show s6P1
    s6P1.showText();

    //if showS62 is set to true
    if (showS62) {
      //call the loseMemory function
      loseMemory();
      //show s6P2
      s6P2.showText();
    }
    //if the opacity of s6P2 is greater than 255,
    if (s6P2.opacity > 255) {
      //prepare to show the next text object
      showS63 = true;
    }
    //if showS63 is set to true
    if (showS63) {
      //show s6P3
      s6P3.showText();
    }
  }

  //if progress is greater than six
  if (progress > 6) {
    //set the scene six text objects to dead
    s6P1.alive = false;
    s6P2.alive = false;
    s6P3.alive = false;
  }

  //if endMemory is true
  if (endMemory) {
    //set progress to seven
    progress = 7;
    //set endMemory to false
    endMemory = false;
  }
  //if progress equals -1
  if (progress == -1) {
    //call the setupInfo function
    setupInfo();
  }
}

void mousePressed() {
  //if progress is greater than zero
  if (progress > 4) {
    //increase it by one everytime the mouse is pressed
    progress++;
  }
}

void keyPressed() {
  //if the space bar is pressed..
  if ( key == 32) {
    //and set progress to zero
    progress = -1;
  }
  //if progress is greater than four
  if (progress >= 4) {
    //check to see if the key is coded, or if it is W
    if ( key == CODED|| key == 'w') { 
      //if the key pressed is the up arrow key or W
      if (keyCode == UP || key == 'w') {
        //make the path objects  fall
        fallPath();
        //animate the path text objects
        movePathTxt();
      }
    }
  }
}

// ----------------------------------------------------------------------
// CUSTOM FUNCTIONS
// ----------------------------------------------------------------------

//move on from the ring scene
void startup() {
  //if the inner progress of the breatheRing is equal to five
  if (breatheRing.sceneProgress == 5) {
    //set the global progress to one
    progress = 1;
    //flag the text booleans from the ring scene as false
    //in order to mark them as "dead"
    intro.alive = false;
    s1P1.alive  = false;
    s1P2.alive  = false;
    s1P3.alive  = false;
    s1P4.alive  = false;
  }
}
void setupInfo() {
  //set the size of the canvas and use the 2D renderer
  //without the renderer, the particle effects become too slow
  size(700, 550, P2D);
  //set the background using the color variable
  background(backgroundColor); 
  smooth();
  //initialize the TextBox objects
  initText();
  setupPathTxt();

  //set the ring background's opacity to full
  ringBackOpacity = 255;
  //set the memory background's opacity to none
  memBackOpacity = 0;

  //give the center position variables their appropriate values 
  //by dividing the canvas dimensions by two
  centerX = width / 2;
  centerY = height / 2;

  // ---- VARIABLES RELATED TO THE PATH ---- //
  //call this function to initialize the path elements
  setupPath();
  //set the variable used to increase the Y of the path to zero
  fallPos = 0;
  //give every path element a fall value of false
  //to indicate that the fragments are not falling
  for ( int i = 0; i < path.length; i++) {
    path[i].fall = false;
  }

  // ---- VARIABLES RELATED TO THE SUN ---- //
  //initialize the Sun object and give it location and size
  mySun = new Sun(centerX, centerY, 70);
  //set the initial opacity for the blue sky
  skyOpacity = 160;
  //set the height of the horizon
  horizonLine = 360;

  // ---- VARIABLES RELATED TO THE LEAVES ---- //
  //set the red value to 48
  red = 48;
  //set the green value to 110
  green = 110;
  //set the blue value to 54
  blue = 54;
  //set the increment to 0.3
  colChange = 0.3;
  //set the opacity of the leaves to zero, to start
  leafOpacity = 0;

  // ---- VARIABLES RELATED TO THE STARS ---- //
  //set a the length of the starArray
  maxStars = 750;
  //set the number of starts to zero
  starCount = 0;
  //mark the array as being empty
  starIndex = 0;
  //a boolean to flag when the array is full
  starArrayFull = false;
  //declare an array of stars
  Star[] starArray = new Star[maxStars];


  // ---- VARIABLES RELATED TO THE RING ---- //
  //initialize ring
  breatheRing = new Ring(centerX, centerY);

  // ---- VARIABLES RELATED TO THE RIVER ---- //
  myRiver = new River();

  // ---- VARIABLES RELATED TO THE MUSIC ---- //
  //initialize the minim object and make it reference this sketch
  minim = new Minim(this);
  //load the sound file to be used for the song object
  song = minim.loadFile("mysong.mp3");

  // ---- VARIABLES RELATED TO THE MEMORY ---- //
  //call this function to initialize all the fragments in the memory array
  setupMemory();
  endMemory = false;

  // ---- VARIABLES RELATED TO THE TEXT ---- //
  //set the scene three text booleans to false, since we are not showing it at setup
  showS32 = false;
  showS33 = false;
  showS34 = false;
  showS62 = false;
  showS63 = false;
  //flag whether or not scene 4 is complete
  scene4Done = false;

  //set the progress counter to zero
  progress = 0;
}

//the function that progresses through scene 3
void progress2Text() {
  //if the opacity of s3P1 is greater than 255,
  if (s3P1.opacity > 255) {
    //prepare to show the next text object
    showS32 = true;
  }
  //if showS32 is true
  if (showS32) {
    //show s3P2
    s3P2.showText();
  }
  //if the opacity of s3P2 is greater than 255,
  if (s3P2.opacity > 255) {
    //prepare to show the next text object
    showS33 = true;
  }
  //if showS33 is true
  if (showS33) {
    //show s3P3
    s3P3.showText();
  }
  //if the opacity of s3P3 is greater than 255,
  if (s3P3.opacity > 255) {
    //prepare to show the next text object
    showS34 = true;
  }
  //if showS34 is true
  if (showS34) {
    //show s3P4
    s3P4.showText();
  }
  //if the sun object passes below a certain point,
  if (mySun.sunY > height-120) {
    //kill all the scene three text objects
    s3P1.alive = false;
    s3P2.alive = false;
    s3P3.alive = false;
    s3P4.alive = false;
  }
}

//the function that progresses through scene 4
void progress3Text() {
  //if the opacity of s3P4 is equal to zero,
  if (s3P4.opacity == 0) {
    //show s4P1
    s4P1.showText();
    //if s4P1 is nearing the horizonLine
    if (s4P1.y < horizonLine - 20) {
      //increase the y position
      s4P1.y += 0.5;
      //if not,
    } else {
      //set it to dead
      s4P1.alive = false;
    }
    //if the opacity of s4P1 is equal to zero
    if (s4P1.opacity == 0) {
      //show s4P2
      s4P2.showText();
    }
    //if progress is equal to two,
    if (progress == 2) {
      //set progress to three
      progress = 3;
    }
  }
}

