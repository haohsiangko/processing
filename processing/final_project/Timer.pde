class Timer{
  
  int counter; // counter = 1800 (60/sec)
  int sec;
  
Timer(int time){
  counter = time;
  sec = floor(counter/60);
  
}

void display(){
  textFont(myFont);
  textSize(24);
  fill(#FFFFFF);
  text("Time: " + sec, 30, 450);
}


int countDown(){
  //println("我正在倒數");
  //println("counter:"+counter);
  counter--;
  sec = floor(counter/60);
  return sec; 
}

}