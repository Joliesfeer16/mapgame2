class FPlayer extends FGameObject {

  int frame;
  int direction;

  FPlayer() {
    super();
    setPosition(1500,2000);
    //heaven 2400, 500
    //jail 2050, 3300
    //heaven from treasure 2300, 500
    //hell (1500, 3100);
    //setPosition(1500, 2000);
    setName("player");
    setRotatable(false);
    setFillColor(red);
    timer=5;
    direction = R;
  }

  void act() {
    collision();
    handleInput();
    animate();
  }
  void collision() {
    if (isTouching("spike")|| isTouching("Lava")||isTouching("trap")) {
      danger();
    }
    if (isTouching("boulder")||isTouching("hammer")) { //make it so that only the bottom of boulder and top of player collide
      lives--;
      setPosition(1500, 2000);
    }
    if (isTouching("helldoor")) {
      setPosition(1500, 2000);
      lives=5;
    }
    if (isTouching("heavendoor")) {
      setPosition(1500, 2000);
      money=money+10;
    }
    //if (isTouching("treasure")&& money>=10 && lives<=3) {
    //  setPosition(2300, 500);
    //}
  }

  void handleInput() {
    float vx = getVelocityX();
    float vy = getVelocityY();
    if (abs(vy) < 0.1) {
      action = idle;
    }

    if (akey) {
      setVelocity(-300, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      setVelocity(300, vy);
      action = run;
      direction = R;
    }
    if (hitGround(player)) {
      if (skey) {
        setVelocity(vx, 300);
      }

      if (wkey) {
        setVelocity(vx, -300);
      }
    }
    if (abs(vy) > 0.1)
      action = jump;
  }

  void animate() {
    if (frame>= action.length) frame=0;
    if (frameCount % 5 ==0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }

  void danger() {
    timer--;
    setVelocity(getVelocityX(), -300);
    if (timer==0) {
      lives--;
      timer = 5;
    }
  }
}
