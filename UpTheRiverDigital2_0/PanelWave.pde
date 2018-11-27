class Wave extends Panel {
  PImage wave;

  Wave(float x, float y, float w, float h, PImage wat, PImage wav, PImage left, PImage right) {
    super(x, y, w, h, wat, left, right);
    wave = wav;
    name = "Wave";
  }

  void update() {
    //If player has no remaining steps move three panels forward
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
      image(wave, position.x, position.y, size.y, size.y);
      position.x += size.y;
    }
    image(groundLeft, 0, position.y, size.y, size.y);
    image(groundRight, width - size.y, position.y,size.y, size.y);
    textAlign(CENTER, CENTER);
    fill(0);
    text("Wave", width/2, position.y + size.y/2);
  }
}
