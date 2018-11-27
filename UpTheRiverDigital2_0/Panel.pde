class Panel {
  PVector position, size;
  PImage water, groundL, groundR;
  float shade;
  String name;

  Panel(float x, float y, float w, float h, PImage wat, PImage left, PImage right) {
    position = new PVector(x, y);
    size = new PVector(w, h);
    shade = random(0, 256);
    water = wat;
    name = "Default";
    groundL = left;
    groundR = right;
  }

  void update() {
    //Do nothing
  }

  void draw() {
    fill(shade);

    position.x = 0;
    for (int iWater = 0; iWater < width/size.y; iWater++) {
      if (devMode) {
        stroke(0);
        strokeWeight(4);
        rect(position.x, position.y, size.y, size.y);
        fill(0,0,255);
        rect(position.x, position.y, size.y, size.y);
      }
      image(water, position.x, position.y, size.y, size.y);
      position.x += size.y;
    }
    image(groundLeft, 0, position.y, size.y, size.y);
    image(groundRight, width - size.y, position.y,size.y, size.y);
  }
}

ArrayList<Panel> panels = new ArrayList<Panel>();

void createPanels() {
  float x, y, w, h;
  w = width;
  h = height/(float)MAX_PANELS;
  x = 0;
  y = 0;

  for (int iPanel = MAX_PANELS; iPanel > 0; iPanel--) {
    Panel pnl = new Panel(x, y, w, h, water, groundLeft, groundRight);
    if (iPanel != 11) {
      pnl = panels.get(MAX_PANELS - iPanel - 1);
    }

    if (iPanel == 1) {
      // Special Harbor Panel
      panels.add(new Harbor(x, pnl.position.y - h, w, h, water, groundLeft, groundRight));
    } else {      
      if (iPanel == 6) {    
        // Special wave panel
        panels.add(new Wave(x, pnl.position.y - h, w, h, water, wave, groundLeft, groundRight));
      } else if (iPanel == 11) {   
        // Special SandBank panel
        panels.add(new SandBank(x, height - h, w, h, water, sandBank, groundLeft, groundRight));
      } else {    
        //Normal Panels
        panels.add(new Panel(x, pnl.position.y - h, w, h, water, groundLeft, groundRight));
      }
    }
  }
}

void movePanels() {
  Panel backUpPanel = panels.get(0);
  Panel harborPanel = panels.get(MAX_PANELS - 1);

  for (int iPanel = 0; iPanel < MAX_PANELS - 1; iPanel++) {
    Panel pnl = panels.get(iPanel); 
    Panel prevPnl;
    if (iPanel == 0) {
     prevPnl = panels.get(MAX_PANELS - 2);
      pnl.position.y = prevPnl.position.y;
    } else {
       pnl.position.y += height/MAX_PANELS;
    }
  }

  panels.remove(MAX_PANELS - 1);
  panels.remove(0);

  panels.add(backUpPanel);
  panels.add(harborPanel);

  for (int iPanel = 0; iPanel < MAX_PANELS; iPanel++) {
    Panel pnl = panels.get(iPanel);
    pnl.update();
  }
  
  for(Player pl: players){
    for(int iBoat = 0; iBoat < MAX_BOATS; iBoat++){
      if(pl.boats[iBoat].onPanel != MAX_PANELS - 1) {
        pl.boats[iBoat].onPanel--;  
        pl.boats[iBoat].position.y += height/MAX_PANELS;
      }
    }
  }
}

void drawPanels() {
  for (int iPanel = 0; iPanel < MAX_PANELS; iPanel++) {
    Panel pnl = panels.get(iPanel);
    pnl.draw();
  }
} 
