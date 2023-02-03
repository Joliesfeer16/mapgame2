class Fcoin extends FGameObject {
  int direction = L;
  int speed     = 50;
  int cointimer = 15;
  
  Fcoin(float x, float y) {
    super();
    setPosition(x, y);
    setName("coin");
    setRotatable(true);
    attachImage(coin);
  }
  
  void act() {
    collide();
    move();
    cointimer--;
  }
  
  void collide() {
    if (isTouching("player")) {
      world.remove(this);
      enemies.remove(this);
      money++;
    }
  }
  
  void move() {
    float vx = getVelocityX();
    setVelocity(vx, speed*direction);
    if (cointimer ==0) {
      direction *= -1;
      setPosition(getX(), getY()+direction);
      cointimer=15;
    }
  }
}
