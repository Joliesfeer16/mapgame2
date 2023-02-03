class FLava extends FGameObject {
  //PImage lava0, lava1, lava2, lava3, lava4, lava5;
  //PImage[] images = {lava0, lava1, lava2, lava3, lava4, lava5};
  //int randomImage = (int) random(0, 6);

  PImage [] animation;
  int number;
  int k;
  int frame= 0;


  FLava(float x, float y) {
    super();
    setPosition(x, y);
    setName("Lava");

    setStatic(true);
    setSensor(true);

   
  }

  void show() {
    if (frame>= lava.length) frame=0;
    if (frameCount % 5 ==0) {
      attachImage(lava[frame]);
      frame++;
    }
  }
  void act() {
    //if (isTouching("player")) {
    //  setSensor(false);
    //}
  }
}
