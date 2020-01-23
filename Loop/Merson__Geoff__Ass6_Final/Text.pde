// ---- THE TAB FOR THE TEXT OBJECTS AND RELATED FUNCTIONS ---- //

//Create all the text objects
//S for scene, P for part
//text piece 1
TextBox intro;
//SCENE 1
TextBox s1P1;
TextBox s1P2;
TextBox s1P3;
TextBox s1P4;
//SCENE 2
TextBox s2P1;
//SCENE 3
TextBox s3P1;
TextBox s3P2;
TextBox s3P3;
TextBox s3P4;
//SCENE 4
TextBox s4P1;
TextBox s4P2;
TextBox s4P3;
TextBox s4P4;
//SCENE 5
TextBox s5P1;
//SCENE 6
TextBox s6P1;
TextBox s6P2;
TextBox s6P3;
//SCENE 7
TextBox s7P1;
TextBox s7P2;
TextBox s7P3;
//SCENE 8
TextBox s8P1;
TextBox s8P2;

//The text objects for the path
TextBox path1;
TextBox path2;
TextBox path3;
TextBox path4;
TextBox path5;

//a variable for the width of the intro object
int introWidth = 135;
//a variable for the width of the other text objects
int textWidth = 300;
//a variable for the height of the text objects
int textHeight = 20;

//a function in which we initialize all text objects
void initText() {

  //Each TextBox takes a string, a position, a width, and a height

    // ---- RING SCENE TEXT ---- //
  intro = new TextBox("He breathes in", (width/6)-50, height/8, introWidth, textHeight);
  s1P1 = new TextBox("and out", ((width/6)-50)+introWidth, (height/8), textWidth - 50, textHeight);
  s1P2 = new TextBox("Sitting under a tree", (width/6)*3-50, (height/8)*2, textWidth, textHeight);
  s1P3 = new TextBox("Shutting out the world around him,", (width/6)*3-50, (height/8)*6, textWidth, textHeight);
  s1P4 = new TextBox("drinking it in through every pore", (width/6)*2-50, (height/8)*7, textWidth, textHeight);

  // ---- TRANSITION TEXT ---- //
  s2P1 = new TextBox("It's clear now", (width/2)-60, height/2-70, 300, 20);

  // ---- DAY SCENE TEXT ---- //
  s3P1 = new TextBox("The light beams through the leaves", (width/6)*1-50, (height/8)*4+70, textWidth + 25, textHeight);
  s3P2 = new TextBox("and onto his forehead", (width/6)*2-50, (height/8)*5+60, textWidth, textHeight);
  s3P3 = new TextBox("as the sun turns under the horizon,", (width/6)*3-50, (height/8)*6+50, textWidth+100, textHeight);
  s3P4 = new TextBox("gone from this world", (width/6)*4-50, (height/8)*7+40, textWidth, textHeight);

  // ---- STAR TEXT ---- //
  s4P1 = new TextBox("The stars chase it over the tree", (width/6)*1-50, (height/8)*3, textWidth, textHeight);

  // ---- RIVER TEXT ---- //
  s4P2 = new TextBox("guided by the flow of a shimmering river", (width/6)*2-50, (height/8)*7, textWidth + 100, textHeight);

  // ---- PATH SCENE TEXT ---- //
  s4P3 = new TextBox("Move Forward", (width/6)*5-50, (height/8)*1, textWidth, textHeight);

  // ---- NIGHT SCENE TEXT ---- //
  s5P1 = new TextBox("Nothing is lost. Nothing is created.", (width/2)+30, (height/2)+90, textWidth, textHeight);

  // ---- MEMORY TEXT ---- //
  s6P1 = new TextBox("Your memories are a flurry", (width/6)*1-100, (height/8)*1, textWidth, 20);
  s6P2 = new TextBox("and just when reality seems at its furthest", (width/6)*3-150, (height/8)*4, textWidth+75, textHeight);
  s6P3 = new TextBox("You feel a new breeze on your cheek", (width/6)*5-250, (height/8)*7, textWidth + 25, textHeight);

  // ---- FINAL NIGHT SCENE TEXT ---- //
  s7P1 = new TextBox("Nothing is lost, Nothing is created", (width/2)-150, (height/2), textWidth, textHeight);
  s7P2 = new TextBox("but where are you going?", (width/6)*1-50, (height/8)*5, textWidth, textHeight);
  s7P3 = new TextBox("The tree stands tall.", (width/6)*5-150, (height/8)*5, textWidth, textHeight);

  // ---- THE LOOP TEXT ---- //
  s8P1 = new TextBox("Another comes along", (width/6)*4-50, (height/8)*2, textWidth, textHeight);
  s8P2 = new TextBox("He breathes in", (width/6)-50, height/8, introWidth, textHeight);
}

