class hive {
  //shitty named location variables
  int hiveX, hiveY;
  float hiveW;
  float hiveH;
  color hiveMood;
  ArrayList<agent> hiveAgents;
  int agentCount;


  hive(int hiveX_, int hiveY_) {
    hiveX     = hiveX_;
    hiveY     = hiveY_;
    hiveW = buildingSize;
    hiveH = buildingSize;
    hiveMood = color(87, 44, 41);
    hiveAgents = new ArrayList<agent>();
    agentCount = int(random((testNum/hiveNum)-agentTolerance, (testNum/hiveNum)+agentTolerance));
  }

  void hivePopulate() {
    for (int i = 0; i < agentCount; i++) {
      agent tempAgent;
      int randomAgent = int(random(10));
      //agent constructor refers to a designated hive, a random length for their ID and a starting color (which is the same for this iteration)
      if (randomAgent <= 6) {
        tempAgent = new agent(this, int(random(1, 5)), color(148, 0, 211));
      } else if (randomAgent ==7) {
        tempAgent = new traveller(this, int(random(1, 5)), color(148, 0, 211));
      } else if (randomAgent >=8) {
        tempAgent = new nightowl(this, int(random(1, 5)), color(148, 0, 211));
      } else {
        tempAgent = new wanderer(this, int(random(1, 5)), color(219,112,147));
      }
      //println(randomAgent);
      hiveAgents.add(tempAgent);
      globalAgents.add(tempAgent);
    }
  }

  void hiveUpdate() {
    if (isMousedOver() && mousePressed) {
    hiveX = mouseX;
    hiveY = mouseY;
    }
  }

  boolean isMousedOver() {
    if (mouseX > hiveX-hiveW/2 &&
      mouseX < hiveX+hiveW/2 &&
      mouseY > hiveY-hiveH/2 &&
      mouseY < hiveY+hiveW/2) {
      return true;
    } else {
      return false;
    }
  }

  void hiveDisplay() {
    rectMode(CENTER);
    strokeWeight(2);
    stroke(buildingStroke);
    fill(hiveMood);
    rect(hiveX, hiveY, hiveW, hiveH);
  }
}