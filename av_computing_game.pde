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
  
  //Load the level
  LevelLoad load = new LevelLoad();


  //create a new file in dir
//  LevelSave save = new LevelSave();
  
  //TODO - Allow map-saving also.
  
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
  
  //Grabbing the range of tiles on the screen. Only tiles within these bounds
  //will be rendered.
  int var1 = drawRange(player.y, (height/32)/2+3, world.length),
      var2 = drawRange(player.y, -(height/32)/2-4, world.length),
      var3 = drawRange(player.x, (width/32)/2+3, world[0].length),
      var4 = drawRange(player.x, -(width/32)/2-4, world[0].length);
      
  //Redrawing the world from bottom-right to top left.
  //This allows for graphics larger than the tile to be drawn properly
  for(int y = var1; y >= var2 ; y--){
    for(int x = var3; x >= var4; x--){
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

int drawRange(int _pos, int _var, int _length){
  int value = (_pos/32) + _var;
  if(value < 0) value = 0;
  else if(value > _length-1) value = _length-1;
  return value;
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
    }
  //If out of bounds
  } else {
    println("Oops. Went out of bounds.");
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
