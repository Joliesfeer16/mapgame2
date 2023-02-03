class Ftreasure extends Fcoin {

  Ftreasure(float x, float y) {
    super(x, y);
    setPosition(x, y);
    setName("treasure");
    attachImage(treasure);
  }
   void collide() {
    if (isTouching("player")&& money>=2 && lives<=3) {
      world.remove(this);
      enemies.remove(this);
      player.setPosition(2300, 500);
    }
  }
}
