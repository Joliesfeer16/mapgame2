class FBoulder extends FGameObject {
 
  int frame= 0;

  FBoulder (float x, float y) {
    super();
    setPosition(x+gridSize/2, y+gridSize/2);
    setName("boulder");
    setRotatable(false);
    setStatic(true);
  }

  void act() {
    animation();
    collided();
  }

  void animation() {
    if (frame>= chosen.length) frame=0;
    if (frameCount % 5 ==0) {
      attachImage(chosen[frame]);
      frame++;
    }
  }

  void collided() {
    if (player.getX()> getX()-gridSize/2 && player.getX()< getX()+gridSize/2 && player.getY()>getY()+gridSize/2&& player.getY()<getY()+100 ) {
      chosen= boulderMad;
      setStatic(false);
      setSensor(false);
    }
  }
}