//the function to initialize the path text objects
void setupPathTxt() {
  //assign a value of 40 to size
  size = 40;
  //assign a value of 20 to size2
  size2 = 20;
  //assign a value of 13 to siz3
  size3 = 13;
  //assign a value of 7 to size4
  size4 = 7;
  //assign a value of 3 to size5
  size5 = 3;
  //assign a value of 10 to incr
  incr = 10;
  //set the main x position to the center of the x axis
  pathTxtX = width / 2;
  //set the main y position to 420
  pathTxtY = 420;
  //assign a value of 100 to text width and height
  textW = 100;
  textH = 100;
  //assign a value of 0.025 to easing
  easing = 0.025;
  //initialize the TextBox objects, giving them each a string, a position, and size
  path1 = new TextBox("The", pathTxtX - int(textW / 4), pathTxtY, int(textW), textH);
  path2 = new TextBox("path", pathTxtX - int((textW / 4) - (textW / 8)), pathTxtY - int((textW/7)) * 2, textW / 2, textH / 2);
  path3 = new TextBox("is", pathTxtX - int((textW / 4) - (textW / 4.5)), pathTxtY - int((textW/7)) * 3, textW / 3, textH / 3);
  path4 = new TextBox("falling", pathTxtX - int((textW / 4) - (textW / 4)), pathTxtY - int((textW/7)) * 4, textW / 4, textH / 4);
  path5 = new TextBox("away", pathTxtX - int((textW / 4) - (textW / 4)), pathTxtY - int((textW/9)) * 5, textW / 5, textH / 5);
}

//a function to display the path TextBox objects
void writePathTxt() {
  //set the speed to the distance between the path objects and an offscreen point
  speed = dist(pathTxtX, pathTxtY, pathTxtX, height * 2) / 120;
  
  //assign the size values to their respective objects
  path1.fontSize = size;
  path2.fontSize = size2;
  path3.fontSize = size3;
  path4.fontSize = size4;
  path5.fontSize = size5;
  
  //display each path object
  path1.showText();
  path2.showText();
  path3.showText();
  path4.showText();
  path5.showText();
}

void movePathTxt() {
  float divisor = 3.8;

  //if fallPos is still within the length of the array
  if (fallPos < path.length-1) {
    //increase the width of path1 using speed
    path1.boxWidth += speed * 5 / divisor;
    //increase the height of path1 using speed
    path1.boxHeight += speed * 5 / divisor;
    //decrease the x of path1 with incr
    path1.x -= incr * 0.9 / divisor;
    //increase the y of path1 with speed
    path1.y += speed * 2.5 / divisor;
    //increase the fontsize of path 1 with speed
    size += speed * 3 / divisor;
    //if the distance between path1 and the bottom of the screen is less than 150
    //or if its y value is greater than the height of the screen...
    if (dist(path1.x, path1.y, width / divisor, height) < 50 || path1.y > height) {
      //increase the width of path2 using speed
      path2.boxWidth += speed * 5.5 / divisor;
      //increase the height of path2 using speed
      path2.boxHeight += speed * 5 / divisor;
      //decrease the x of path2 with incr
      path2.x -= incr * 0.9 / divisor;
      //increase the y of path2 with speed
      path2.y += speed * 2 / divisor;
      //increase the fontsize of path2 with speed
      size2 += speed * 3 / divisor;
    }
    //if the distance between path2 and the bottom of the screen is less than 150
    //or if its y value is greater than the height of the screen...
    if (dist(path2.x, path2.y, width / divisor, height) < 50 || path2.y > height) {
      //increase the width of path3 using speed
      path3.boxWidth += speed * 5 / divisor;
      //increase the height of path3 using speed
      path3.boxHeight += speed * 5 / divisor;
      //decrease the x of path3 with incr
      path3.x -= incr / 3 / divisor;
      //increase the y of path3 with speed
      path3.y += speed * 2 / divisor;
      //increase the fontsize of path3 with speed
      size3 += speed * 3 / divisor;
    }
    if (dist(path3.x, path3.y, width / divisor, height) < 50 || path3.y > height) {
      //increase the width of path4 using speed
      path4.boxWidth += speed * 6 / divisor;
      //increase the height of path4 using speed
      path4.boxHeight += speed * 5 / divisor;
      //decrease the x of path4 with incr
      path4.x -= incr * 1.2 / divisor;
      //increase the y of path4 with speed
      path4.y += speed * 2.2 / divisor;
      //increase the fontsize of path4 with speed
      size4 += speed * 3 / divisor;
    }
    if (dist(path4.x, path4.y, width / divisor, height) < 50 || path4.y > height) {
      //increase the width of path5 using speed
      path5.boxWidth += speed * 6 / divisor;
      //increase the height of path5 using speed
      path5.boxHeight += speed * 5 / divisor;
      //decrease the x of path5 with incr
      path5.x -= incr * 1.2 / divisor;
      //increase the y of path5 with speed
      path5.y += speed * 2.5 / divisor;
      //increase the fontsize of path5 with speed
      size5 += speed * 3 / divisor;
    }
  }
}

