class SandBank extends Panel{
    SandBank(float x, float y, float w, float h, PImage sandBank){
       super(x, y, w, h, sandBank);
       name = "SandBank";
    }
    
    void udpate(){
      //Stop the player
    }
    
    void draw(){
      fill(255, 255, 0);
      rect(position.x, position.y, size.x, size.y);  
      fill(255);
      textSize(txtSize);
      textAlign(CENTER, CENTER);
      text("SandBank", width/2, position.y + size.y/2);
    }
}
