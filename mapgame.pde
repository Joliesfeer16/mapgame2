
//make the function for repeating the collisions
//make smasher (same as boulder), but if you get smashed it takes you to prison
//prison has a timer, timer last 10 seconds, then teleported back to hell


//add sound effects
//fix lava
//make mode framework
//make treasure class
//make gameover, intro, reset all
//make prison move out of the hammer way
//make heaven longer, for car



import fisica.*;
FWorld world;

//color pallette
color white = #FFFFFF;
color black = #000000;
color green = #00FF00;
color red   = #FF0000;
color blue  = #0000FF;
color cyan  = #00FFFF;
color middleGreen = #00FF00;
color leftGreen   = #009F00;
color rightGreen  = #006F00;
color centerGreen = #004F00;
color treeTrunkBrown = #FF9500;
color orange = #F0A000;
color brown  = #996633;
color spikyGrey = #b4b4b4;
color darkBlue = #2f3699;
color bridgered = #990030;
color lavared0 = #993d00;
color lavared1 = #452107;
color lavared2 = #de6107;
color lavared3 = #c47944;
color lavared4 = #b34800;
color redtub   = #750000;
color goombacolor   = #6f3198;
color walls    = #ffa3b1;
color bouldercolor  = #ffc30e;
color turtlebro = #ffee00;
color hammerguy = #464646;
color trapcolor = #0000ff;
color treasurecolor= #ff00d0;
color coincolor = #ffffff;
color doorouthell= #ff008c;
color heavendoor = #0091ff;
color heavencar  = #709ad1;
color heartheaven = #1e00ff;
color smashercolor    = #071f00;
color jailprison  = #ffd900;

//timers
int timer=-1;
int timer2=-2;
//Images
PImage map, ice, stone, spike, trampoline, bridgeCenter, bridgeLeft, bridgeRight, hammerbro;
PImage treeTrunk, treeIntersect, treeMiddle, treeLeft, treeRight, lavatub, heart, jail;
PImage coin, trap, treasure, helldoor, heartpoints, smasher, othermap, car;

//Images array
PImage [] idle, jump, run, action, chosen, goomba, lava, turtle, boulderRest, boulderMad;

//extras
int gridSize = 32;
float zoom = 1.5;
int lives=5;
int money = 0;

//Mouse & Keyboard interaction variables
boolean mouseReleased;
boolean wasPressed;
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey;

//Fbodies
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
FPlayer player;

//button
Button restart;

//mode framework
int mode;
final int INTRO    = 1;
final int GAME     = 2;
final int GAMEOVER = 3;
final int HELL     = 4;


void setup() {
  size(800, 800);
  rectMode(CENTER);
  mode= GAME;
  Fisica.init(this); //initialize fisica
  terrain = new ArrayList<FGameObject> ();
  enemies = new ArrayList<FGameObject> ();
  loadImages();
  map.get(0, 0);
   makeWorld(map);
  makePlayer();
}


void loadImages() {

  //load regular images
  map = loadImage("newversion.png");
  othermap = loadImage("colormap.png");
  bridgeCenter= loadImage("bridge.png");
  bridgeLeft= loadImage("bridge_w.png");
  bridgeRight= loadImage("bridge_e.png");
  stone = loadImage("brick.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  treeIntersect = loadImage("tree_intersect.png");
  treeMiddle = loadImage("treetop_center.png");
  treeLeft = loadImage("treetop_w.png");
  treeRight = loadImage("treetop_e.png");
  spike = loadImage("spike.png");
  trampoline = loadImage("blueBlock.png");
  heart = loadImage("corazon.png");
  heart.resize(gridSize, gridSize);
  hammerbro= loadImage("hammer.png");
  coin = loadImage("coin.png");
  coin.resize(gridSize*2, gridSize*2);
  trap = loadImage("trap.png");
  trap.resize(gridSize*2, gridSize*2);
  treasure = loadImage("treasure.png");
  treasure.resize(gridSize*2, gridSize*2);
  helldoor = loadImage("helldoor.png");
  helldoor.resize(gridSize*3, gridSize*3);
  car = loadImage("car.png");
  heartpoints = loadImage("heartpoints.png");
  smasher = loadImage("smasher.png");
  smasher.resize(gridSize*2, gridSize*2);
  lavatub = loadImage("lavadeep.png");
  jail = loadImage("jail.png");
  jail.resize(gridSize*5, gridSize*5);

  //load array images
  //lava
  lava = new PImage [6];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5] = loadImage("lava5.png");

  //mario actions
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");
  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");
  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");
  action = idle;

  //enemies
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);

  //boulder
  boulderRest = new PImage[1];
  boulderRest[0] = loadImage("thwomp0.png"); //idle
  boulderMad = new PImage[1];
  boulderMad[0] = loadImage("thwomp1.png"); //mad
  chosen = boulderRest;

  //turtle
  turtle = new PImage[2];
  turtle[0] = loadImage("hammerbro0.png");
  turtle[0].resize(gridSize, gridSize);
  turtle[1] = loadImage("hammerbro1.png");
  turtle[1].resize(gridSize, gridSize);
}


