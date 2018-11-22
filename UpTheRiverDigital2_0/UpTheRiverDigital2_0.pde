void setup() {
  size(800, 1020);
  noStroke();
  smooth();
  frameRate(120);
  mainSetup();
}

void draw() {
  drawPanels();
  
  for (Player pl : players) {
    pl.draw();
    pl.update();
  }
}

void keyPressed() {
  keysPressed[keyCode] = true;
}

void keyReleased() {
  keysPressed[keyCode] = false;
  if (!keysPressed[ENTER])
    enterPressed = false;

  for (Player pl : players)
    pl.changedSelected = false;
}
