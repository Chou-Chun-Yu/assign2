//You should implement your assign2 here.
PImage bg1,  bg2, enemy, fighter, hpbar, treasure, start1, start2, end1, end2;

final int GAME_START=0, GAME_LOSE=1, GAME_RUN=3, BEGIN_HP = 40;

float fighterX, fighterY, fighterSpeed = 5;

int enemyX,enemyY,background1,background2,hp,treasureX,treasureY, gameState;

boolean isPlaying = false, 
        upPressed = false, downPressed = false, 
        leftPressed = false, rightPressed = false;

void setup () {
  size(640, 480);
  
  gameState = GAME_START;
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png"); 
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hpbar = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  background1 = -640;
  background2 = 0;
  treasureX = floor(random(600));
  treasureY = floor(random(440));
  hp = BEGIN_HP;
  enemyX = 0;
  enemyY = floor(random(60,420));
  fighterX = 590;
  fighterY = floor(random(50,430));
}

void draw() {
  background(0);
  
  switch (gameState){
   case GAME_START:
    image (start1, 0, 0);
    if (mouseX > 205 && mouseX <455 && mouseY > 375 && mouseY < 415){
      if (mousePressed){
        gameState = GAME_RUN;
        isPlaying = true;
        enemyX = 0;
        enemyY = floor(random(60,420));
        fighterX = 590;
        fighterY = floor(random(50,430));
        treasureX = floor(random(600));
        treasureY = floor(random(440));
      }else{
        noStroke();
        image (start2, 0, 0);
      }
    }
   break;
   case GAME_RUN:
   
     image(bg1,background1,0); //bg1
     background1 = background1 +2;
     if (background1 == 640){
       background1 = -640;
     }
     image(bg2,background2,0); //bg2
     background2 = background2 +2;
     if (background2 == 640){
       background2 = -640;
     }

     image(enemy,enemyX,enemyY);  //enemy
     if (enemyY < fighterY){
         enemyY = enemyY + 4;
     }
       if (enemyY > fighterY){
         enemyY = enemyY - 4;
     }
     if (enemyX >= fighterX-25 && enemyX <= fighterX+25){
        if(enemyY >= fighterY-25 && enemyY <= fighterY+25){
          hp = hp - 40;
          enemyX = 0;
          enemyY = floor(random(60,420));
          if (hp - 40 <= 0){
            gameState = GAME_LOSE;
          }
        }
     }
     enemyX %= 640;
     enemyX = enemyX+4;
  
     image(fighter,fighterX,fighterY);  //fighter
     if (upPressed){
       fighterY -= fighterSpeed;
     }
     if (downPressed){
       fighterY += fighterSpeed;
     }
     if (leftPressed){
       fighterX -= fighterSpeed;
     }
     if (rightPressed){
       fighterX += fighterSpeed;
     }
     if (fighterX > width-50){
       fighterX = width-50;
     }
     if (fighterX < 0){
       fighterX = 0;
     }
     if (fighterY > height-50){
       fighterY = height-50;
     }
     if (fighterY < 0){
       fighterY = 0;
     }
  
     fill(#ff0000);  //hp
     rectMode(CORNER); 
     rect(5,5,hp,20);
     image(hpbar,0,0); 

     image(treasure,treasureX,treasureY);  //treasure/*
     if (treasureX >= fighterX-25 && treasureX <= fighterX+25){
       if(treasureY >= fighterY-25 && treasureY <= fighterY+25){
         if (hp < 200){
           hp = hp + 20;
         }
         treasureX = floor(random(600));
         treasureY = floor(random(440));
        }
     }
     
   break;
   case GAME_LOSE:
     image (end1, 0, 0);
     if (mouseX > 210 && mouseX <435 && mouseY > 310 && mouseY < 345){
       if (mousePressed){
         gameState = GAME_START;
       }else{
         noStroke();
         image (end2, 0, 0);
       }
     }
   break;
  }
}
void keyPressed(){
  if (key == CODED){
    switch (keyCode){
      case UP:
        upPressed = true;
      break;
      case DOWN:
        downPressed = true;
      break;
      case LEFT:
        leftPressed = true;
      break;
      case RIGHT:
        rightPressed = true;
      break;
    }
  }
}
void keyReleased(){
    if (key == CODED){
      switch (keyCode){
        case UP:
          upPressed = false;
        break;
        case DOWN:
          downPressed = false;
        break;
        case LEFT:
          leftPressed = false;
        break;
        case RIGHT:
          rightPressed = false;
        break;
    }
  }
}
