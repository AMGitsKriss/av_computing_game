class Player{
  //Get path, store array of paths, store array of images.
  PImage sprites[]; 
  char lastPressed; //last directional key pressed to remember the faced direction
  String directory, currentCol; //player sprite directory and their current colour
  Timer jumpCD; //cooldown on player jumping
  
  int index = 0, speed = 3, x, y; //graphic's position in the array & movement speed
  float vertSpeed = 3;
  boolean moving = false, jumping = false;
  PVector pos;
  
  //Recieves start pos, and folder containing instance's sprites. Allows each instance
  //to have it's own sprite set. Is not set up to allow each to have independant control.
  Player(float _x, float _y, String _dir){
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
  
  //TODO - This function is a mess. Condesnse it into smaller functions.
  void update(){
    if(colliding("interactive_player") && keys.ascii[101]){
      String temp = world[floor(y/32)-2][floor(x/32)-1].col;
      if(temp == "red") playerRed();
      if(temp == "green") playerGreen();
      if(temp == "blue") playerBlue();
    }
    
    if(colliding("interactive_level") && keys.ascii[101]){
      
      //TODO - FIND WHICH CHANGE WE NEED TO CALL  -  int(x/32), int(y/32)
      for(int i = 0; i < tilesChange.length; i++){
        if(tilesChange[i].x == x/32 && tilesChange[i].y == y/32){
          tilesChange[i].update();
          break;
        }
      }
    }
    
    if(colliding("interactive_player") && colliding("interactive_level")){
      //TODO - A HUD indication to tell the player to press [E]
    }
    
    //for now, change sprite colour on key presses:
    if(keys.ascii[105]) playerRed();
    if(keys.ascii[111]) playerGreen();
    if(keys.ascii[112]) playerBlue();
    if(keys.ascii[91]) playerDefault(); //TEMP
    
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
    
    //on the floor and you hit jump AND jump cooldown's expired.
    if(keys.ascii[32] && colliding("down") && jumpCD.update()){
      jumping = true;
      vertSpeed = -4.5;
      pos.y += vertSpeed;
    }
    
    //is the player mid-jump
    if(jumping && !colliding("down")){
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
    if(!colliding("down") && !jumping){
      pos.y -= vertSpeed;
      vertSpeed -= 0.1;
    }
    
    if(colliding("in_floor")){
      pos.y--;
    }
    
    if(colliding("down")){
      vertSpeed = -4.5;
    }
    
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
    if(!colliding("down")){
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
  
  boolean colliding(String _dir){
    //middle of the sprite images
    x = int(pos.x + sprites[0].width/2);
    y = int(pos.y + sprites[0].height/2);
    
    
    //if stood by button/interactive item
    if(_dir == "interactive_player" && world[floor(y/32)-2][floor(x/32)-1].type == 5 ){
      return true;
    }
    if(_dir == "interactive_level" && world[floor(y/32)-2][floor(x/32)-1].type == 4 ){
      return true;
    }
    
    
    //If bunping into block to the left
    //TODO - Create a boolean function to cycle through the semi-solid blocks. At present it only detects type 2 blocks. 
            //Need a list of semi-transparent blocks. Generate automatically or manually? 
    if(_dir == "left" && (world[floor((y+12)/32)][floor((x-6)/32)].solid || world[floor((y-12)/32)][floor((x-6)/32)].solid || (world[floor(y/32)][floor((x-6)/32)].type == 3 && world[floor(y/32)][floor((x-6)/32)].col != currentCol))){
      //pos.x+=1;
      return true;
    }
    //bumping into block to the right
    else if(_dir == "right" && (world[floor((y+12)/32)][floor((x+6)/32)].solid || world[floor((y-12)/32)][floor((x+6)/32)].solid || (world[floor(y/32)][floor((x+6)/32)].type == 3 && world[floor(y/32)][floor((x+6)/32)].col != currentCol))){
      //pos.x-=1;
      return true;
    }
    //standing on the floor
    else if(_dir == "down" && world[floor((y+14)/32)][floor(x/32)].solid){
      return true;
    }
    //hittin the ceiling
    else if(_dir == "up" && world[floor((y-14)/32)][floor(x/32)].solid){
      return true;
    }
    else if(_dir == "in_floor" && world[floor((y+13)/32)][floor(x/32)].solid){
      return true;
    }
    //otherwise not colliding
    else return false;
  }
}
