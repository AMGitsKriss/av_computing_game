class ColourChanger {
  
  /* 
  After some experimentation, it seems more prudent to reload the grey image to apply a new colour
  than to try to restore the modified image to grey in code. 
  */
  
  ColourChanger(){
    //Constructor
  }
  
  File file;
  String [] files;  

  color redInverter = color(43, 204, 164); //The values to subtract from the basic grey image
//  color red = color(164, 3, 43);  <-- Actual colour value
  
  color greenInverter = color(104, 58, 140);
//  color green = color(103, 149, 67);  <-- Actual colour value
  
  color blueInverter = color(184, 93, 23);
//  color blue = color(23, 114, 184);  <-- Actual colour value
  
  
  
  //Reloading files then calling the colour change function. Called from outside.
  PImage[] spriteArray(String _col, String _dir, String _file){
    
    color tempCol;
    //loading the images
    PImage[] sprites = loadFiles(_dir, _file); 
    
    if (_col == "red")          tempCol = redInverter;
    else if (_col == "green")   tempCol = greenInverter;
    else                        tempCol = blueInverter;

    for(int i = 0; i < sprites.length; i++){
      colourChange(sprites[i], tempCol); //applying a colour change for each image
    }
    return sprites;
  }
  
  PImage[] loadFiles(String _dir, String _fileName) {
    file = new File(dataPath(sketchPath+"/"+_dir));
    files = file.list();
    PImage[] sprites;

    for (int i = files.length-1; i >= 0; i--)
    {
      //grabbing & saving file directories
      String extension = files[i].substring(files[i].length()-4, files[i].length());
      //This is case sensetive, and file extensions
      //come in both upper and lower case.
      if (!(extension.equals(".png")) && !(extension.equals(".PNG")))
      {
        if (i+1 < files.length)
        {
          //rebuilding files array to be the new length
          String [] firstPart = subset(files, 0, i);
          String [] secondPart = subset(files, i+1, files.length-i-1);
          files = concat(firstPart, secondPart);
        } 
        else 
        {
          files = subset(files, 0, i);
        }
      }
    }
    //pre-emptively making the array long enough for every .png file in the folder
    sprites = new PImage[files.length];
    for(int i = 0; i < files.length; i++){
      //applying file locations to loadimage/gallery
      if(_fileName != ""){
        //Only want a single image, not a full directory. Making it one element long
        sprites = new PImage[1];
        sprites[i] = loadImage(_dir + "/" + _fileName + ".png");
        //interrupt the loop and return. We're done here.
        return sprites;
      }
      else {
        sprites[i] = loadImage(_dir + "/" + files[i]);
      }
    }
    return sprites;
  }
  
  //this function isn't called directly from outside.
  private PImage colourChange(PImage pic, color handedColour){

    PImage tempImg = pic;
    color oldColour, newColour;
    float a, r, g, b, newA, newR, newG, newB;
    
    for (int x = 0; x < tempImg.width; x++){
      for(int y = 0; y < tempImg.height; y++){
        oldColour = tempImg.get(x, y);
        r = red(oldColour);
        g = green(oldColour);
        b = blue(oldColour);
        a = alpha(oldColour);
        //one of the many formulas for creating a sepia image
        // newC = C + RGB values of the colour
        if(r != 0 && g != 0 && b != 0 && r != 255 && g != 255 && b != 255 ){
        newR = r - red(handedColour);
        newG = g - green(handedColour);
        newB = b - blue(handedColour);
        newA = a;
        } else {
          newR = r;
          newG = g;
          newB = b;
          newA = a;
        }
        
        if (newR > 255) newR = 255;
        if (newG > 255) newG = 255;
        if (newB > 255) newB = 255;
        
        newColour = color(newR, newG, newB, newA);
        tempImg.set(x, y, newColour);
      }
    }
    return tempImg;
  }
}
