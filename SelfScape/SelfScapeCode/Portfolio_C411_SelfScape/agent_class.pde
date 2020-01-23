class agent {
  //slightly less terribly named location variables
  float x;
  float y;
  hive agentHome;
  place agentPlace;
  //phsyical attributes
  float aSize;
  float baseSize;
  float aSpeed;
  float baseSpeed;
  float depSpeed;
  float anxSpeed;
  color aColor;
  color aStroke;
  int   aFade =255;
  //Psych attributes
  float aStateVal;
  //how much energy the agent has
  float aEnergy;
  //how stressed and big the agent will be
  int aStress;
  //how faded the agent will be
  int aDepress;
  //how fast the agent will move and burn energy
  int aAnxiety;
  //can they get something?
  boolean isVulnerable = true;
  float energyBurn = 1;
  float baseBurn   = energyBurn;
  //generation of a unique ID for the agents
  String ID;
  String type;


  agent(hive aHome, int random, color _color) {
    agentHome   = aHome;
    x           = aHome.hiveX;
    y           = aHome.hiveY;
    agentPlace  = choosePlace();
    aSize       = random(10, 15);
    baseSize    = aSize;
    aSpeed      = random(1, 3.0);
    baseSpeed   = aSpeed;
    depSpeed    = aSpeed/2;
    anxSpeed    = aSpeed*1.5;
    aColor      = _color;
    aStroke     = color(250, 250, 1);
    aEnergy     =100;

    /*
     //StateVal works as follows
     High StateVal is bad
     low StateVal is good
     stateval can go under 0, this is the happy go lucky, unbreakable agent
     stateVal cannot exceed 10?
     a value of 10 will cause the agent to gain a secondary characteristic
     their stateval will then be lowered to 0
     an affected agent may lose their affect if they attatin -10 stateval
     */
    aStateVal=random(-5, -2);

    aStress  =0;
    aDepress =0;
    aAnxiety =0;
    ID       = IDGenerate(int(random(random, 7)));
    type     = "agent";
    energyBurn = int(random(1, 2));
  }

  String IDGenerate(int IDLength) {
    String tempID ="";
    for (int i = 0; i <IDLength; i++) {
      tempID += (char((int(random(65, 127)))));
    }
    return tempID;
  }
  place choosePlace() {
    int tempPlace = int(random(places.size()));
    return places.get(tempPlace);
  }



  void showNetwork() {
    if (test) {
      if (agentHome.isMousedOver()) {
        strokeWeight(5);
        stroke(0, 150, 255);
      }
      /*if (type == "traveller") {
       stroke(5);
       stroke(150, 0, 170);
       }*/
      aStroke=color(255, 240, 0);
      line(agentHome.hiveX, agentHome.hiveY, agentPlace.placeX, agentPlace.placeY);
    }
  }

  void agentDisplay() {
    aFade=int(map(aEnergy, 0, 100, 255, 25));
    if (agentHome.isMousedOver()) {
      stroke(aStroke);
    } else {
      stroke(buildingStroke);
    }
    fill(aColor, aFade);
    strokeWeight(2);
    ellipse(x, y, aSize, aSize);
  }


  void agentUpdate() {
    showNetwork();
    navigate();
    testRead();
    psychUpdate();
    interact();
  }

  void interact() {
    for (agent o : globalAgents) {
      if (o.ID != this.ID && dist(o.x, o.y, this.x, this.y) < aSize*1.25) {
        if (o.agentHome == this.agentHome) {
          if (o.aStateVal > this.aStateVal) {
            adjustState(.46);
            //println(ID +" has interacted with " + o.ID + " negatively");
          } else {
            adjustState(-.7);
            if (aEnergy<100) {
              aEnergy += baseBurn*4;
            }
            //println(ID +" has interacted with " + o.ID + " positively");
          }
        } else {
          if (o.aStateVal > this.aStateVal) {
            adjustState(.41);
            //println(ID +" has interacted with " + o.ID + " negatively");
          } else {
            adjustState(-.55);
            if (aEnergy<100) {
              aEnergy   += baseBurn*2;
            }
            //println(ID +" has interacted with " + o.ID + " positively");
          }
        }
      }
    }
  }

  void adjustState(float change) {
    if ( aStateVal <= 10 && aStateVal >= -10) {
      aStateVal += random(change/2, change);
    }
    if (aStateVal > 10) {
      aStateVal =10;
    }
    if (aStateVal < -10) {
      aStateVal =-10;
    }
  }

  void agentBind() {
    if (y > height) {
      y = height;
    }
    if (y < 0) {
      y = 0;
    }
    if (x > width) {
      x = width;
    }
    if (x < 0) {
      x = 0;
    }
  }

  void navigate() {
    if (aEnergy > 1) {
      if (!isFading) {
        // x+=(random(-aSpeed*1.5, aSpeed*1.5));
        //  y+=(random(-aSpeed*1.5, aSpeed*1.5));
        goPlace();
      } else {
        goHome();
      }
      expendEnergy();
    }
    agentBind();
  }

  void expendEnergy() {
    if (dist(x, y, agentHome.hiveX, agentHome.hiveY) < buildingSize) {
      if (aEnergy < 100) {
        aEnergy += .05;
      }
    } else {
      if (aEnergy > 1) {
        aEnergy -=  energyBurn*.3;
      }
    }
  }

  void testRead() {
    //if (dist(mouseX, mouseY, x, y) < aSize) {
    // println("Agent " + ID +" has " + aStateVal +"stateVal");
    // }
  }

  void psychUpdate() {
    if (aStress == 1) {
      aSize = 1.25*baseSize;
      aColor = color(225, 60, 0);
      energyBurn = baseBurn*2;
    } else if (aStress == 2) {
      aSize = 1.5*baseSize;
    }

    if (aDepress == 1) {
      aSpeed = depSpeed;
      aSize  = baseSize*.75;
      energyBurn = baseBurn*2.5;
      aColor = color(0, 255, 0);
    }

    if (aAnxiety == 1) {
      aSpeed = anxSpeed;
      energyBurn = baseBurn*4;
      aColor = color(0, 0, 255);
    }

    if (aAnxiety ==0 && aDepress ==0 && aStress ==0) {
      aSpeed = baseSpeed;
      aSize = baseSize;
    }

    if (aEnergy < 2) {
      adjustState(1);
    }
    if (aEnergy >98) {
      adjustState(-0.1);
    }

    if (aStateVal >= 9.5 && isVulnerable) {
      int rng = int(random(5));
      if (rng == 2) {
        aStress  ++;
      } else if (rng == 3) {
        aAnxiety ++;
      } else if (rng == 4) {
        aDepress ++;
      }
      isVulnerable = false;
      aStateVal = 3;
      //aEnergy+=5;
      //println("sadbump");
    }

    if (aStateVal <= -9.5 && !isVulnerable) {
      if (aStress  >0) {
        aStress--;
        println("ping");
      }
      if (aAnxiety >0) {
        aAnxiety--;
        println("ping");
      }
      if (aDepress >0) {
        aDepress--;
        println("ping");
      }
      isVulnerable = true;
      aStateVal = -3;
      //aEnergy+=5;
      //println("happybump");
    }
  }


  void goHome() {
    if (dist(x, y, agentHome.hiveX + agentHome.hiveW, agentHome.hiveY +agentHome.hiveY) > 1) {
      float boost = map(aEnergy, 0, 100, .1, .75);
      if (x < agentHome.hiveX) {
        x+=(random(aSpeed/2, aSpeed+boost));
      } else if (x > agentHome.hiveX) {
        x-=(random(aSpeed/2, aSpeed+boost));
      }
      if (y < agentHome.hiveY) {
        y+=(random(aSpeed/2, aSpeed+boost));
      } else if (y > agentHome.hiveY) {
        y-=(random(aSpeed/2, aSpeed+boost));
      }
    }
  }

  void goPlace() {
    if (dist(x, y, agentPlace.placeX + agentPlace.placeW, agentPlace.placeY + agentPlace.placeW) > 1 ) {
      float boost = map(aEnergy, 0, 100, .1, .5);
      if (x < agentPlace.placeX-agentPlace.placeW/6) {
        x+=(random(aSpeed/2 -boost, aSpeed+boost));
      } else if (x > agentPlace.placeX+agentPlace.placeW/6) {
        x-=(random(aSpeed/2 -boost, aSpeed+boost));
      }
      if (y < agentPlace.placeY -agentPlace.placeW/6) {
        y+=(random(aSpeed/2 -boost, aSpeed+boost));
      } else if (y > agentPlace.placeY +agentPlace.placeW/6) {
        y-=(random(aSpeed/2 -boost, aSpeed+boost));
      }
    }
  }
}

