class PSS{
int myHand;
int comHand;// random hand number
int pssWinNum;
PImage hand0, hand1, hand2;
PImage paper, scissor, stone, paperHover, scissorHover, stoneHover;
float x, y, comX, comY;


PSS(){

  x = 365;
  y = height/3;
  comX = 42;
  comY = height/3;
  pssWinNum  = 0;
  hand0 = loadImage("img/stone.png"); // stone
  hand1 = loadImage("img/paper.png"); // paper
  hand2 = loadImage("img/scissor.png"); // scissor
  paper = loadImage("img/paper.png"); // choose hand image
  scissor = loadImage("img/scissor.png"); // choose hand image
  stone = loadImage("img/stone.png"); // choose hand image
  paperHover = loadImage("img/paper.png"); // choose hand image
  scissorHover = loadImage("img/scissor.png"); // choose hand image
  stoneHover = loadImage("img/stone.png"); // choose hand image
  comHand = floor(random(3));
  myHand = floor(random(3));

}

void myhandAnimate(){
  count++;
  if(count%5 == 0){
    myHand += 1;
    comHand += 1;
    if(myHand >= 3){
      myHand = 0;
    }
    if(comHand >= 3){
      comHand = 0;
    }
  }
} 

void displayChoiceImage(){
  image(stone, width/2 + 30, 400, 235/10*5, 213/10*5);
  image(paper, width/2 + 100, 400, 235/10*5, 213/10*5);
  image(scissor, width/2 +170 , 400, 235/10*5, 213/10*5); 
}

void displayHand(){

  if(comHand == 0){
    // stone.resize(200, 0);
    image(stone, comX, comY);
  }
  if(comHand == 1){
    // paper.resize(200, 0);
    image(paper, comX, comY);
  }
  if(comHand == 2){
    //scissor.resize(200, 0);
    image(scissor, comX, comY);
  }
  if(myHand == 0){
    //stone.resize(200, 0);
    image(stone, x, y);
  }
  if(myHand == 1){
    //paper.resize(200, 0);
    image(paper, x, y);
  }
  if(myHand == 2){
    //scissor.resize(200, 0);
    image(scissor, x, y);
  }

}

void displayHand(int myNum, int comNum){

  if(comNum == 0){
    //stone.resize(200, 0);
    image(stone, comX, comY);
  }
  if(comNum == 1){
    //paper.resize(200, 0);
    image(paper, comX, comY);
  }
  if(comNum == 2){
    //scissor.resize(200, 0);
    image(scissor, comX, comY);
  }
  if(myNum == 0){
    //stone.resize(200, 0);
    image(stone, x, y);
  }
  if(myNum == 1){
    //paper.resize(200, 0);
    image(paper, x, y);
  }
  if(myNum == 2){
    //scissor.resize(200, 0);
    image(scissor, x, y);
  }
}

boolean choosePlayerHand(){

  //stone
  if(mouseX > 383 && mouseX < 428){
    if(mouseY > 424 && mouseY < 472){
      image(stone, width/2 + 30, 400, 235/10*5.1, 213/10*5.1);
      if(mousePressed){
        count = 0;
        myHand = 0;
        comHand = floor(random(3));
        stageState = PSSstage.PLAY;
        return true;
      }
    }
  }
  
  //paper
  if(mouseX > 450 && mouseX < 502){
    if(mouseY > 424 && mouseY < 472){
      image(paper, width/2 + 100, 400, 235/10*5.1, 213/10*5.1);
      if(mousePressed){
        count = 0;
        myHand = 1;
        comHand = floor(random(3));
        stageState = PSSstage.PLAY;
        return true;
      }
    }
  }
  
  //scissor
  if(mouseX > 524 && mouseX < 562){
    if(mouseY > 424 && mouseY < 472){
      image(scissor, width/2 +170 , 400, 235/10*5.1, 213/10*5.1); 
      if(mousePressed){
        count = 0;
        myHand = 2;
        comHand = floor(random(3));
        stageState = PSSstage.PLAY;
        return true;
      }
    }
  }return false;
}

void isWin(){
  if(
  comHand == 0 && myHand == 1 || 
  comHand == 1 && myHand == 2 || 
  comHand == 2 && myHand == 0)
  {
    pssWinNum = 1;
  }else if(comHand == myHand){
    pssWinNum = 2; 
  }else{
    pssWinNum = 3;
  }
}
}