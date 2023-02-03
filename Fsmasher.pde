class Fsmasher extends FGameObject {
  int direction = R;
  int speed     = 50;
  int timerjail=100;

  Fsmasher (float x, float y) {
    super();
    setPosition(x, y+gridSize*2);
    setName("smasher");
    attachImage(smasher);
  }

  void act() {
    move();
    collide();
   
  }

  void move() {
    float vx = getVelocityX();
    setVelocity(vx, speed*direction);
    if (isTouching("walls")) {
      direction *= -1;
      setPosition(getX(), getY()+direction);
    }
  }

  void collide() {
    if (isTouching("player")) {
      player.setPosition(2050, 3300);//jail
  }
    if (player.getX()>1700 && player.getY()>2900){
      timerjail--;
    }
    if (timerjail==0) {
        player.setPosition(1500, 3100);
        timerjail =100;
      }
  }
}
