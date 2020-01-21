/* //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//

 * Title: Bottega (AIRT Factory ReDux)
 *(c) 2019 Geoff Merson -- geoffmerson@gmail.com
 *
 * This application is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * If distributing the software, the source code must be available to the receipients
 * and a copy of copyright notice must be supplied with the code. Any distributions 
 * must be distributed under the GNU General Public License as well.
 * Any significant changes to this code must be noted in redistribution.
 *
 * A copy of the GNU General Public license can be found
 * included with this code or @  http://choosealicense.com/licenses/gpl-3.0/
 
 ****
 REMEMBER THAT THE DIRECTORY MANAGEMENT (File library) DEALS WITH AN ABSOLUTE PATH
 most have it coded and commented out, but always be aware
 ****
 */
 
//500 for very fast, 5000 for full image
int workTimer = 500;

//Libraries!
import processing.pdf.*;
import com.cage.colorharmony.*;
import java.io.File;


//The Key to everything
//basically once you save the first image, this will no longer be 0, and therefore won't wipe certain arrays
int FirstCount = 0;
//should the workers be auto generated? if so, how many?
boolean areWorkersGenerated = true;
int generatedWorkerCount = 6;

//trying to fiddle with color harmony
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors;

//Arrays and things
ArrayList<Element>   ImageElements;
ArrayList<Worker>    WorkerList;
ArrayList<String> imageNames;
ArrayList<ArtObject> ArtObjectList;
ArrayList<ArtObject> ArtObjectSubList0;
ArrayList<ArtObject> ArtObjectSubList1;
ArrayList<ArtObject> ArtObjectSubList2;
int offset0 = 0; 
int offset1 = 0;
int offset2 = 0;
int subList0X = 50;
int subList1X = 225;
int subList2X = 400;
int subListY  = height/4 *3;
int subListCap= 4;
//Not currently used
//ArtObject  holdOverObject;

//Pathing
String galleryPath = "../Gallery/";

float canvasWidth = 10;
//wall to separate the two 
int factoryWall = 300;
//place a limit at the end for the sake of capture and measurement
int canvasLimit = factoryWall + 300;
//Gonna do some math to figure out my factory-canvas size, as it should have been
//its scaled down version of the real thing
float pseudoCanvasHeight = (factoryWall - canvasLimit)/3;
//canvas for factory which will be based off the psuedo canvas, but needs to be setup in the setup
float canvasMaxY;
float canvasMinY;

canvas mCanvas;
gallery mGallery;
frame mBorder;

//not the canvas
int binNumber = 4;
int firstBinY = 80;
// color variables for the factory and backgrounds
color factoryCol = color(200);
color canvasCol;
color backgCol   = color(230);
//a boolean to note if the art has been captured yet
boolean recorded = false;
String fileName;
//location of factory exit
PVector exit;

// an array of bins 
Bin[] bins = new Bin[binNumber];
WorkerSelectModel model;
WorkerSelectView  view;
boolean listFinished = false;
float   startCount;
int     endTracker   = 0;
boolean addEnd       = false;