class traveller extends agent {

  traveller( hive aHome, int random, color _color) {
    super(aHome, random, _color);
    type = "traveller";
  }

  void agentUpdate() {
    navigate();
    agentBind();
    testRead();
    psychUpdate();
    interact();
    travel();
  }

  void travel() {
    if (dist(this.x, this.y, agentHome.hiveX, agentHome.hiveY) < buildingSize) {
      agentPlace = choosePlace();
    }
  }

  void agentDisplay() {
    aFade=int(map(aEnergy, 0, 100, 255, 25));

    if (agentHome.isMousedOver()) {
      stroke(aStroke);
    } else {
      stroke(buildingStroke);
    }    
    fill(aColor, aFade);
    strokeWeight(2);
    rectMode(CENTER);
    rect(x, y, aSize, aSize);
  }
}


class nightowl extends agent {

  nightowl(hive aHome, int random, color _color) {
    super(aHome, random, _color);
    aSpeed      = random(1.5, 3);
    type        = "nightowl";
  }

  void navigate() {
    if (aEnergy > 1) {
      if (!isFading) {
        // x+=(random(-aSpeed*1.5, aSpeed*1.5));
        //  y+=(random(-aSpeed*1.5, aSpeed*1.5));
        goHome();
      } else {
        goPlace();
      }
      expendEnergy();
    }
  }

