 //<>// //<>// //<>//
void importFilesToArray() {
  //SO THIS IS BAD BUT IT NEEDS A VERY ABSOLUTE PATH

  //This is my windows absolute address
  String[] filenames = listFileNames("G:/Actual work on this computer/Concordia-Winter2019/bottega/Gallery");

  //This is my mac absolute address 
  //String[] filenames = listFileNames("../geoff/GitProjects/bottega/Gallery");
  for (int fns = 0; fns <filenames.length; fns++) {
    if (filenames[fns].equals(".DS_Store")) {
    } else {
      //println(filenames[fns]);
      imageNames.add(filenames[fns]);
    }
  }
}

void convertImageNamesToArtObjectsOnStart() {
  for (int in = 0; in <imageNames.size(); in++) {
    if (imageNames.get(in).equals(".DS_Store")) {
    } else {
      ArtObjectList.add(new ArtObject(0, 0, imageNames.get(in)));
    }
    //increase pile displace by an arbitrary number
  }
}

//and now insert the objects into the arrays on the fly
//this one is actually the dead one
/*void importAndConvertSingleFile(String newFile) {
 imageNames.add(newFile);
 ArtObjectList.add(new ArtObject(100, 50, newFile));
 }*/
int ASLCount = 0;


void inWhichPileOnStart() {
  int OffsetValue = 5;
  // Basically sort the images into piles based on the max cap.*/
  for (int sl = 0; sl < ArtObjectList.size(); sl ++) {
    println(ArtObjectList.get(sl).artName);
    if (ASLCount == 0) {
      if ( ArtObjectSubList0.size() < subListCap) {
        ArtObjectSubList0.add(new ArtObject(subList0X + offset0, subListY+ offset0, ArtObjectList.get(sl).artName));
        offset0+= OffsetValue;
      }
    }
    if (ASLCount == 1) {
      if ( ArtObjectSubList1.size() < subListCap) {
        ArtObjectSubList1.add(new ArtObject(subList1X + offset1, subListY+ offset1, ArtObjectList.get(sl).artName));
        offset1+= OffsetValue;
      }
    } 
    if (ASLCount == 2) {
      if ( ArtObjectSubList2.size() < subListCap) {
        ArtObjectSubList2.add(new ArtObject(subList2X + offset2, subListY+ offset2, ArtObjectList.get(sl).artName));
        offset2+= OffsetValue;
      }
    }
    //----
    ASLCount ++;
    if (ASLCount > 2) {
      ASLCount =0;
    }
    println(ASLCount);
    //----
  }
}


// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}