void makeWorld(PImage img) {
  world = new FWorld(-9000, -9000, 9000, 9000); //make the world (top left x and y, bottom x and y
  world.setGravity(0, 981);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c==black) {
        b.attachImage(stone);
        b.setFriction(6);
        b.setName("stone");
        world.add(b);
      }
      if (c== cyan) {
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      }
      if (c== treeTrunkBrown) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setFriction(4);
        b.setName("tree trunk");
        world.add(b);
      }
      if (c== centerGreen) {
        b.attachImage(treeIntersect);
        b.setName("treetop");
        world.add(b);
      }
      if (c== middleGreen) {
        b.attachImage(treeMiddle);
        b.setName("treetop");
        world.add(b);
      }
      if (c== leftGreen) {
        b.attachImage(treeLeft);
        b.setName("treetop");
        world.add(b);
      }
      if (c== rightGreen) {
        b.attachImage(treeRight);
        b.setName("treetop");
        world.add(b);
      }
      if (c== spikyGrey) {
        b.attachImage(spike);
        b.setName("spike");
        world.add(b);
      }
      if (c== darkBlue) {
        b.attachImage(trampoline);
        b.setRestitution(3);
        b.setName("trampoline");
        world.add(b);
      }

      if (c == bridgered) {
        FBridge br = new FBridge (x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      }
      if (c== lavared0) {
        FLava lav = new FLava (x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      }
      if (c== lavared2) {
        FLava lav = new FLava (x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      }
      if (c== lavared3) {
        FLava lav = new FLava (x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      }
      if (c== lavared4) {
        FLava lav = new FLava (x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      }

      if (c== lavared1) {
        FLava lav = new FLava (x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      }
      if (c== redtub) {
        b.setFillColor(redtub);
        b.setStrokeColor(redtub);
        b.setStatic(true);
        b.setSensor(true);
        b.setName("Lava");
        world.add(b);
      }
      if (c == goombacolor) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      }
      if (c== walls) {
        b.attachImage(stone);
        b.setName("walls");
        b.setFriction(4);
        world.add(b);
      }
      if (c == bouldercolor) {
        FBoulder bld = new FBoulder(x*gridSize, y*gridSize);
        enemies.add(bld);
        world.add(bld);
      }
      if (c== turtlebro) {
        Fturtle tlt = new Fturtle(x*gridSize, y*gridSize);
        enemies.add(tlt);
        world.add(tlt);
      }
      if (c== trapcolor) {
        b.attachImage(trap);
        b.setName("trap");
        world.add(b);
      }
      if (c== coincolor) {
        Fcoin cn = new Fcoin (x*gridSize, y*gridSize);
        enemies.add(cn);
        world.add(cn);
      }
       if (c== treasurecolor) {
        Ftreasure tr = new Ftreasure (x*gridSize, y*gridSize);
        enemies.add(tr);
        world.add(tr);
      }
      if (c== doorouthell) {
        b.attachImage(helldoor);
        b.setName("helldoor");
        world.add(b);
      }
      if (c== heavendoor) {
        b.attachImage(helldoor);
        b.setName("heavendoor");
        world.add(b);
      }
      if (c== heavencar) {
        Fcar car = new Fcar(x*gridSize, y*gridSize);
        enemies.add(car);
        world.add(car);
      }
      if (c== heartheaven) {
        Fheart ht = new Fheart (x*gridSize, y*gridSize);
        enemies.add(ht);
        world.add(ht);
      }
      if (c== smashercolor) {
        Fsmasher sm = new Fsmasher (x*gridSize, y*gridSize);
        enemies.add(sm);
        world.add(sm);
      }
      if (c== jailprison) {
       b.attachImage(jail);
        b.setName("jail");
        world.add(b);
      }
    }
  }
}

void makePlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  click();
   restart = new Button("Restart", width/2, 600, 150, 100, red, white);
  // if (mode == INTRO) {
  // intro();
  // }
  if (mode == GAME) {
    game();
  } else if (mode == GAMEOVER) {
    gameOver();
  } else if (mode == HELL){
    hell();
  }
}
