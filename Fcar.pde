class Fcar extends FGameObject {
  int direction = L;
  int speed     = 180;
  
  Fcar(float x, float y) {
    super();
    setPosition(x, y);
    setName("car");
    setRotatable(false);
    attachImage(reverseImage(car));
  }

  void act() {
    move();
  }

  void move() {
    if (isTouching("player") && getY()<2200) {
      float vy = getVelocityY();
      player.setPosition(getX(), player.getY());
      setVelocity(speed*direction, vy);
    }
  }
}
