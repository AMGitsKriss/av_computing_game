Player player; 
KeyHandler keys;
int transX, transY, tileIndex = 2;
ColourChanger change;
TilesChange[] tilesChange;

int[][] tiles, interactive;
String[][] colours;
Tiles[][] world;

void setup(){
  //Smaller on low-res. Larger on high res.
  if(displayWidth > 1300) size(1280, 720);
  else size(800, 450);
  
  change = new ColourChanger();
  //declaring characters with posion and image directory
  player = new Player(12*32, 10*32, "graphics/player");
  keys = new KeyHandler();
  
  //TODO - Condense this all down into it's own object.
  //TODO - Allow map-saving also.
  
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
      String temp;
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


void debug(){
  fill(255);
  text(player.currentCol, -(transX-15), -(transY-15)); // Current Player Colour
  text("MOUSE | Y: " + (mouseY-transY)/32 + "    X: " + (mouseX-transX)/32, -(transX-15), -(transY-30)); //Tile index of mouse
  text("PLAYER | Y: " + int(player.pos.y)/32 + "    X: " + int(player.pos.x)/32, -(transX-15), -(transY-45)); //Tile index of player
  text("Selected Tile: " + tileIndex, -(transX-15), -(transY-60)); //Tile-type index of editor
}

void draw(){
  background(50);
  pushMatrix();
  noStroke(); 
  
  //only translating by whole pixels
  transX = floor(-player.pos.x + width/2);
  transY = floor(-player.pos.y + height/2);
  translate(transX, transY);
  
  //TODO - Only draw tiles that are on the screen
  
  //Redrawing the world from bottom-right to top left.
  //This allows for graphics larger than the tile to be drawn properly
  for(int y = world.length-1; y >= 0 ; y--){
    for(int x = world[y].length-1; x >= 0; x--){
      //get tile's colour & draw it
        image(world[y][x].img, x*32, y*32);
        //TODO - Put another (uncoloured) image here if one exists? A decoration layer.
    }
  }

  player.update();
  player.draw();
  debug();
  popMatrix();
  
  //Catching the escape key and using it to reset the app
  if(keys.ascii[0]){
    key = 0;
    setup();
  }
}

void mousePressed(){
  //reset player on mouse click
  //player = new Player(33, 34, "graphics/player");
  
    //IF within bounds
    if(mouseX-transX > 0 && mouseX-transX < (world[0].length-1)*32 && mouseY-transY > 0 && mouseY-transY < (world.length-1)*32){
      //If [u] is held, and user's clicked inside the array, teleport the player there.
      if(keys.ascii[117]){
        //Only moving player to non-solid block
        if(!world[(mouseY-transY)/32][(mouseX-transX)/32].solid){
          player.pos.x = mouseX-transX;
          player.pos.y = mouseY-transY;
        } else {
          println("Oops. That's solid.");
        }
      
      //Drawing map-tile on a click while holding TAB
      if(keys.ascii[TAB]){ 
        world[(mouseY-transY)/32][(mouseX-transX)/32] = new Tiles(tileIndex, player.currentCol);
      }
      
    //If out of bounds
    } else {
      println("Oops. Went out of bounds.");
    }
  }
  
  
  
}

void mouseDragged(){
  if(mouseX-transX > 0 && mouseX-transX < (world[0].length-1)*32 && mouseY-transY > 0 && mouseY-transY < (world.length-1)*32){
    //Drawing map with a click and drag while holding TAB
    if(keys.ascii[TAB]){ 
      world[(mouseY-transY)/32][(mouseX-transX)/32] = new Tiles(tileIndex, player.currentCol);
    }
  }
}

void mouseWheel(MouseEvent event) {
  tileIndex -= event.getCount();
  if(tileIndex < 0) tileIndex = 0;
}

void keyPressed(){
  keys.down();
}

void keyReleased(){
  keys.up();
}
