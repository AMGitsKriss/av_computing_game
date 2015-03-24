class Collision{
  
  int x, y;
  
  Collision(){
    //Constructor
  }
  
  boolean colliding(String _dir){
    //middle of the sprite images
    x = int(player.pos.x + player.sprites[0].width/2);
    y = int(player.pos.y + player.sprites[0].height/2);
    
    //BUTTONS
    //if stood by button/interactive item
    if(_dir == "interactive_player" && world[floor(y/32)-2][floor(x/32)-1].type == 5 ){
      return true;
    }
    if(_dir == "interactive_level" && world[floor(y/32)-2][floor(x/32)-1].type == 4 ){
      return true;
    }
    
    //MULTI-BLOCK TILE COLLISON
    //Horizontal
    if(_dir == "horiz_left_down" && (world[floor((y+14)/32)][floor(x/32)-2].type == 11 || world[floor((y+14)/32)][floor(x/32)-1].type == 11 )){
      //TODO - Fix this.  
//     println(world[floor(y/32)+1][floor(x/32)-2].index + " " + world[floor(y/32)+1][floor(x/32)-1].index);
//     println(world[floor(y/32)+1][floor(x/32)-2].img.length + " " + world[floor(y/32)+1][floor(x/32)-1].img.length);
      if(world[floor((y+14)/32)][floor(x/32)-2].index >= 5 /*|| world[floor(y/32)][floor(x/32)-2].index >= 5*/){ //If animation index is partially open && stood on right-hand tile 
        return false;
      }
      else if(world[floor((y+14)/32)][floor(x/32)-1].index >= 12 /*|| world[floor(y/32)][floor(x/32)-1].index >= 12*/){ //If animation index is fully open && stood on left-hand tile
      //TODO - REPLACE 2 ABOVE WITH CORRECT VALUE
        return false;
      }

      //pos.x+=1;
      else return true;
    }
    
    //TODO - Create a boolean function to cycle through the semi-solid blocks. At present it only detects type 2 blocks. 
          //Need a list of semi-transparent blocks. Generate automatically or manually? 
    
    //BLOCK COLLISION
    //If bumping into block to the left
    if(_dir == "left" && (world[floor((y+12)/32)][floor((x-6)/32)].solid || world[floor((y-12)/32)][floor((x-6)/32)].solid || (world[floor(y/32)][floor((x-6)/32)].type == 3 && world[floor(y/32)][floor((x-6)/32)].col != player.currentCol))){
      //pos.x+=1;
      return true;
    }
    //bumping into block to the right
    else if(_dir == "right" && (world[floor((y+12)/32)][floor((x+6)/32)].solid || world[floor((y-12)/32)][floor((x+6)/32)].solid || (world[floor(y/32)][floor((x+6)/32)].type == 3 && world[floor(y/32)][floor((x+6)/32)].col != player.currentCol))){
      //pos.x-=1;
      return true;
    }
    //standing on the floor
    else if(_dir == "down" && world[floor((y+14)/32)][floor(x/32)].solid){
      return true;
    }
    //hittin the ceiling
    else if(_dir == "up" && (world[floor((y-14)/32)][floor(x/32)].solid || 
              (world[floor((y-14)/32)][floor(x/32)-2].type == 11 && world[floor((y-14)/32)][floor(x/32)-2].index < world[floor((y-14)/32)][floor(x/32)-2].img.length/2) || 
              (world[floor((y-14)/32)][floor(x/32)-1].type == 11 && world[floor((y-14)/32)][floor(x/32)-1].index < world[floor((y-14)/32)][floor(x/32)-1].img.length-1) 
             )){
      return true;
    }
    else if(_dir == "in_floor" && (world[floor((y+13)/32)][floor(x/32)].solid || 
            (world[floor((y+13)/32)][floor(x/32)-2].type == 11 && world[floor((y+13)/32)+1][floor(x/32)-2].index > world[floor((y+13)/32)][floor(x/32)-2].img.length/2) || 
            (world[floor((y+13)/32)][floor(x/32)-1].type == 11 && world[floor((y+13)/32)+1][floor(x/32)-1].index >= world[floor((y+13)/32)][floor(x/32)-2].img.length))){
      return true;
    }
    //otherwise not colliding
    else return false;
  }
  
  
}
