class Fheart extends Fcoin {

  Fheart(float x, float y) {
    super(x, y);
    setPosition(x, y);
    setName("heart");
    attachImage(heart);
  }
   void collide() {
    if (isTouching("player")) {
      world.remove(this);
      enemies.remove(this);
      if(lives<5){
      lives++;
      }
    }
  }
}
