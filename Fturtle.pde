class Fturtle extends FGoomba {

  int direction = L;
  int speed     = 50;
  int timer3 = 100;

  Fturtle(float x, float y) {
    super(x, y);
    setPosition(x, y);
    setName("turtle");
    setRotatable(false);
  }

  void act() {
    animatedd();
    collide();
    move();
    timer3--;
    hammer();
  }
  void animatedd() {
    if (frame>= turtle.length) frame=0;
    if (frameCount % 5 ==0) {
      if (direction == R) attachImage(turtle[frame]);
      if (direction == L) attachImage(reverseImage(turtle[frame]));
      frame++;
    }
  }

  void collide() {
    if (timer3==0) {
      direction *= -1;
      setPosition(getX() +direction, getY());
      timer3 = 100;
    }
    if (isTouching("player")) {
      if (player.getY()< getY()- gridSize/2) {
        world.remove(this);
        enemies.remove(this);
        money++;
        player.setVelocity(player.getVelocityX(), -300);//makes it jump
      } else {
        lives--;//fix this
        player.setPosition(1500, 2000);
      }
    }
  }
  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }

  void hammer() {
    int vx= 150;
    if (timer3==0 ) {
      FBox hammer = new FBox(50, 50);
      hammer.setName("hammer");
      hammer.setPosition(getX(), getY());
      hammer.attachImage(hammerbro);
      hammer.setRotatable(true);
      hammer.setSensor(true);
      hammer.setVelocity(vx, -450);
      hammer.setAngularVelocity(5);
      world.add(hammer);
    }
  }
}
