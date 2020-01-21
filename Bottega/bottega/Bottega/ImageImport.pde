
//Now to make the images into objects? basically they need to be interactable
class ArtObject {
  int artX, artY;
  //name for reference and for reaching the file
  String artName;
  //by using the artName String, grabbing the art Image file
  PImage artImage;


  ArtObject(int _artX, int _artY, String _artName) {
    //trying to offset the elements based on the gallery
    artX = _artX + mGallery.cX;
    artY = _artY + mGallery.cY;

    artName = _artName;
    //its gonna be one of these 3 depending on the art name?
    //println(galleryPath +artName);
    if(artName.equals(".DS_Store") || artName.equals(null)){
    } else {
    artImage = loadImage(galleryPath + artName);
    //artImage = loadImage(galleryPath + artName + ".jpg");
    //artImage = loadImage(galleryPath + "testImage.jpg");
    }
  }


  void display() {
    rectMode(CORNER);
    stroke(0);
    strokeWeight(2);
    //yes we're hard coding values, but basically its a fraction of the actual picture.
    rect(artX, artY, 120, 60);
    //println(artImage);
    image(artImage, artX, artY, 120, 60);
  }
}