class TilesChange {

  /*
  Used to produce a list of tiles to be changed when a button is pressed. Each tile in arrays red, green and 
  blue are turned to that colour. x and y represent the location of the button that will activate it. 
  */
  
  int x, y;
  int[] red;
  int[] green;
  int[] blue;
  
  TilesChange(int _x, int _y, int[] r, int[] g, int[] b){
    x = _x;
    y = _y;
    red = r;
    green = g;
    blue = b;
  }
  
  void update(){
    
    //TODO - Condense into a single loop called 3 times by a function
    
    //TODO - Possible timer after each itteration to give a gradual-change visual effect?
    
    for(int i=0;i<red.length;i+=2){
      int temp1 = red[i+1];
      int temp2 = red[i];
      String temp3 = "red";
      world[temp1][temp2].col = temp3;
      PImage[] temp4 = change.spriteArray(temp3, world[temp1][temp2].dir, world[temp1][temp2].file);
      world[temp1][temp2].img = temp4[0];
    }
    
    for(int i=0;i<green.length;i+=2){
      int temp1 = green[i+1];
      int temp2 = green[i];
      String temp3 = "green";
      world[temp1][temp2].col = temp3;
      PImage[] temp4 = change.spriteArray(temp3, world[temp1][temp2].dir, world[temp1][temp2].file);
      world[temp1][temp2].img = temp4[0];
    }
    
    for(int i=0;i<blue.length;i+=2){
      int temp1 = blue[i+1];
      int temp2 = blue[i];
      String temp3 = "blue";
      world[temp1][temp2].col = temp3;
      PImage[] temp4 = change.spriteArray(temp3, world[temp1][temp2].dir, world[temp1][temp2].file);
      world[temp1][temp2].img = temp4[0];
    }
  }
}
