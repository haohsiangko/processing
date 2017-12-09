class Background {
  PImage start1;
  PImage start2;


  PImage blancBg;
  PImage stage1info;
  PImage bg; //dice, PSS
  PImage nameCard1;
  PImage nameCard2;
  PImage stage2info;
  PImage stage22; //attack
  PImage stage23; //defend
  PImage stage3info;

  PImage win;

  PImage lose;




  Background() {
    this.start1 = loadImage("img/start01.png");
    this.start2 = loadImage("img/start02.png");
    this.stage1info = loadImage("img/stage1info.png");
    this.bg = loadImage("img/bg.png");
    this.blancBg = loadImage("img/blancBg.png");
    this.stage2info = loadImage("img/stage2info.png");
    //this.stage22 = loadImage("img/stage2info.jpg");//need to change to slapBg
    //this.stage23 = loadImage("img/stage2info.jpg");//need to change to defendBg
    this.stage3info = loadImage("img/stage3info.png");
    this.win = loadImage("img/win.png");
    this.lose = loadImage("img/lose.png");
  }


  void display() {
    if (state == GameState.START) {
      if (second() % 2 ==1) {
        image(start1, 0, 0);
      } else {
        image(start2, 0, 0);
      }
    }

    if (state == GameState.STAGE10) {
      image(stage1info, 0, 0);
    }

    if (state == GameState.STAGE11) {
      image(bg, 0, 0);
    }

    if (state == GameState.STAGE20) {
      image(stage2info, 0, 0);
    }

    if (state == GameState.STAGE21) {
      image(blancBg, 0, 0);
    }

    if (state == GameState.STAGE30) {
      image(stage3info, 0, 0);
    }

    if (state == GameState.STAGE31) {
      image(bg, 0, 0);
    }

    if (state == GameState.WIN) {
      image(win, 0, 0);
    }

    if (state == GameState.LOSE) {
      image(lose, 0, 0);
    }
  }
}