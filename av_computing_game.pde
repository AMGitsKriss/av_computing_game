import ddf.minim.*;

Player player; 
KeyHandler keys;
MouseHandler mouse;
int transX, transY, tileIndex = 2;
ColourChanger change;
TilesChange[] tilesChange;
boolean spark_canplay = true;

int[][] tiles, interactive;
String[][] colours;
Tiles[][] world;

Minim minim;
AudioPlayer footsteps, slide_door, spark, landing;

  //TODO - There's some minor lag when app first starts. Can we find the source/reduce it?
  
  //TODO - Blast door. 01 is closed. 07 is half open. 13 is fully open. The door index needs to impact collision detection. 

void setup(){
  //Smaller on low-res. Larger on high res.
  if(displayWidth > 1300) size(1280, 720);
  else size(800, 450);
  println("Size Defined");

  minim = new Minim(this);
  println("Minim Starting");
  
  footsteps = minim.loadFile("audio/footsteps.wav");
  slide_door = minim.loadFile("audio/sliding-door.wav");
  spark = minim.loadFile("audio/electric-arcing.aiff");
  //landing = minim.loadFile("audio/thump.wav");
  println("Audio Loaded");
  
  change = new ColourChanger();
  println("Colour Changer");
  
  //declaring characters with posion and image directory
  player = new Player(38*32, 125*32, "graphics/player");
  println("Player");
  
  keys = new KeyHandler();
  mouse = new MouseHandler();
  println("Controls");
  
  //Load the level
  println("Loading Level......");
  LevelLoad load = new LevelLoad();

  //create a new file in dir
//  LevelSave save = new LevelSave();
  
  //TODO - Allow map-saving also.
  
}

void debug(){
  fill(255);
  String[] debugText = {"U + click to skip | I =red, O = green, P = blue, [ = default | ] to save map. Hold TAB to draw tiles, scroll to select tile.",
                        player.currentCol, 
                        "MOUSE | Y: " + (mouseY-transY)/32 + "    X: " + (mouseX-transX)/32, 
                        "PLAYER | Y: " + int(player.pos.y)/32 + "    X: " + int(player.pos.x)/32,
                        "Selected Tile: " + tileIndex
                      };
  for(int i = 0; i < debugText.length; i++){
    text(debugText[i], -(transX-15), -(transY-15*(i+1)));
  }
}

void draw(){
  
  if(world[player.y/32][player.x/32].type == 3 && spark_canplay){
    play("spark");
    spark_canplay = false;
  }
  else if(world[player.y/32][player.x/32].type != 3 && !spark_canplay){
    spark.pause();
    spark_canplay = true;
  }
  
  if(keys.ascii[93]){ 
    LevelSave save = new LevelSave();
  }
  background(10);
  pushMatrix();
  noStroke(); 
  
  //TODO - Make sure the nearest foor the the mouse (That's on-screen) is controlled
  
  //TODO - Stick audio in it's own thing.
  
  //Handling the door
  if(mouse.pressed == true && mouse.sX != -1 && world[mouse.sY][mouse.sX].index >= 0 && world[mouse.sY][mouse.sX].col == player.currentCol){
    int temp = mouse.mouseUpdateX();
    if(temp != 0 && mouse.door_canplay){
      play("slide_door");
      mouse.door_canplay = false;
    }
    else if(temp == 0 && !mouse.door_canplay){
      slide_door.pause();
      mouse.door_canplay = true;
    }
    if(world[mouse.sY][mouse.sX].index < world[mouse.sY][mouse.sX].img.length-1 && temp > 0){
      world[mouse.sY][mouse.sX].index += temp;
    }
    else if(world[mouse.sY][mouse.sX].index > 0 && temp < 0){
      world[mouse.sY][mouse.sX].index += temp;
    }
  } 
  
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
      int temp = world[y][x].index;
      world[y][x].animate();
      image(world[y][x].img[temp], x*32, y*32);
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

// only draw _var distance around the player's _pos and crop _length to reduce surplus tiles.
int drawRange(int _pos, int _var, int _length){
  int value = (_pos/32) + _var;
  if(value < 0) value = 0;
  else if(value > _length-1) value = _length-1;
  return value;
}

  //play sounds depending on what type it is
  void play(String type){
    if(type == "footsteps") footsteps.loop();
    if(type == "slide_door"){
//      println(slide_door.length());
      //slide_door.loop();
      slide_door.play(1000);
      //slide_door.rewind();
      //notes: use play to start audio at 1 sec
      //can loop with rewind but won't start at 1 sec then

    }
    if(type == "spark"){
      spark.loop();
//      spark.setVolume(0.5);
    }
    if(type == "landing") landing.loop();
  }

void mousePressed(){
  mouse.mousePressed();
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
    }
  //If out of bounds
  } else {
    println("Oops. Went out of bounds.");
  }
}

void mouseReleased(){
  mouse.mouseReleased();
}

void mouseClicked(){
  if(mouseX-transX > 0 && mouseX-transX < (world[0].length-1)*32 && mouseY-transY > 0 && mouseY-transY < (world.length-1)*32){
    //Drawing map-tile on a click while holding TAB
      if(keys.ascii[TAB]){ 
        world[(mouseY-transY)/32][(mouseX-transX)/32] = new Tiles(tileIndex, player.currentCol);
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
