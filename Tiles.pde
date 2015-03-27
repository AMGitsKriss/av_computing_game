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
      case 12: //pipes type 1 part 1
        assignType("graphics/pipes", "pipes_1.1", false, false);
        break;
      case 13: //pipes type 1 part 2
        assignType("graphics/pipes", "pipes_1.2", false, false);
        break;
      case 14: //pipes type 2 part 1
        assignType("graphics/pipes", "pipes_2.1", false, false);
        break;
      case 15: //pipes type 2 part 2
        assignType("graphics/pipes", "pipes_2.2", false, false);
        break;
      case 16: //pipes type 2 part 3
        assignType("graphics/pipes", "pipes_2.3", false, false);
        break;
      case 17: //pipes type 2 part 4
        assignType("graphics/pipes", "pipes_2.4", false, false);
        break;
      case 18: //pipes type 3 part 1
        assignType("graphics/pipes", "pipes_3.1", false, false);
        break;
      case 19: //pipes type 3 part 2
        assignType("graphics/pipes", "pipes_3.2", false, false);
        break;
      case 20: //pipes type 3 part 3
        assignType("graphics/pipes", "pipes_3.3", false, false);
        break;
      case 21: //pipes type 3 part 4
        assignType("graphics/pipes", "pipes_3.4", false, false);
        break;
      case 22: //pipes type 4
        assignType("graphics/pipes", "pipes_4", false, false);
        break;
      case 23: //A key sign
        assignType("graphics/tutorial", "a_key", false, false);
        break;
      case 24: //D key sign
        assignType("graphics/tutorial", "d_key", false, false);
        break;
      case 25: //Space key sign
        assignType("graphics/tutorial", "space_key", false, false);
        break;
      case 26: //Space key sign
        assignType("graphics/tutorial", "mouse", false, false);
        break;
      case 27: //Grumpycat
        assignType("graphics/misc", "grumpy", false, false);
        break;
      case 28:  //Gravity Button speeds - 0.05
      case 29:  //0.1
      case 30:  //0.2
        assignType("graphics/background-tiles", "button", false, false);
        break;
      case 31:  //quarter grav
        assignType("graphics/tutorial", "Gquart", false, false);
        break;
      case 32:  //half grav
        assignType("graphics/tutorial", "Ghalf", false, false);
        break;
      case 33:  //1 grav
        assignType("graphics/tutorial", "G1", false, false);
        break;
      case 34:  //exit
        assignType("graphics/background-tiles", "exit", false, false);
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
      else if(index < 0){
        index = 0;
      }
    }
  }
}
