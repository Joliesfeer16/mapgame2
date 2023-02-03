void game() {
  background(black);
  
  //lives icon
  textSize(30);
  int i=0;
  int x=50;
  while (i<lives) {
    image(heart, x, 50, 50, 50);
    x=x+50;
    i++;
  }

  //money icon
  image(coin, 700, 10, 100, 100);
  textSize(45);
  text("$" + money, 660, 73);
  
  //gameover
   if (lives==0 && player.getY()<2500) {
   player.setPosition(1500, 3100);
   lives=3;
  }
    if (lives==0 && player.getY()>2800) {
   mode=GAMEOVER;
  }
  
  actWorld();
  drawWorld();
  //makeWorld(map);
  //makePlayer();
}

void actWorld() {
  player.act();
  for (int i=0; i<terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
    t.show();
  }
  for (int i=0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+ width/3, -player.getY()*zoom + height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
