class MouseHandler{
  
  int mX, mY, sX,sY;
  boolean pressed = false;
  
  MouseHandler(){
    //constructor
  }
  
  //TODO - Do we wantto continue with this, or would we rather have a button open/close doors?
  /*
  While clicked the handler must keep track of the starting co-ordinates of the click
  When released it must forget them.  
  
  
  */
  
  void select(PVector _mouse){
    if(_mouse == null){
      sX = sY = -1;
    } else {
      sX = int(_mouse.x/32);
      sY = int(_mouse.y/32);
    }
  }
  
  void mousePressed(){
    mX = mouseX;
    mY = mouseY;
    pressed = true;
  }
  
  void mouseReleased(){
    mX = 0;
    mY = 0;
    pressed = false;
  }
  
  int mouseUpdateX(){

    int direction;
    //determing 1 or 0
    direction = (mouseX - mX != 0) ? 1 : 0;
    //then determining left or right
    direction = (mouseX - mX < 0) ? direction * 1 : direction * -1;
    return direction;
  }
  
  int mouseUpdateY(){
    return 0;
    //TODO - Same as the X function above when needed.
  }
}
