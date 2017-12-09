class Cards
{
 int cardNum = 13;  //13 poker cards
 int show = 0; //show出哪一張牌
 int cardW = 100;
 int cardH = 138;
 int cardX = 0;
 int cardY = 0;
 int cardFaceNum = 0;
 
 int flipTime = 0;
 int delayTime = 0;
 boolean flipstate = false;

 PImage pokerCard;
 String [] cardName = new String [cardNum]; //建立13個cardname空間

  
 Cards(int x, int y, int fv)
 {
   cardX = x;
   cardY = y;
   cardFaceNum = fv;
   for(int i = 0; i < cardNum; i ++)
   {
     cardName[i] = "poker" + i + ".png" ;//把每張圖的連結存到string裡
   }
 }
  
 void displayCard()
 {

   if ( millis() > flipTime + delayTime && flipstate) {
      show = 0;
      flipstate = false;
   }
   pokerCard = loadImage("img/" + cardName[show]);//image初始化
   image(pokerCard, cardX, cardY);//display圖片   
 }

 void displayCardFront()
 {
   show = cardFaceNum; //指定要秀哪張牌
 }
 
 //如果卡片配對成功，兩張卡一起消失。
 void Paired()
 {
   cardX = -width;//x座標在圖外
 }

 void flipBack(){
   show = 0;
 }
 
 void flipBackwithDelay(int seconds){
   flipTime = millis();
   delayTime = seconds * 1000;
   flipstate = true;
 }
 
 
}