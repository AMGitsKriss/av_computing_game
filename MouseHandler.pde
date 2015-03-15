class MouseHandler{
  
  int mX, mY;
  
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
  }
  
  void mouseReleased(){
    mX = 0;
    mY = 0;
  }
  
  int mouseUpdateX(){
    if( mX==0 ) {
      return 0;
    }
    else {
    int temp = (mX - mouseX)/3;
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
