class LevelLoad{
  
  LevelLoad(){
    //load level information from text files
    parseLevelData();
    //using this data to create the world
    declareWorld();
    //loading a list/array of world-changing interactions
    declareChangables();
  }
  
  
  void parseLevelData(){
    //loading map arrays
    String[] temp_tiles = loadStrings("map_tiles.txt");
    String[] temp_colours = loadStrings("map_colours.txt");
//    println(temp_colours);
    String[] temp_interactive = loadStrings("interactive_level.txt");
  
    //declaring relevant 2D arrays
    tiles = new int[temp_tiles.length][];
    colours = new String[temp_colours.length][];
    interactive = new int[temp_interactive.length][];
    
    //dumping values into the arrays. As they should all be the same size
    //we can stick them in the same loop.
    for(int i = 0; i < temp_tiles.length; i++){
      tiles[i] = int(split(temp_tiles[i], TAB));
      colours[i] = split(temp_colours[i], TAB);
    }
    for(int i = 0; i < temp_interactive.length; i++){
      interactive[i] = int(split(temp_interactive[i], TAB));
    }
  }
  
  void declareChangables(){
    //breaking down the array into x, y, red[] green[] and blue[]
    tilesChange = new TilesChange[ceil(interactive.length/4)];
    for(int i = 0, j = 0; i < interactive.length; i+=5, j++){
      tilesChange[j] = new TilesChange(interactive[i+1][0], interactive [i+1][1], interactive[i+2], interactive[i+3], interactive[i+4]);
    }
  }
  
  //-----Tiles(TILE TYPE, TILE COLOUR)-----
  void declareWorld(){
    world = new Tiles[tiles.length][tiles[0].length];
    for(int y = 0; y < world.length; y++){
      for(int x = 0; x < world[y].length; x++){
        
        /*
        For some reason the colour strings aren't read properly. Using a temporary character 
        and string. The 1-letter string is turned into a char value, and temp is assigned a
        colour based on said char. 
        */
        char t;
        String temp = colours[y][x];
//        println(colours[y][x]);
        t = colours[y][x].charAt(0);
        if(t == 'r') temp = "red";
        else if(t == 'g') temp = "green";
        else if(t == 'b') temp = "blue";
        else temp = "default";
        //--------------------------
  
        world[y][x] = new Tiles(tiles[y][x], temp);
      }
    }
  }
  
}
