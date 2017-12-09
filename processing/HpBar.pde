class HpBar {

  float hpX, hpY, hpW, defenceW, hpH;
  float caseX, caseY;
  float mySpeed;
  float bossSpeed;
  PImage hpCase;

  HpBar() {
    hpX = 90;
    hpY = 46;
    hpW = 138;
    hpH = 26;
    caseX = 20;
    caseY = 20;
    mySpeed = 0.2;
    bossSpeed = 1.5;
    hpCase = loadImage("img/hpCase.png");
  }

  void display() {
    noStroke();
    fill(#FF0000);
    rect(hpX, hpY, hpW, hpH);
    image(hpCase, caseX, caseY);
  }

  //slap
  void bossHp() {
    hpW += 0;
  }  
  //defend
  void myHpDown() {
    hpW -= mySpeed;
  }
}