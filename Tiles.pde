class Tiles {
  
  int type, index = 0; //type is tile ID | index is the current animation frame
  String col;
  boolean solid, autoCycle; //autoCycle determines if the player has to interact to animate it
  PImage[] img;
  String dir, file;
  
  Tiles(int _type, String _c){
    type = _type;
    col = _c; 
    
    dir = "graphics/world-tiles/"; 
    file = "";
    
    //Assigning image directories to types
    
    switch(type) {
      
      /*
      assignType(String _dir, String _file, boolean _solid, boolean _cycle);
      */
      
      case 0: //Empty backdrop
        assignType("graphics/world-tiles", "blank_tile", false, true);
        break;
      case 1: //Steel backdrop
        assignType("graphics/world-tiles", "backdrop_steel", false, true);
        break;
      case 2: //Steel tile
        assignType("graphics/world-tiles", "plain_steel", true, true);
        break;
      case 3: //Force field
        assignType("graphics/force-fields", "", false, true);
        break;
      case 4: //Button to change tile colour
        assignType("graphics/background-tiles", "background_change", false, true);
        break;
      case 5: //Player changer button
        assignType("graphics/background-tiles", "player_change", false, true);
        break;
      case 6: //Gravity Sign
        assignType("graphics/background-tiles", "sign_4", false, false);
        break;
      case 7: //Glass
        assignType("graphics/world-tiles", "glass", true, true);
        break;
      case 8: //"Red Access Only"
        assignType("graphics/background-tiles", "sign_1", false, true);
        break;
      case 9: //"Blue Access Only"
        assignType("graphics/background-tiles", "sign_2", false, true);
        break;
      case 10:  //"Green Access Only"
        assignType("graphics/background-tiles", "sign_3", false, true);
        break;
      case 11:  //horizontal blast door
        assignType("graphics/horizontal-blastdoor", "", true, false);
        break;
    }
    
    
    
    //Assigning Colours
    if(col == "red"){
      // Handing the colour changer the desired colour, directory, and file name.
    img = change.spriteArray("red", dir, file);
      //img = temp[0];
    }
    else if(col == "green"){
    img = change.spriteArray("green", dir, file);
      //img = temp[0];
    }
    else if(col == "blue"){
    img = change.spriteArray("blue", dir, file);
    //img = temp[0];
    }
    else {
    img = change.loadFiles(dir, file);
      //img = temp[0];
    }
    
  }
  
  //Assigning the values from the Switch statement
  private void assignType(String _dir, String _file, boolean _solid, boolean _cycle){
    dir = _dir;
    file = _file;
    solid = _solid;
    autoCycle = _cycle;
  }
  
  //Animates tiles that don't need player interaction. Tiles that will animate on their own
  void animate(){
    if(frameCount % 4 == 0 && autoCycle){ 
      if(index < img.length-1){
        index ++;
      } else {
        index = 0;
      }
    } else {
      if(index >= img.length){
        index = 0;
      }
    }
  }
}
