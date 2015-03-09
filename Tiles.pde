class Tiles {
  
  int type;
  String col;
  boolean solid;
  PImage img;
  String dir, file;
  
  //TODO - Replace with Switch Statement and an assign(dir, file, solid) function.
  
  Tiles(int _type, String _c){
    type = _type;
    col = _c; 
    
    dir = "graphics/world-tiles/"; 
    file = "";
    
    //Assigning image directories to types
    
    //Empty backdrop
    if(type == 0){
      dir = "graphics/world-tiles";
      file = "blank_tile";
      solid = false;
    }
    if(type == 1){
      dir = "graphics/world-tiles";
      file = "backdrop_steel";
      solid = false;
    }
    //Steel Tile
    else if(type == 2){
      dir = "graphics/world-tiles"; 
      file = "plain_steel";
      solid = true;
    }
    //Force Field
    else if(type == 3){
      dir = "graphics/force-fields";
      file = "force_shield_1";
      solid = false;
    }
    //Backgroudn Change Button
    else if(type == 4){
      dir = "graphics/background-tiles";
      file = "background_change";
      solid = false;
    }
    //Player Changer Button
    else if(type == 5){
      dir = "graphics/background-tiles";
      file = "player_change";
      solid = false;
    }
    //Button
    else if(type == 6){
      dir = "graphics/";
      file = "button";
      solid = false;
    }
    //Glass
    else if(type == 7){
      dir = "graphics/world-tiles";
      file = "glass";
      solid = true;
    }
    //"Red Access Only"
    else if(type == 8){
      dir = "graphics/background-tiles";
      file = "sign_1";
      solid = false;
    }
    //"Blue Access Only"
    else if(type == 9){
      dir = "graphics/background-tiles";
      file = "sign_2";
      solid = false;
    }
    //"Green Access Only"
    else if(type == 10){
      dir = "graphics/background-tiles";
      file = "sign_3";
      solid = false;
    }
    //Horiz Blast Door
    else if(type == 11){
      dir = "graphics/horizontal-blastdoor";
      file = "blastdoor_1";
      solid = true;
    }

    
    //Assigning Colours
    if(col == "red"){
      // Handing the colour changer the desired colour, directory, and file name.
      PImage[] temp = change.spriteArray("red", dir, file);
      img = temp[0];
    }
    else if(col == "green"){
      PImage[] temp = change.spriteArray("green", dir, file);
      img = temp[0];
    }
    else if(col == "blue"){
      PImage[] temp = change.spriteArray("blue", dir, file);
      img = temp[0];
    }
    else {
      PImage[] temp = change.loadFiles(dir, file);
      img = temp[0];
    }

  }
  
  //TODO - Allow for animated tiles
  
}
