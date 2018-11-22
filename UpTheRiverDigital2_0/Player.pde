class Player {
  boolean turn = false;
  boolean diceRolled = false;
  boolean isMoving = false;
  boolean changedSelected = false;
  int movePanels, maxBoats;
  int selectedBoat = 0;
  int nextPanel;
  int maxPlayers;
  Boat[] boats;

  Player(int mBoats, int stPanel, int mPlayers, float boatX, float boatW, float boatH, float boatS, String boatC) {
    maxBoats = mBoats;
    boats = new Boat[maxBoats];
    for (int iBoat = 0; iBoat < maxBoats; iBoat++) {
      if (iBoat != 0) {
        boats[iBoat] = new Boat(stPanel, boats[iBoat - 1].position.x + boatW + boatS, boatW, boatH, boatC);
      } else {
        boats[iBoat] = new Boat(stPanel, boatX - (( maxBoats/2 * boatW) + ((maxBoats - 1/2)* boatS)), boatW, boatH, boatC);
      }
    }

    maxPlayers = mPlayers;
  }

  void rollTheDice() {
    movePanels = (int)Math.floor(random(1, 7)); 
    diceRolled = true;
  }

  void update() {
    if (turn) {
      if (!diceRolled) {
        println("Press Space to roll the dice!");
        if (keysPressed[char(' ')]) {
          rollTheDice();
          println("You rolled the dice and threw: "+movePanels);
          println("Select Your Boat Now\nBoat #"+(selectedBoat + 1)+" is selected");
        }
      } else if (diceRolled) {
        if (!isMoving) {
          if (keysPressed[LEFT] && selectedBoat > 0 && !changedSelected) {
            boats[selectedBoat].selected = false;
            selectedBoat--;
            boats[selectedBoat].selected = true;

            changedSelected = true;
            println("Boat #"+(selectedBoat + 1)+" is selected");
          } else if (keysPressed[RIGHT] && selectedBoat < maxBoats - 1 && !changedSelected) {
            boats[selectedBoat].selected = false;
            selectedBoat++;
            boats[selectedBoat].selected = true;

            changedSelected = true;
            println("Boat #"+(selectedBoat + 1)+" is selected");
          } else
            boats[selectedBoat].selected = true;

          if (keysPressed[ENTER]) {
            boats[selectedBoat].move(); 
            isMoving = true;
            nextPanel = boats[selectedBoat].onPanel + movePanels;
            if(nextPanel >= MAX_PANELS)
              nextPanel = MAX_PANELS - 1;
          }
        } else {
          if (boats[selectedBoat].onPanel != nextPanel) {
            boats[selectedBoat].move();
            Panel active = panels.get(boats[selectedBoat].onPanel);
            if (active.name == "SandBank" && !boats[selectedBoat].onSandBank) {
              nextPanel = boats[selectedBoat].onPanel;
              boats[selectedBoat].onSandBank = true;
              println("You got stuck in a sandBank");
            }
          } else { 
            Panel active = panels.get(boats[selectedBoat].onPanel);
            if (active.name == "Wave" || boats[selectedBoat].onPanel != nextPanel) {
              println("You caught a wave and will move 3 spots forward");
              nextPanel += 3;
              boats[selectedBoat].move();
              if ( active.name == "SandBank") {
                nextPanel = boats[selectedBoat].onPanel;
                println("You got stuck in a sandBank");
              }
            } else {

              turn = false;
              diceRolled = false;
              isMoving = false;
              boats[selectedBoat].selected = false;

              if (selectedPlayer < maxPlayers - 1) {
                selectedPlayer += 1;
              } else {
                selectedPlayer = 0;
                movePanels();
              }

              players[selectedPlayer].turn = true;
            }
          }
        }
      }
    }
  }

  void draw() {
    for (Boat bt : boats) {
      bt.draw();
    }
  }

  class Boat {
    PVector position, size;
    boolean selected = false;
    boolean onSandBank = false;
    int onPanel;
    int r, g, b;

    Boat(int stPanel, float x, float w, float h, String boatC) {
      onPanel = stPanel; 
      Panel pnl = panels.get(onPanel);
      size = new PVector(w, h);
      position = new PVector(x, pnl.position.y + pnl.size.y/2 - size.y/2);  
      colorCreater(boatC);
    }

    void colorCreater(String boatC) {
      if (boatC.toLowerCase() == "red") {
        r = 255;
        g = 0;
        b = 0;
      } else if (boatC.toLowerCase() == "green") {
        r = 0;
        g = 255;
        b = 0;
      } else if (boatC.toLowerCase() == "blue") {
        r = 0;
        g = 0;
        b = 255;
      } else if (boatC.toLowerCase() == "yellow") {
        r = 255;
        g = 255;
        b = 0;
      } else {
        r = 255;
        g = 255;
        b = 255;
      }
    }

    void move() {
      if (onPanel != MAX_PANELS - 1) {
        position.y -= 4.0; //Boat speed make it a global var
        Panel pnl = panels.get(onPanel + 1);

        if (position.y <= pnl.position.y + pnl.size.y/2 - size.y/2) {
          onPanel += 1;
          onSandBank = false;
        }
      }
    }

    void draw() {
      if (selected && turn) {
        fill(0, 0);
        stroke(255, 152, 226);
        strokeWeight(3);
        ellipse(position.x + size.y/2, position.y + size.y/2, size.y *2, size.y*2);
      }

      noStroke();
      fill(r, g, b);
      rect(position.x, position.y, size.x, size.y);
    }
  }
}
