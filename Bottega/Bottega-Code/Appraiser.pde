
void moveFullSubList(ArrayList<ArtObject> fullList) {
  String uniqueDir = dirName();
  //windows
  File newfile = new File("G:/Actual work on this computer/Concordia-Winter2019/bottega/Collection-" +uniqueDir + "/");
  //This is my mac absolute address 
  //File file = new File("../geoff/GitProjects/bottega/Collection-" +uniqueDir + "/"");

  if (!newfile.exists()) {
    if (newfile.mkdir()) {
      System.out.println("Directory is created!");
    } else {
      System.out.println("Failed to create directory!");
    }
  }

  for (int fl = 0; fl < fullList.size(); fl++) {
    File ff = new File ("G:/Actual work on this computer/Concordia-Winter2019/bottega/Gallery/"+ fullList.get(fl).artName);
    ff.renameTo(new File (newfile + "/" + fullList.get(fl).artName));
  }
}


void checkIfListFull(ArrayList<ArtObject> listInQ) {
  if (listInQ.size() >= subListCap) {
    moveFullSubList(listInQ);
  }
}


//This should only work for a Max Cap of 4, any different and the work will need to be changed up
void compareSubListStrings(ArrayList<ArtObject> currentArray) {
  //String filepath = "../geoff/GitProjects/bottega/Gallery";

  if (currentArray.size() >= subListCap) {
    String startString = currentArray.get(0).artName;
    startString = startString.substring(0, 6);
    float slot1Dif =0;
    float slot2Dif =0;
    float slot3Dif =0;
    slot1Dif= abs(startString.compareTo(currentArray.get(1).artName.substring(0, 6))); 
    slot2Dif= abs(startString.compareTo(currentArray.get(2).artName.substring(0, 6)));
    slot3Dif= abs(startString.compareTo(currentArray.get(3).artName.substring(0, 6)));

    println("the difs are: " + slot1Dif + ", " + slot2Dif + ", " + slot3Dif);

    ////If the first one has the greatest difference
    //if ( slot1Dif > slot2Dif && slot1Dif > slot3Dif) {
    //  File f = new File(galleryPath + currentArray.get(1).artName);
    //  println(f);
    //  if (f.exists()) {
    //    f.delete();
    //  }
    //  println("removed! 1");
    //}

    ////if the second one has the greatest difference
    //if ( slot2Dif > slot1Dif && slot2Dif > slot3Dif) {
    //  currentArray.remove(2);
    //  println("removed! 2 ");
    //}

    ////if the third one has the greatest difference
    //if ( slot3Dif > slot2Dif && slot3Dif > slot1Dif) {
    //  File f = new File(galleryPath + currentArray.get(3).artName);
    //  println(f);
    //  if (f.exists()) {
    //    f.delete();
    //  }
    //  currentArray.remove(3);
    //  println("removed! 3");
    //}
  }
}