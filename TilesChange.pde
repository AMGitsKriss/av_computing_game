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

    //TODO - Possible timer after each itteration to give a gradual-change visual effect?
    
    construct(red, "red");
    construct(green, "green");
    construct(blue, "blue");
  }
  private void construct(int[] _array, String _col){
    for(int i=0;i<_array.length;i+=2){
      int temp1 = _array[i+1]; //array's i+1 = y
      int temp2 = _array[i];  //arrays i = x
      world[temp1][temp2].col = _col; //setting tile colour to _col
      //redrawing the sprites
      PImage[] temp3 = change.spriteArray(_col, world[temp1][temp2].dir, world[temp1][temp2].file);
      world[temp1][temp2].img = temp3[0];
    }
  }
}
