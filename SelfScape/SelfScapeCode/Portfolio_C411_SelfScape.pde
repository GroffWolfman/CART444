int testNum   = 200;  //<>// //<>//
int hiveNum   = 7;
int agentTolerance = 5;
int timeInt   = 16;
int baseInt   = timeInt;
int colorStep = 5;

//Lists
ArrayList<hive> hives         = new ArrayList<hive>();
ArrayList<place> places       = new ArrayList<place>();
ArrayList<agent> globalAgents = new ArrayList<agent>();


//world variables
int   worldTime;
color worldColor;
//BorderBuffers
int   hiveYBuffer = width/4;
int   hiveXBuffer = width/4;
int   placeYBuffer = width/3;
int   placeXBuffer = width/3;

//daylight coming or fading?
boolean isFading;
//Asset globals
int   buildingSize = 35;
color buildingStroke;

boolean test = false;

//font 
PFont font;
//oft updated number for text purposes
int negString=0;



void keyPressed() {
  if (key == CODED) {
    if (keyCode ==LEFT) {
      if (timeInt >1) {
        timeInt --;
      }
    } else if (keyCode ==RIGHT) {
      timeInt ++;
    }
  } else {
    test = !test;
  }
}

void setup() {
  size(540, 600);
  frameRate(timeInt*4);
  worldColor =1;
  buildingStroke =255;
  background(worldColor);
  isFading=false;
  //Places need to populate before hives
  placeSpacing();
  hiveSpacing();
  for (hive h : hives) {
    h.hivePopulate();
  }
  font = loadFont("YuGothicUI-Light-14.vlw");
}

void draw() {
  background(worldColor);
  frameRate(timeInt*4);

  for (agent a : globalAgents) {
    a.agentUpdate();
    a.agentDisplay();
  }
  for (hive h : hives) {
    h.hiveDisplay();
    h.hiveUpdate();
    h.isMousedOver();
  }
  for (place p : places) {
    p.display();
  }
  //dividing box on the 7/8th line
  rectMode(CORNER);
  fill(70);
  rect(0, (height/8)*7, width, (height/8)*7);
  //time Update also contains text display info
  timeUpdate();
  writeText();
}

float globalStateVal() {
  float tempVal=0;
  for (agent ha : globalAgents) {
    tempVal += ha.aStateVal;
  }
  tempVal = tempVal/globalAgents.size();
  return tempVal;
}

void writeText() {
  int textYOffset = 18;
  // text processing
  stroke(255);
  fill(255);
  textFont(font, 15);
  for (hive hi : hives) {
    if (hi.isMousedOver()) {
      float stateAvg=0;
      for (agent ha : hi.hiveAgents) {
        stateAvg += ha.aStateVal;
        println(ha.aStateVal);
      }
      stateAvg = stateAvg/hi.hiveAgents.size();
      println("------- " + stateAvg + " -------");
      text("The Average state of agents from this hive is : " + commonLangState(stateAvg), textYOffset, (height/8)*7 + textYOffset*2);
      if (stateAvg > globalStateVal()) {
        text("This hive is more negative than the global average", textYOffset, (height/8)*7 + textYOffset*3);
      } else {
        text("This hive is more positive than the global average", textYOffset, (height/8)*7 + textYOffset*3);
      }
    } else {
      text("Mouse over a hive to see a detailed view", textYOffset, (height/8)*7 + textYOffset);

      if (worldTime%baseInt==0) {
        negString = totalNeg();
      }
     // text(negString, width-textYOffset*2.5, height - textYOffset*1.5);
      text("Currently, " + negString*100/testNum + " % are struggling", width/10*7-textYOffset*2.5, height - textYOffset/2);
      //println(totalNeg(\)*100/200);
    }
  }
}

int totalNeg() {
  int tempVal = 0;
  for (agent ha : globalAgents) {
    if (ha.aStateVal > 0) {
      tempVal ++;
    }
  }
  return tempVal;
}

String commonLangState(float input) {
  //breakup the states into sections
  /*
  -10 to -6   Positive
   -5 to -2   Leaning Positive
   -1 to  1   Normal
   2 to  6   Leaning Negative
   7 to 10   Negative
   
   */
  if (input < -5) {
    return "Postive";
  } else if (input >=-5 && input <=-2) {
    return "Leaning Positive";
  } else if (input > -2 && input < 2) {
    return "Normal";
  } else if (input >= 2 && input <= 5) {
    return "Leaning Negative";
  } else if (input > 5) {
    return "Negative";
  } else {
    return "Error: cannot map state";
  }
}

void timeUpdate() {
  worldTime++; 
  if (worldTime%baseInt==0) {
    if (isFading) {
      worldColor-=colorStep;
      buildingStroke+=colorStep;
    } else {
      worldColor+=colorStep;
      buildingStroke-=colorStep;
    }
  }

  if (worldColor>240) {
    isFading=true;
  } 
  if (worldColor<20) {
    isFading=false;
  }
  if (buildingStroke<=0) {
    buildingStroke =255;
  }
}

//try to reduce clutter and overlap
void hiveSpacing() {
  int newHiveX, newHiveY;
  for (int i = 0; i < hiveNum; i++) {
    newHiveX=int(random(hiveXBuffer, width-hiveXBuffer));
    newHiveY =int(random(hiveYBuffer, height/8 * 7-hiveYBuffer));
    for (hive h : hives) {
      while (dist(h.hiveX, h.hiveY, newHiveX, newHiveY) <= buildingSize*3) {
        newHiveX=int(random(hiveXBuffer, width-hiveXBuffer));
        newHiveY =int(random(hiveYBuffer, height/8 * 7-hiveYBuffer));
      }
    }
    hives.add(new hive(newHiveX, newHiveY));
  }
}

void placeSpacing() {
  int newPlaceX, newPlaceY;
  for (int i = 0; i < hiveNum+2; i++) {
    newPlaceX=int(random(placeXBuffer, width-placeXBuffer));
    newPlaceY =int(random(placeYBuffer, height/8 * 7- placeYBuffer));
    for (place p : places) {
      while (dist(p.placeX, p.placeY, newPlaceX, newPlaceY) <= buildingSize*4) {
        newPlaceX=int(random(placeXBuffer, width-placeXBuffer));
        newPlaceY =int(random(placeYBuffer, height/8 * 7- placeYBuffer));
      }
    }
    if (i < hiveNum/5) {
      places.add(new school(newPlaceX, newPlaceY));
    } else {
      places.add(new work(newPlaceX, newPlaceY));
    }
  }
}