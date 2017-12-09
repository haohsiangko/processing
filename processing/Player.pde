class Player {

  PImage normalBg, slapBg, defendBg, hitBg;
  int hit;

  Player() {
    normalBg = loadImage("img/normalBg.png");
    slapBg   = loadImage("img/slapBg.png");
    defendBg = loadImage("img/defendBg.png");
    hitBg = loadImage("img/hitBg.png");
    hit = 0;
  }

  void displaySlapBg() { 
    if (mousePressed) {
      image(slapBg, 0, 0);
      //slap.rewind();
      //slap.play();
      
    } else {
      image(normalBg, 0, 0);
    }
  }

  void displayDefenceBg() {
    hit ++;
    
    if (hit < 15) {
      image(hitBg, 0, 0);  
    }
    
    if (hit >= 15 && hit< 30) {
      image(normalBg, 0, 0);
    }
    
    if(hit == 30){
      hit = 0;
    }

    if (mousePressed) {
      image(defendBg, 0, 0);
    }
  }

  void isWin() {
    //Card
    if(state == GameState.STAGE21){
      if(timerCard.sec == 0 && winNum < 6){
         state = GameState.LOSE;
      }
    }
    
    //SLAP
    if (state == GameState.STAGE31) {
      if (stageState == PSSstage.SLAP) {
        if (timer.sec == 0) {
          state = GameState.LOSE;
        }
      }
    
    //DEFENSE
      if (stageState == PSSstage.DEFENCE) {
        if (timer.sec == 0 && hpBar.hpW > 0) {
          state = GameState.WIN;
        }
      }
    }
  }
}