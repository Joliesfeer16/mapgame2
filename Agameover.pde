void gameOver() {
  background(0);
  restart.show();
  if (restart.clicked) {
    // player.setPosition(1500, 500);
    mode = GAME;
   setup();
  }
}
