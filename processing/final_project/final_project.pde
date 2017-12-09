//音效
import ddf.minim.*;
Minim minim;
AudioPlayer song;// bg music
AudioPlayer slap;//
AudioPlayer punch;//

//宣告class
Background bg;
Dice dice;
DiceBar diceBar;
HpBar hpBar;
PSS pss;
Player player;
Timer timer;
Timer timerCard;
Cards[] myCard    = new Cards[12];//12個位置

//第二關翻卡牌遊戲用變數＆陣列
int [] cardX      = new int [12];
int [] cardY      = new int [12];
int [] cardFace   = new int [14]; //13張+背面
int [] cardStep   = new int [2]; //翻第一次or第二次牌
boolean [] click  = new boolean [12];//12個位置有沒有點

int spacingX      = 150;
int spacingY      = 20;
int initcardFace  = 0;
int flipped       = 0;
int winNum        = 0;
int nowTime       = 0;
int delay         = 0;
int equalWait     = 0;

int lastCardID_1 = 0;
int lastCardID_2 = 0;

int count = 0; 
int playerDiceNum, comDiceNum ;
boolean finishChoose = false;
PFont myFont;

class GameState {
  static final int START = 0;
  static final int STAGE10 = 1; //intro of stage1
  static final int STAGE11 = 2; //playing
  static final int STAGE20 = 3; //intro of stage2
  static final int STAGE21 = 4; //playing PSS
  static final int STAGE30 = 5; //intro of stage2
  static final int STAGE31 = 6; //playing PSS
  static final int WIN = 7;
  static final int LOSE = 8;
}
int state = GameState.START;
int newState = 0;

class DiceStage {
  static final int ANIMATE = 0;
  static final int PLAY = 1;
}

class PSSstage {
  static final int START = 0;
  static final int PLAY = 1;
  static final int SLAP = 2;
  static final int DEFENCE = 3;
}
int stageState;

