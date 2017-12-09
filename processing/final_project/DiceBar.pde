class DiceBar {

  int r, g, b;
  float x, y, w, h;
  float xCase, yCase;
  float speed;
  PImage diceBar;

  DiceBar() {
    // r, g, b;
    x = 70;
    y = 426;
    w = 0;
    h = 18;
    xCase = width/2;
    yCase = height/2;
    speed = 10;
    diceBar = loadImage("img/diceBar.png");
  }

  void display() {
    noStroke();
    fill(#FF0000);
    rect(x, y, w, h);
    image(diceBar, 0, 0);
  }

  void move() {

    w += speed;
    if (w > 496) {
      w = 0;
      w += speed;
    }
  }

  void detectPlayerDice() {

    if (w >= 0 && w < 250) {
      playerDiceNum = 1;
    }
    if (w >= 250 && w < 372) {
      playerDiceNum = 2;
    }
    if (w >= 372 && w < 424) {
      playerDiceNum = 3;
    }
    if (w >= 424 && w < 460) {
      playerDiceNum = 4;
    }
    if (w >= 460 && w < 483) {
      playerDiceNum = 5;
    }
    if (w >= 483 && w < 496) {
      playerDiceNum = 6;
    }
  }
}