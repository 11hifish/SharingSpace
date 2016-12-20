void pointAllize(PImage toPoint,int count2){
  // Look up the RGB color in the source image
  PImage img = toPoint;
  int layers = 40;
  int space = int((img.height/2)/layers);
  PVector center = new PVector(img.width/2.0,img.height/2.0);
  img.loadPixels();
  for(int layer = 0; layer < layers; layer ++){
    int count = layer*6 + 1;
    float startAngle = 180.0 * (noise(count2/1000.0,layer) * 2.0 - 1.0);
    float angleStep = 360.0/float(count);
    int r = space * layer;
    for(int step = 0; step < count; step++){
      PVector loc = PVector.fromAngle(radians(float(step)*angleStep + startAngle));
      showPixelAtLoc(PVector.add(loc.mult(float(r)),center),img);
    }
  }
/*  int space = int(img.height/rows);
    int startx = int((img.width - space * cols)/2);
    int starty = int((img.height - space * rows)/2);
    int rows = 40;
    int cols = 40;
    for(int row = 0; row < rows; row++){
    for(int col = 0; col < cols; col++){
      int x = int((col+.5)*space)+startx;
      int y = int((row+.5)*space)+starty;
      showPixelAtLoc(x, y, img);
    }
  } */
}

void showPixelAtLoc(PVector loc, PImage img){
  showPixelAtLoc(loc.x,loc.y,img);
} 

void showPixelAtLoc(float x, float y, PImage img){
    int pixelRad = 4;
    int loc = int(x) + int(y)*img.width;
    float r = red(img.pixels[loc]);
    float g = green(img.pixels[loc]);
    float b = blue(img.pixels[loc]);
    /*
    float mag = opencv.getFlowAt(int(x),int(y)).mag();
    if(mag > 3.0 && mag < 10){
      fill(255);//pow(((r+g+b)/3/255),.1)*255);
    } else { */
      fill(r,g,b);
//    }
    noStroke();
  
    // Draw an ellipse at that location with that color
    
    ellipse(x - img.width/2.0,y - img.height/2.0,pixelRad,pixelRad);
}
  