void setup() {
  size(640, 480);
  myFont = createFont("font/Capitals.dfont", 36);
  textFont(myFont);
  fill(#FFFFFF);
  minim = new Minim(this);
  song = minim.loadFile("BGMusic.mp3");
  slap = minim.loadFile("slap.wav");
  punch = minim.loadFile("punch.wav");
  
  song.play();
  song.loop();
  
  
  
  resetAll();
}

void resetAll(){
bg = new Background();
  //card = new Card();
  dice = new Dice();
  diceBar = new DiceBar();
  hpBar = new HpBar();
  pss = new PSS();
  player = new Player();
  timer = new Timer(1200); //20sec
  timerCard = new Timer(2400); //20sec 
  playerDiceNum = 1;
  comDiceNum = (int)random(6)+1;  //computer random
  stageState = DiceStage.ANIMATE;
  
  //設定卡牌放置位置
  for (int i = 0; i < 12; i ++)
  { 
    click[i] = false;
    cardX [i] = int((i % 4) * 120) + spacingX; 
    cardY [i] = int(floor(i / 4) * 148) + spacingY;
  }
  
  //設定卡片配對（六組十二張卡）
  for(int i = 0; i < 6; i++)
  {
    cardFace[i] = i + 1;
    cardFace[6+i] = i +1;
  }
  
  //隨機填入卡面數字
  suffleCard();
 
  for(int i = 0; i < 12; i ++)
  {
    myCard[i] = new Cards (cardX[i], cardY[i], cardFace[i]);
  }
  
}


void draw() {
 
  
  
    println("mouseX:"+mouseX);
    println("mouseY:"+mouseY);
   
     /*delayControl(2, GameState.STAGE31);  
    if(millis() > nowTime + delay && isChangingState){ 
    state = newState; 
    isChangingState = false;
    }*/
  
  switch(state) {
  case GameState.START:

    bg.display();

    break;

  case GameState.STAGE10: //stage1 info
    bg.display();
    pss.pssWinNum = 0;
    playerDiceNum = 0;
    comDiceNum = 0;
    dice.diceWin = 0;
    diceBar.w = 0;

    break;

  case GameState.STAGE11: // stage1 play
    switch(stageState) {
    case DiceStage.ANIMATE:

      bg.display();
      dice.diceWin = 0;
     
      if (mousePressed) {
        stageState = DiceStage.PLAY;
        dice.diceAnimate();
        } else {
        dice.diceAnimate();
        dice.displayComDice();
        dice.displayPlayerDice();
        
         //println("comDiceNum"+comDiceNum);
         //println("playerDiceNum"+playerDiceNum);
      }

      diceBar.display();
      break;

    case DiceStage.PLAY:

      if (mousePressed) {
        if(finishChoose == false)
        {
          bg.display();
          diceBar.move();
          diceBar.display();
          dice.diceAnimate();
        }
      }

      dice.displayComDice();
      dice.displayPlayerDice();
      
      if(finishChoose){
        count++;
      }
      
      if (dice.diceWin==1) {
        textSize(28);
        fill(#FFFFFF);
        text("YOU WIN! NEXT STAGE", 180, 180);
        count++;
        if (count >= 240) {
          state = GameState.STAGE20;
          count = 0;
        }
      }

      if (dice.diceWin==2) {
        textSize(28);
        fill(#FFFFFF);
        text("EQUAL! TRY AGAIN", 180, 180);
        equalWait++;
        count++;
        if(equalWait>= 50){ //要讓equal的字消失
          bg.display();
          diceBar.display();
           dice.diceAnimate();
          dice.displayComDice();
          dice.displayPlayerDice();
        }
        
        if (count >= 240) {
          stageState = DiceStage.ANIMATE;
          count=0;
        }
      }

      if (dice.diceWin == 3) {
        textSize(28);
        fill(#FFFFFF);
        text("OH! YOU LOSE", 180, 180);
        count++;
        if (count >= 240) {
          state = GameState.LOSE;
          count=0;
        }
      }
      break;
    }


    break;
  
  case GameState.STAGE20:
     bg.display();
  break;
  
  case GameState.STAGE21:
   
    bg.display();
    player.isWin();
    
    //遊戲開始時，顯示全部卡牌（預設為背面）
    for(int i = 0; i < 12; i ++)
    {
     myCard[i].displayCard();
    }
    
    //如果六對卡牌都被配對，則結束遊戲
    if(winNum == 6)
    { 
      fill(#FFFFFF);
      textSize(60);
      text("YOU WIN!", 180, height/2);
      //delayControl(2,GameState.STAGE31);
      count++;
      //println(count);
      if (count >= 120) {
          state = GameState.STAGE30;
          stageState = PSSstage.START; //here important
          count=0;
      }
    }
    
    timerCard.display();
    timerCard.countDown();
    //println(timerCard.sec);
      
  break;
  
  case GameState.STAGE30: //stage 2 info

    bg.display();

    break;

  case GameState.STAGE31: //剪刀石頭布
    switch(stageState) {

    case PSSstage.START:   //隨機跳動的那個動畫
      bg.display();
      if (pss.choosePlayerHand()) {
        pss.displayHand();
        pss.displayChoiceImage();
        stageState = PSSstage.PLAY;
      } else {
        pss.myhandAnimate();
        pss.displayChoiceImage();
        pss.displayHand();
      }

      break;

    case PSSstage.PLAY: //猜拳

      pss.displayHand();
      pss.isWin();
      if(pss.pssWinNum == 1){
        count ++;
        textSize(28);
        text("YOU WIN! SLAP THE BOSS", 140, 180);
        if( count >= 180){
          stageState = PSSstage.SLAP;
          count = 0; 
        }
      }
      
      if(pss.pssWinNum == 2){
        count ++;
        textSize(28);
        text("EQUAL! TRY AGAIN", 180, 180);
        if( count >= 180){
          stageState = PSSstage.START;
          count = 0; 
           punch.close();
        }
      }
      
      if(pss.pssWinNum == 3){
        count ++;
        textSize(28);
        text("YOU LOSE! DEFEND YOURSELF", 110, 180);
        if( count >= 180){
          stageState = PSSstage.DEFENCE;
          count = 0; 
        }
      }
      hpBar.hpW = 138;
      
      punch.play();// mistery
      punch.loop();
      
      break;

    case PSSstage.SLAP:  //攻擊
      player.displaySlapBg();
      hpBar.display();
      timer.countDown();
      timer.display();
      player.isWin();
      
      if(stageState==PSSstage.SLAP){
      punch.close();
    }else{
     punch.play();// mistery
      punch.loop();
    }
    
     
      
      if (hpBar.hpW <= 0) {
        hpBar.hpW = 0;
        for (int i = 0; i <= 120; i++)
        {
          if (i == 120) { 
            state = GameState.WIN;
             punch.close();
          }
        }
      }
      break;

    case PSSstage.DEFENCE: //防守
      
      //防守的聲音
      
      //int punchCount = 0;
      //if(punchCount < 61){
      // punchCount++;
      // punch.play();
       
      //}
      
      //if(punchCount == 60){
      // punchCount = 0;
      // punch.close();
      //}
      
      player.displayDefenceBg();
      hpBar.display();
      hpBar.myHpDown();
      timer.countDown();
      timer.display();
      player.isWin();
      
     
      //punch.play();
      //punch.loop();
      
      
      if (hpBar.hpW <= 0) {
        for (int i = 0; i <= 120; i++)
        {
          if (i == 120) { 
            state = GameState.LOSE;
            punch.close();
          }
        }
        textSize(40);
        text("YOU LOSE! PAY THE BILL!", 100, height/2);
        hpBar.hpW = 0;
         punch.close();
      }
      break;
    }

    break;

  case GameState.WIN:
    bg.display();
     dice.diceWin = 0;
    winNum = 0;
    resetAll();
    
     punch.close();


    break;

  case GameState.LOSE:
    bg.display();
     dice.diceWin = 0;
    winNum = 0;
    resetAll();
    
     punch.close();
    break;
  }
}


void mouseClicked()
{ 
  if(state==GameState.STAGE21){
  if (myCard[lastCardID_1].flipstate == true || myCard[lastCardID_2].flipstate == true) {
   println("ignore");
   return;
  }

  println("click");
  for(int i = 0; i < 12; i ++)
    {
      if(mouseX > cardX[i] && mouseX < cardX[i] + myCard[i].cardW 
      && mouseY > cardY[i] && mouseY < cardY[i] + myCard[i].cardH
      && click[i] == false)
      {
        myCard[i].displayCardFront();
        click[i] = true;
  
        //設定一對卡片的開啟狀態
        cardStep[flipped] = i; // 第一張牌開啟 cardStep[0] = i 
        flipped ++; // cardStep[1] = i //第二張牌開啟 cardStep[1] = i
        
        //如果已經翻開一對牌，開始檢查配對步驟 //
        if(flipped == 2)
        { 
          flipped = 0;

          //如果配對，將兩張牌移出畫面
          if(cardFace[cardStep[0]] == cardFace[cardStep[1]])
          { 
            println("pair success");
            myCard[i].displayCardFront();
            myCard[i].displayCard();
            myCard[cardStep[0]].Paired();
            myCard[cardStep[1]].Paired();
            println("myCard[cardStep[0]].cardX: "+myCard[cardStep[0]].cardX);
            winNum += 1;
            for(int j=0;j<12;j++){
             click[j]=false;
           }
            
          }
          
          //如果配對失敗，則翻回背面
          if(cardFace[cardStep[0]] != cardFace[cardStep[1]])
          { 
              println("pair failed");
              myCard[i].displayCardFront();
              myCard[i].displayCard();
             
              myCard[cardStep[0]].flipBackwithDelay(1);
              myCard[cardStep[1]].flipBackwithDelay(1);

              println("has flip back");
            
              lastCardID_1 = cardStep[0];
              lastCardID_2 = cardStep[1];
              cardStep[0] = 0;
              cardStep[1] = 0;
            
              for(int j=0;j<12;j++){
              click[j]=false;}           
          }
        }
      }
    }
  }
}

//隨機交換卡牌位置
void suffleCard()
{
  int temp = 0;
  int rand = 0;
  for(int i = 0; i < 12; i++)
  {
    rand = int(random(0, 12));
    temp = cardFace[i];
    cardFace[i] = cardFace[rand];
    cardFace[rand] = temp;
  }
}

void mouseReleased() {
  if (state == GameState.START) {
    if (mouseX >= 0 && mouseX <= width/2) {
      if (mouseY >= 350 && mouseY <= 430){
        state = GameState.STAGE10;
      }
    }
  }


  if (state == GameState.STAGE10) {
    if (mouseX >= 0 && mouseX <= width/2) {
      if (mouseY >= 420 && mouseY <= 450){
        state = GameState.STAGE11;
        stageState = DiceStage.ANIMATE;
      }
    }
  }

  if (state == GameState.STAGE11) {
    if(finishChoose == false)
    {
      //detect player dice number
      diceBar.detectPlayerDice();
      dice.randomComDice();
      if (stageState == DiceStage.PLAY) {
        dice.isWin();
      }
    }
  }

  if (state == GameState.STAGE20) {
      if (mouseX >= 356 && mouseX<=586 && mouseY>=204 && mouseY<=237) {
          state = GameState.STAGE21;
          return;
      }
  }
  
  if (state == GameState.STAGE30) {
    if (mouseX >= width/2 && mouseX <= width) {
      if (mouseY >= 420 && mouseY <= 450){
        state = GameState.STAGE31;
        stageState = PSSstage.START;
      }
    }
  }

  //if (state == GameState.STAGE30) {
  //  state = GameState.STAGE31;
  //}

  //打老闆關卡，按下滑鼠，扣老闆血條
  if (stageState == PSSstage.SLAP) {
    hpBar.hpW -= hpBar.bossSpeed;
  }
  
  if(stageState == PSSstage.SLAP){
   slap.rewind();
      slap.play();
  }

  //防守關卡，按下滑鼠增加自己血量
  if (stageState == PSSstage.DEFENCE) {
    hpBar.hpW += 0.8;
  }

  if (state == GameState.LOSE) {
    //區域偵測
    if (mouseX>=57 && mouseX<=287 && mouseY>=186 && mouseY<=222){
          state = GameState.START;
          finishChoose = false;
    }
  }

  if (state == GameState.WIN) {
    //區域偵測
    if (mouseX>=391 && mouseX<=621 && mouseY>=187& mouseY<=222){
        state = GameState.START;
        finishChoose = false;
    }
  }
}
/*
boolean isChangingState = false;
//ASK TUTOR
void delayControl(int seconds, int new_State)
{
  nowTime = millis();
  delay = seconds*1000;
  newState = new_State;
  isChangingState = true;
}*/