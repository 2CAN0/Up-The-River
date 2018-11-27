class SandBank extends Panel {
  PImage sand;
  
  SandBank(float x, float y, float w, float h, PImage water, PImage sandBank, PImage left, PImage right) {
    super(x, y, w, h, water, left, right);
    name = "SandBank";
    sand = sandBank;
  }

  void udpate() {
    //Stop the player
  }

  void draw() {
    position.x = 0;
    for (int iWater = 0; iWater < width/size.y; iWater++) {
      if (devMode) {
        stroke(0);
        strokeWeight(4);
        rect(position.x, position.y, size.y, size.y);
        fill(10, 10, 255);
        rect(position.x, position.y, size.y, size.y);
      }

      image(water, position.x, position.y, size.y, size.y);
      if (iWater % 2 == 0)
        image(sand, position.x, position.y, size.y, size.y);
      position.x += size.y;
    }
    image(groundLeft, 0, position.y, size.y, size.y);
    image(groundRight, width - size.y, position.y,size.y, size.y);
    textAlign(CENTER, CENTER);
    fill(0);
    text("SandBank", width/2, position.y + size.y/2);
  }
}