void setup() {
  size(902, 600);
  //continued fiddling with color harmony
  colors = new color[8];
  colors = colorHarmony.GetRandomPalette();
  canvasCol = color(colors[0], 50);
  //Need to setup these variables after the size has been set
  //THESE ARE THE WALL SIDE, NEED TO CORRESPOND TO THE ACTUAL CANVAS
  canvasMaxY = height/2 + (pseudoCanvasHeight/2);
  canvasMinY = height/2 - (pseudoCanvasHeight/2);
  //background starts grey for select screen
  background(backgCol);
  //exit coordinates
  exit = new PVector(factoryWall/2, - 10);

  //set some values for offsets
  offset0 = 0; 
  offset1 = 0;
  offset2 = 0;

  //make a new canvas
  mCanvas = new canvas(factoryWall, 0, canvasLimit, height/2);
  //and make a new gallery
  mGallery = new gallery(factoryWall, height/2, canvasLimit, height);
  // make a new frame on the right side to cut things off
  mBorder = new frame(900, 0, 100, height);
  //try this too?
  ImageElements = new ArrayList<Element>();
  ArtObjectList = new ArrayList<ArtObject>();
  ArtObjectSubList0 = new ArrayList<ArtObject>();
  ArtObjectSubList1 = new ArrayList<ArtObject>();
  ArtObjectSubList2 = new ArrayList<ArtObject>();

  imageNames    = new ArrayList<String>();
  //bring the files in
  importFilesToArray();

  if (FirstCount == 0) {
    //these are the things that should only be done the first time
    //initialize arrayLists
    WorkerList    = new ArrayList<Worker>();
    //add the hold over
    //holdOverObject = new ArtObject(subList0X, height/8 *7, "");
  }
  printArray(imageNames);
  wipeArrays();
  wipeArrays();
  println("post wipe arrays : " + ArtObjectSubList0.size() + " , " + ArtObjectSubList1.size() + " , " + ArtObjectSubList2.size());
  convertImageNamesToArtObjectsOnStart();
  printArray(ArtObjectList);
  inWhichPileOnStart();
  println("post delegation : " + ArtObjectSubList0.size() + " , " + ArtObjectSubList1.size() + " , " + ArtObjectSubList2.size());
  println("-------------");
  //set variables for the possibility of replaying
  startCount = frameCount;

  // very important that bin creation goes before worker initialization
  binCreator();

  model = new WorkerSelectModel();
  view  = new WorkerSelectView(model);
  view.goFlagged = false;
  recorded = false;
}


void draw() {
  if (listFinished) {
    background(factoryCol);
    //canvas appearing behind the elements
    mCanvas.display();
    runElements();
    //gallery appearing in front of the elements as to cut them off
    mGallery.display();
    mBorder.display();

    //factory floor
    rectMode(CORNER);
    fill(factoryCol);
    strokeWeight(2);
    stroke(0);
    //this is the factory rectangle itself
    rect(0, 0, factoryWall, height);

    //workers getting specific instructions now will later be put in array
    for (Worker w : WorkerList) {
      w.display();
      w.update();
    }
    for (int i= 0; i < WorkerList.size(); i ++) {
      Worker wrkr = WorkerList.get(i);
      if (wrkr.position.y < 0) {
        WorkerList.remove(wrkr);
      }
    }
    displayFactoryCanvas();
    fill(215);
    ellipse(exit.x, 0, 60, 25);
    ellipse(exit.x, height, 60, 25);
    //try here?
    displayImages();

    for (int i = 0; i < binNumber; i++) {
      bins[i].display();
    }
    if (WorkerList.size() == 0) {
      if (!recorded) {
        finalSteps();
        // code for cropped screencap found here
        //https://processing.org/discourse/beta/num_1228439740.html
        //moving this to the workerMod tab under canvas
        //PImage img  =get(int(factoryWall)+2, 0, int(canvasLimit)-2, height);
        mCanvas.capture();
        recorded = true;
        setup();
        listFinished = false;
        FirstCount = 1;
        wipeArrays();
        listFinished = false;
      }
    }
    //display already generated images
  } else if (!listFinished && !areWorkersGenerated) {
    background(backgCol);
    view.display();
  } else {
    workerGeneration();
  }
}

void finalSteps() {
  checkIfListFull(ArtObjectSubList0);
  checkIfListFull(ArtObjectSubList1);
  checkIfListFull(ArtObjectSubList2);
}

//keeps track and displays all elements already in array
void runElements() {
  //looks like element 0 does not run for now. must fix.------------------------------------
  for (int i = 0; i < ImageElements.size(); i++) {
    Element imgElem = ImageElements.get(i);
    imgElem.display();
  }
}

void displayImages() {
  for (int ao0 = 0; ao0 < ArtObjectSubList0.size(); ao0++) {
    ArtObjectSubList0.get(ao0).display();
  }
  for (int ao1 = 0; ao1 < ArtObjectSubList1.size(); ao1++) {
    ArtObjectSubList1.get(ao1).display();
  }
  for (int ao2 = 0; ao2 < ArtObjectSubList2.size(); ao2++) {
    ArtObjectSubList2.get(ao2).display();
  }
}

void keyPressed() {
  if (key == 'a') {
    println("At Run Time : " + ArtObjectSubList0.size() + " , " + ArtObjectSubList1.size() + " , " + ArtObjectSubList2.size());
  }
}

