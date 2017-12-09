class Dice {
  //player
  float x1; 
  float y1;
  //computer
  float x2;
  float y2;
  int diceWin; 
  PImage dice1, dice2, dice3, dice4, dice5, dice6;

  Dice() {
    x1 = 435;
    y1 = 200;
    x2 = 120;
    y2 = 200;
    diceWin = 0;
    //playerDiceNum = 1;
    //comDiceNum = (int)random(6)+1;  //computer random
    dice1 = loadImage("img/dice01.png");
    dice2 = loadImage("img/dice02.png");
    dice3 = loadImage("img/dice03.png");
    dice4 = loadImage("img/dice04.png");
    dice5 = loadImage("img/dice05.png");
    dice6 = loadImage("img/dice06.png");
  }


  void diceAnimate() {
    count++;
    if (count%5 == 0) {
      playerDiceNum += 1;
      comDiceNum += 1;
      if (playerDiceNum >= 6) {
        playerDiceNum = 1;
      }
      if (comDiceNum >= 6) {
        comDiceNum = 1;
      }
    }
  } 


  void displayComDice() {
    if (comDiceNum == 1) {
      image(dice1, x2, y2);
    }
    if (comDiceNum == 2) {
      image(dice2, x2, y2);
    }
    if (comDiceNum == 3) {
      image(dice3, x2, y2);
    }
    if (comDiceNum == 4) {
      image(dice4, x2, y2);
    }
    if (comDiceNum == 5) {
      image(dice5, x2, y2);
    }
    if (comDiceNum == 6) {
      image(dice6, x2, y2);
    }
  }

  void displayPlayerDice() {
    if (playerDiceNum == 1) {
      image(dice1, x1, y1);
    }
    if (playerDiceNum == 2) {
      image(dice2, x1, y1);
    }
    if (playerDiceNum == 3) {
      image(dice3, x1, y1);
    }
    if (playerDiceNum == 4) {
      image(dice4, x1, y1);
    }
    if (playerDiceNum == 5) {
      image(dice5, x1, y1);
    }
    if (playerDiceNum == 6) {
      image(dice6, x1, y1);
    }
  }

  // random computer dice
  void randomComDice() {
    comDiceNum = floor(random(6)+1);
  } 

  void isWin() {
    if (playerDiceNum > comDiceNum)
    {      
      diceWin = 1;
      finishChoose = true;
    } else if (playerDiceNum == comDiceNum) {
      diceWin = 2;
    } else {
      diceWin = 3;
      finishChoose = true;
    }
  }
}