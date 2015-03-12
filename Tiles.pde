class Tiles {
  
  int type, index = 0;
  String col;
  boolean solid;
  PImage[] img;
  String dir, file;
  
  Tiles(int _type, String _c){
    type = _type;
    col = _c; 
    
    dir = "graphics/world-tiles/"; 
    file = "";
    
    //Assigning image directories to types
    
    switch(type) {
      
      case 0: //Empty backdrop
        assignType("graphics/world-tiles", "blank_tile", false);
        break;
      case 1: //Steel backdrop
        assignType("graphics/world-tiles", "backdrop_steel", false);
        break;
      case 2: //Steel tile
        assignType("graphics/world-tiles", "plain_steel", true);
        break;
      case 3: //Force field
        assignType("graphics/force-fields", "", false);
        break;
      case 4: //Button to change tile colour
        assignType("graphics/background-tiles", "background_change", false);
        break;
      case 5: //Player changer button
        assignType("graphics/background-tiles", "player_change", false);
        break;
      case 6: //Plain button
        assignType("graphics", "button", false);
        break;
      case 7: //Glass
        assignType("graphics/world-tiles", "glass", true);
        break;
      case 8: //"Red Access Only"
        assignType("graphics/background-tiles", "sign_1", false);
        break;
      case 9: //"Blue Access Only"
        assignType("graphics/background-tiles", "sign_2", false);
        break;
      case 10:  //"Green Access Only"
        assignType("graphics/background-tiles", "sign_3", false);
        break;
      case 11:  //horizontal blast door
        assignType("graphics/horizontal-blastdoor", "", true);
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
  private void assignType(String _dir, String _file, boolean _solid){
    dir = _dir;
    file = _file;
    solid = _solid;
  }
  
  //TODO - Allow for animated tiles
  void animate(){
    if(frameCount % 5 == 0){ 
      if(index < img.length-1){
        index ++;
      } else {
        index = 0;
      }
    }
  }
}
