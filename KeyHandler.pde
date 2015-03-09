//key is a numeric value. e.g 119 is the ascii value of char 'w'.
//This allows boolean key detection

class KeyHandler{

  //regular keys, using ascii values
  // a = 97 | d == 100 | w = 119 | s = 115 | space = 32
  
  boolean[] ascii = new boolean[256];         
  //special keys using keyCodes
  boolean left = false, right = false, up = false, down = false;
  
  void down(){
    if(keyCode == LEFT) left = true;
    if(keyCode == DOWN) down = true;
    if(keyCode == RIGHT) right = true;
    if(keyCode == UP) up = true;
    
    //catching the ESC key to prevent program closing
    if(key == ESC) key = 0;
    if(key < ascii.length) ascii[key] = true;
  }
  
  void up(){
    if(keyCode == LEFT) left = false;
    if(keyCode == DOWN) down = false;
    if(keyCode == RIGHT) right = false;
    if(keyCode == UP) up = false;
    
    //catching the ESC key
    if(key == ESC) key = 0;
    if(key < ascii.length) ascii[key] = false;
  }

}//Utility