String fileName() {
  //code modified from here 
  //https://forum.processing.org/one/topic/random-text.html
  String total = colorHarmony.GetBaseColor() +"-";
  for (int i = 0; i < WorkerList.size(); i++)
  {
    char c = (char) int(random(97, 123));
    total += c;
  }
  return total;
}

String dirName() {
  //code modified from here 
  //https://forum.processing.org/one/topic/random-text.html
  String total = "";
  for (int i = 0; i < 4; i++)
  {
    char c = (char) int(random(97, 123));
    total += c;
  }
  return total;
}

//show a pseudo canvas on screen
void displayFactoryCanvas() {
  rectMode(RECT);
  strokeWeight(1);
  stroke(0);
  fill(canvasCol);
  //offset the canvas enough from the wall so that it appears like it it resting on the wall, not going through it
  rect(factoryWall - canvasWidth, canvasMinY, factoryWall, canvasMaxY);
}

void displayGalleryFloor() {
  rectMode(CENTER);
  strokeWeight(1);
  stroke(0);
  fill(100);
  float pseudoCanvasHeight = (factoryWall - canvasLimit)/3;
  rect(factoryWall - canvasWidth/2, height/2, canvasWidth, pseudoCanvasHeight);
}


void mousePressed() {
  for (SelectSquare s : view.squares) {
    s.mousePressed();
  }
  view.mousePressed();
}


void workerGeneration() {
  for (int j = 0; j < generatedWorkerCount; j++) {
    int rng = floor(random(0, 4));
    if (rng == 0) {
      WorkerList.add(new Base());
    } else if (rng == 1) {
      WorkerList.add(new Happy());
    } else if (rng == 2) {
      WorkerList.add(new SlowNSteady());
    } else if (rng == 3) {
      WorkerList.add(new Wander());
    }
  }
  listFinished = true;
  fileName = fileName();
}


void binCreator() {
  int counter = 0;
  for (int i = 0; i < binNumber; i++) {
    if (counter == 0) {
      bins[i] = new SplatterDotBin(i+1);
    } else if (counter == 1) {
      bins[i] = new BoxBin(i+1);
    } else if (counter == 2) {
      bins[i] = new SplatterBoxBin(i+1);
    } else if (counter == 3) {
      bins[i] = new SplatterBin(i+1);
    } else if (counter == 4) {
      bins[i] = new  SplatterBin(i+1);
    } else if (counter == 5) {
      bins[i] = new SplatterBin(i+1);
      counter = 0;
    } 
    //initialize model and view for select screen

    counter ++;

    // print what kinds of bins we have on screen
    //println(i + ":  y : " + bins[i].y + "init  " + bins[i].type);
  }
}

void wipeArrays() {
  //ImageElements
  for (int ie = 0; ie < ImageElements.size(); ie++) {
    ImageElements.remove(ie);
  }
  //WorkerList
  for (int wl = 0; wl < WorkerList.size(); wl++) {
    WorkerList.remove(wl);
  }
  //imageNames
  //just kidding, we don't wipe that one
  for (int aol = 0; aol < ArtObjectList.size(); aol++) {
    ArtObjectList.remove(aol);
  }
  /*
  //Sublists
   for (int sl0 = 0; sl0 < ArtObjectSubList0.size(); sl0++) {
   ArtObjectSubList0.remove(sl0);
   }
   for (int sl1 = 0; sl1 < ArtObjectSubList1.size(); sl1++) {
   ArtObjectSubList1.remove(sl1);
   }
   for (int sl2 = 0; sl2 < ArtObjectSubList2.size(); sl2++) {
   ArtObjectSubList2.remove(sl2);
   }
   */
}

/*
 * Title: The A[I]rt Factory
 * Description: Art spelled with an A.I.
 *(c) 2016 Geoff Merson -- geoffmerson@gmail.com
 *
 * This application is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * If distributing the software, the source code must be available to the receipients
 * and a copy of copyright notice must be supplied with the code. Any distributions 
 * must be distributed under the GNU General Public License as well.
 * Any significant changes to this code must be noted in redistribution.
 *
 * A copy of the GNU General Public license can be found
 * included with this code or @  http://choosealicense.com/licenses/gpl-3.0/
 *
 */