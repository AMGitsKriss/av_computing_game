class Player extends Collision{
  //Get path, store array of paths, store array of images.
  PImage sprites[]; 
  PImage pressE;
  char lastPressed; //last directional key pressed to remember the faced direction
  String directory, currentCol; //player sprite directory and their current colour
  Timer jumpCD; //cooldown on player jumping
  
  int index = 0, speed = 3; //graphic's position in the array & movement speed
  float vertSpeed = 3;
  boolean moving = false, jumping = false;
  PVector pos;
  
  //Recieves start pos, and folder containing instance's sprites. Allows each instance
  //to have it's own sprite set. Is not set up to allow each to have independant control.
  Player(float _x, float _y, String _dir){
    pressE = loadImage("graphics/misc/press_e.png");
    directory = _dir;
    pos = new PVector(_x, _y);
    jumpCD = new Timer(600);
    //applying an initial colour
    playerRed();
  }
  
  //Turn the player Red
  void playerRed(){
    currentCol = "red";
    sprites = change.spriteArray("red", directory, "");
  }
  
  //Turn the player Green
  void playerGreen(){
    currentCol = "green";
    sprites = change.spriteArray("green", directory, "");
  }
  
  //Turn the player Blue
  void playerBlue(){
    currentCol = "blue";
    sprites = change.spriteArray("blue", directory, "");
  }
  
  //TODO - This is temp. Remove when done.
  void playerDefault(){
    currentCol = "default";
    sprites = change.spriteArray(currentCol, directory, "");
  }
  
  void showInteractButton(){
    image(pressE, x-20, y-60);
  }
  
  void searchBlastDoors(){
    //Grabbing the range of tiles on the screen. Only tiles within these bounds
    //will be searched.
    int var1 = drawRange(y, (height/32)/2+3, world.length),
        var2 = drawRange(y, -(height/32)/2-4, world.length),
        var3 = drawRange(x, (width/32)/2+3, world[0].length),
        var4 = drawRange(x, -(width/32)/2-4, world[0].length);
    PVector nearest = null, mousePos = new PVector(mouseX, mouseY);
    //Redrawing the world from bottom-right to top left.
    //This allows for graphics larger than the tile to be drawn properly
    for(int y = var1; y >= var2 ; y--){
      for(int x = var3; x >= var4; x--){
        PVector temp = new PVector(x*32, y*32);
        if(world[y][x].type == 11 && mousePos.dist(temp) < mousePos.dist(nearest)){
          nearest = new PVector(x*32, y*32);
          //a call to  the mouse handler that selects the active door.
          //mouse.select();
        }
      }
    }
  }
  
  //TODO - This function is a mess. Condesnse it into smaller functions.
  void update(){
    if(colliding("interactive_player")){
      showInteractButton();
      if(keys.ascii[101]){
        String temp = world[floor(y/32)-2][floor(x/32)-1].col;
        showInteractButton();
        if(temp == "red") playerRed();
        if(temp == "green") playerGreen();
        if(temp == "blue") playerBlue();
      }
    }
    
    if(colliding("interactive_level")){
      showInteractButton();
      if(keys.ascii[101]){
        //TODO - FIND WHICH CHANGE WE NEED TO CALL  -  int(x/32), int(y/32)
        for(int i = 0; i < tilesChange.length; i++){
          if(tilesChange[i].x == x/32 && tilesChange[i].y == y/32){
            tilesChange[i].update();
            break;
          }
        }
      }
    }
    
    //for now, change sprite colour on key presses:
    if(keys.ascii[105]) playerRed();
    if(keys.ascii[111]) playerGreen();
    if(keys.ascii[112]) playerBlue();
    if(keys.ascii[91]) playerDefault(); //TEMP
    
        /*---------------- MOVEMENT LOGIC --------------------*/
    
    //If neither A & D, or both A & D are being pressed, do nothing
    if((!keys.ascii[97] && !keys.ascii[100]) || (keys.ascii[97] && keys.ascii[100])){
      moving = false;
    }
    
    //Move left on A
    else if(keys.ascii[97] && !colliding("left")){
      moving = true;
      pos.x -= speed;
      lastPressed = 97;
    }
    
    //Move right on D
    else if(keys.ascii[100] && !colliding("right")){
      moving = true;
      pos.x += speed;
      lastPressed = 100;
    }
    
        /*---------------- COLLISION LOGIC --------------------*/
              //*    This looks bad, and I feel bad    *//
    
    //on the floor and you hit jump AND jump cooldown's expired.
    if(keys.ascii[32] && ( colliding("down") || colliding("horiz_left_down") ) && jumpCD.update()){
      jumping = true;
      vertSpeed = -4.5;
      pos.y += vertSpeed;
    }
    
    if(jumping && colliding("horiz_left_down")){
      vertSpeed *= -1;
      jumping = false;
    }
 
    //is the player mid-jump
    if(jumping && !colliding("down") && !colliding("horiz_left_down") && !colliding("in_floor")){
      //if you hit the ceiling, the jump becomes a fall
      if(colliding("up") && jumping) {
        jumping = false;
      }
      pos.y += vertSpeed;
      vertSpeed += 0.1;
      jumpCD = new Timer(500);
    //else fall
    } else {
      jumping = false;
    }
    
    //falling?
    if(!colliding("down") && !colliding("horiz_left_down") && !jumping){
      pos.y -= vertSpeed;
      vertSpeed -= 0.1;
    }
    
    if(colliding("in_floor")){
      pos.y--;
    }
    
    if(colliding("down")){
      vertSpeed = 0;
    }
//    println(colliding("up") + "  " + colliding("down") + "  " + colliding("left") + "  " + colliding("right") + "  " + colliding("in_floor") + "  " + colliding("horiz_left_down"));
  }
  void stillFrame(int i){
    //if last direction button was left
    if(lastPressed == 97){
      pushMatrix();
      scale(-1, 1);
      //keep the player inverted
      image(sprites[i], -sprites[i].width, 0);
      popMatrix();
    }
    //otherwise sprite faces right like normal
    else{
      image(sprites[i], 0, 0);
    }
  }
  
  //TODO Rewrite so current-frame is based on a modulus calculation indead of dividing the index by a value
  void draw(){
    pushMatrix();
    translate(pos.x, pos.y);
    
    //falling?
    if(!colliding("down") && !colliding("horiz_left_down")){
      stillFrame(1);
    }
    else{
      //Standing still
      if(!moving || colliding("left") || colliding("right")){
        stillFrame(0);
      }
  
      //Going left ( A key )
      if(keys.ascii[97] && moving && !colliding("left")){
        scale(-1, 1);
        image(sprites[index/4], -sprites[index/4].width, 0);
        index++;
      }
      
      //Going right ( D key )
      if(keys.ascii[100] && moving && !colliding("right")){ 
        scale(1, 1);
        image(sprites[index/4], 0, 0);
        index++;
      }
    }
    //resetting index to 0 when sprite frames are exceeded.
    if(index >= 4*(sprites.length-1)){
      index = 0;
    }
    popMatrix();
    
  }
}