  void agentDisplay() {
    aFade=int(map(aEnergy, 0, 100, 255, 25));

    if (agentHome.isMousedOver()) {
      stroke(aStroke);
    } else {
      stroke(buildingStroke);
    }    
    fill(aColor, aFade);
    strokeWeight(2);
    rectMode(CENTER);
    ellipse(x, y, aSize, aSize);
    fill(0, aFade);
    ellipse(x, y, aSize/2, aSize/2);
  }
}

class wanderer extends  agent {
  boolean alternate;

  wanderer(hive aHome, int random, color _color) {
    super(aHome, random, _color);
    aSpeed      = .25;
    aSize       = 4;
    type        = "wanderer";
    aEnergy     = 40;
    alternate =true;
  }

  void navigate() {
    if (aEnergy > 1) {
      if (!isFading) {
        rescue();
      } else {
        goHome();
      }
    }
    aStateVal = -2;
  }

  void rescue() {
    for (agent ai : agentHome.hiveAgents) {
      if (ai.aEnergy < 5) {
        if (dist(ai.x, ai.y, this.x, this.y)<buildingSize*2) {
          if (this.x < ai.x) {
            this.x+=.2;
          } else if (this.x > ai.x) {
            this.x-=.2;
          }
          if (this.y < ai.y) {
            this.y+=.2;
          } else if (this.y > ai.y) {
            this.y-=.2;
          }
        } else {
          goHome();
        }
      }
    }
  }

  void agentDisplay() {
    aFade=int(map(aEnergy, 0, 100, 255, 25));

    if (agentHome.isMousedOver()) {
      stroke(aStroke);
    } else {
      stroke(buildingStroke);
    }
    if (alternate) {
      fill(255, 0, 0, aFade);
    } else {
      fill(0, 0, 255, aFade);
    }
    strokeWeight(2);
    rectMode(CENTER);
    ellipse(x, y, aSize, aSize);
    fill(0, aFade);
    ellipse(x, y, aSize/2, aSize/2);
    alternate = !alternate;
  }
}