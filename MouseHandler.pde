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
    float temp1 = mX - mouseX;  
    // image sprites are 0-12. buffer of 2 each side (-2 to 14) prevents it being impossible to open door all the way
    int temp2 = int(map(temp1,0,width,-2,14)); 
//    println(temp1 + " " + temp2);
    return temp2;
  }
  
  int mouseUpdateY(){
    float temp1 = mY - mouseY;  
    int temp2 = int(map(temp1,0,height,-2,14));
 //   println(temp1 + " " + temp2);
    return temp2;
  }
}
