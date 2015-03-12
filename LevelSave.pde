class LevelSave{
  int type;
  String col;
  PrintWriter outputType, outputCol;
  //put array into txt
  
  LevelSave(){
    //Constructor
    update();
  }
  
  /*
  Cycle through the world array and assign each colour (r, g, b, d) to map_colours.txt and
  the tile values to map_tiles.txt. Each value must have a tab after it.
  
  Will a tab at the end impact how the array is parsed when starting the game?
  
  interactive_level.txt likely won't need interacting with. An easy way to build/edit this 
  file? Probably a seperate smaller program.
  */
  
  void update(){
    outputType = createWriter("map_tiles.txt");
    outputCol = createWriter("map_colours.txt");
    
    for(int y = 0; y < world.length; y++){
      for(int x = 0; x < world[y].length; x++){
        outputType.print(world[y][x].type);  // Write the type to the file
        outputCol.print(world[y][x].col.charAt(0));  // Write the colour to the file
        if(x!=world[y].length-1){ 
          outputType.print(TAB);
          outputCol.print(TAB);
        }
      }
      outputType.println();
      outputCol.println();
    }
   // outputType.flush();  //Writes the remaining data to the file
    //outputCol.flush();
    outputType.close();  //Finishes the file
    outputCol.close();
  }
  
  
}
