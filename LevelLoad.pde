class LevelLoad{
  
  LevelLoad(){
    //load level information from text files
    println("Parsing Level Data");
    parseLevelData();
     
    //using this data to create the world
    println("Declaring World");
    declareWorld();
     
    //loading a list/array of world-changing interactions
    println("Loading changables");
    declareChangables();
  }
  
  
  void parseLevelData(){
    //loading map arrays
    String[] temp_tiles = loadStrings("map_tiles.txt");
     println("Loading map_tiles.txt");
    String[] temp_colours = loadStrings("map_colours.txt");
     println("Loading map_colours.txt");
    String[] temp_interactive = loadStrings("interactive_level.txt");
     println("Loading interactive_level.txt");
  
    //declaring relevant 2D arrays
    tiles = new int[temp_tiles.length][];
    colours = new String[temp_colours.length][];
    interactive = new int[temp_interactive.length][];
     println("World Arrays Declared");
    
    //dumping values into the arrays. As they should all be the same size
    //we can stick them in the same loop.
    for(int i = 0; i < temp_tiles.length; i++){
      tiles[i] = int(split(temp_tiles[i], TAB));
      colours[i] = split(temp_colours[i], TAB);
    }
     println("Dumping tiles and colours into arrays");
    for(int i = 0; i < temp_interactive.length; i++){
      interactive[i] = int(split(temp_interactive[i], TAB));
    }
     println("Dumping interactivity into array");
  }
  
  void declareChangables(){
    //breaking down the array into x, y, red[] green[] and blue[]
    tilesChange = new TilesChange[ceil(interactive.length/4)];
    for(int i = 0, j = 0; i < interactive.length; i+=5, j++){
      tilesChange[j] = new TilesChange(interactive[i+1][0], interactive [i+1][1], interactive[i+2], interactive[i+3], interactive[i+4]);
    }
     println("Combobulating interaction array");
  }
  
  //-----Tiles(TILE TYPE, TILE COLOUR)-----
  void declareWorld(){
    
    //TODO - Load tiles immediately around the player first, then expand outwards to expediate loading?
    
    world = new Tiles[tiles.length][tiles[0].length];
    println("Condensing arrays into world");
    
    for(int y = 0; y < world.length; y++){
      for(int x = 0; x < world[y].length; x++){
        
        /*
        For some reason the colour strings aren't read properly. Using a temporary character 
        and string. The 1-letter string is turned into a char value, and temp is assigned a
        colour based on said char. 
        */
        char t;
        String temp;
//        println(colours[y][x]);
        t = colours[y][x].charAt(0);
        if(t == 'r') temp = "red";
        else if(t == 'g') temp = "green";
        else if(t == 'b') temp = "blue";
        else temp = "default";
        //--------------------------
  
        world[y][x] = new Tiles(tiles[y][x], temp);
      }
      println(y + " of " + world.length);
    }
     println("Condensing arrays into world");
  }
  
}
