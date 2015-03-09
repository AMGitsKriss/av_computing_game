class Timer{
  
  int time_delay;
  int totalTime = millis();
  
/*
Waits 'int' milliseconds before returning true. 
*/
 
  Timer(int _t){
    time_delay = _t;
    totalTime = millis();
  }
  
  boolean update(){
    int passedTime = millis() - totalTime;
    if(passedTime > time_delay){
      return true;
    }
    else return false;
  }
}
