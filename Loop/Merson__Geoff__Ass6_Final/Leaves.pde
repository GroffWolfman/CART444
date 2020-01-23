// ---- THE TAB FOR THE LEAVES ---- //

//a function to draw the leaves
void drawLeaves() {
  //if progress is greater or equal to one and endMemory is false
  if (progress >= 1 && endMemory == false) {
    //increase the opacity
    leafOpacity += 2;
    //if it is greater than two
    if (progress >= 2) {
      //decrease the color values until they reach black
      red -= colChange;
      green -= colChange;
      blue -= colChange;
    } 

    //use the opacity and color values to color the leaves
    fill(red, green, blue, leafOpacity);
    //remove the stroke
    noStroke();
    // --- LEAVES --- //
    //each leaf is a custom shape,
    //all are based on the original storyboard drawing
    //leaf 1
    beginShape();
    vertex(0, 108);
    vertex(18, 129);
    vertex(21, 139);
    vertex(18, 152);
    vertex(23, 156);
    vertex(27, 154);
    vertex(31, 142);
    vertex(41, 135);
    vertex(61, 135);
    vertex(109, 140);
    vertex(87, 160);
    vertex(39, 167);
    vertex(18, 174);
    vertex(13, 181);
    vertex(39, 181);
    vertex(66, 188);
    vertex(108, 211);
    vertex(93, 217);
    vertex(0, 205);
    endShape(CLOSE);

    //leaf 2
    beginShape();
    vertex(41, 0);
    vertex(31, 12);
    vertex(31, 37);
    vertex(45, 71);
    vertex(45, 80);
    vertex(50, 71);
    vertex(65, 65);
    vertex(82, 51);
    vertex(87, 59);
    vertex(98, 47);
    vertex(104, 65);
    vertex(131, 91);
    vertex(195, 102);
    vertex(190, 94);
    vertex(195, 102);
    vertex(190, 94);
    vertex(190, 75);
    vertex(178, 44);
    vertex(208, 51);
    vertex(213, 48);
    vertex(233, 51);
    vertex(239, 60);
    vertex(233, 40);
    vertex(202, 0);
    endShape(CLOSE);

    //leaf 3
    beginShape();
    vertex(237, 0);
    vertex(239, 18);
    vertex(253, 36);
    vertex(257, 55);
    vertex(274, 23);
    vertex(281, 0);
    vertex(291, 33);
    vertex(318, 47);
    vertex(333, 56);
    vertex(353, 64);
    vertex(346, 58);
    vertex(342, 41);
    vertex(338, 34);
    vertex(338, 24);
    vertex(327, 0);
    endShape(CLOSE);

    //leaf 4
    beginShape();
    vertex(428, 42);
    vertex(434, 59);
    vertex(433, 64);
    vertex(428, 55);
    vertex(418, 49);
    vertex(408, 49);
    vertex(394, 56);
    vertex(392, 63);
    vertex(387, 63);
    vertex(382, 76);
    vertex(385, 80);
    vertex(385, 90);
    vertex(389, 94);
    vertex(406, 104);
    vertex(404, 112);
    vertex(412, 125);
    vertex(413, 114);
    vertex(411, 110);
    vertex(415, 107);
    vertex(420, 97);
    vertex(418, 92);
    vertex(424, 88);
    vertex(424, 80);
    vertex(439, 65);
    vertex(442, 57);
    vertex(437, 57);
    vertex(435, 42);
    endShape(CLOSE);

    //leaf 5
    beginShape();
    vertex(379, 0);
    vertex(388, 25);
    vertex(408, 40);
    vertex(439, 45);
    vertex(448, 21);
    vertex(436, 0);
    endShape(CLOSE);
    //otherwise, if progress is greater or equal to one and s7P3's opacity is greater or equal to 240,
  } else if (progress >= 1 && s7P3.opacity >= 240) {
    //decrease the leaf opacity
    leafOpacity -= 2;
  }
  //if leafOpacity reaches its limit,
  if (leafOpacity >= 255) {
    //keep it there
    leafOpacity = 255;
  }
}

