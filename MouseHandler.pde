class MouseHandler{
  
  int mX, mY;
  boolean pressed = false;
  
  MouseHandler(){
    //constructor
  }
  
  //TODO - complete  the mouse handler
  /*
  While clicked the handler must keep track of the starting co-ordinates of the click
  When released it must forget them.  
  */
  
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
    if( mX==0 ) {
      return 0;
    }
    else {
    int temp = floor((mX - mouseX)/10);
    println(temp);      
    return temp;
    }
  }
  
  int mouseUpdateY(){
    int temp = (mY - mouseY)/3;
    println(temp);
    return temp;
  }
}
