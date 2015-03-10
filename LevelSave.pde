class LevelSave{
  int type;
  String col;
  PrintWriter output;
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
    output = createWriter("savedLevel.txt");
//    world = new Tiles[tiles.length][tiles[0].length];
    for(int y = 0; y < world.length; y++){
      for(int x = 0; x < world[y].length; x++){

        output.print(world[y][x].type + "" + TAB);  // Write the coordinate to the file
        
      }
      println(" ");
    }
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
  }
  
  
}
