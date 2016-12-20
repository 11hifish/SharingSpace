/**
 * Loop. 
 * 
 * Shows how to load and play a QuickTime movie file.  
 *
 */
float W_H_Ratio = 2592.0/1944.0;
import processing.video.*;

Movie movie;
boolean start = true;
PImage myImage = new PImage();

void setup() {
  size(1280, 720);
  background(255);
  // Load and play the video in a loop
  movie = new Movie(this, "MOV1.mov");
  movie.speed(.25);
  movie.play();
  smooth();
}

boolean isNotEmpty(PImage image) {
  return ((image.width > 0) && (image.height > 0));
}

void draw() {
  int count = 1;
  String format = ".tif";
  float mtNew = 0;
  float mtStored = -1;
  boolean doStore = false;
  
  while (movie.time() <= movie.duration()) {
    if (movie.available()) {
      movie.read();
      myImage = movie.copy();
      myImage.resize(750,500);
      doStore = true;
    }
    mtStored = mtNew;
    mtNew = movie.time();
    background(0);
    pushMatrix();
    translate(width/2, height/2);
    //rotate(radians(180.0));//+noiseVal));
    scale(1.4);
    imageMode(CENTER);
    if (isNotEmpty(myImage)) {
      pointAllize(myImage,count);
    }
    popMatrix();
    if(doStore){
      saveFrame("frame" + id(count) + format);
      count++;
    }
    doStore = false;
 }
 exit();
}

String id(int count){
  int digs = int(log(count)/ log(10));
  int zeros = 3 - digs;
  String zeros_str = "";
  for(int step = 0; step < zeros; step++){
    zeros_str += "0";
  }
  return zeros_str + str(count);
}