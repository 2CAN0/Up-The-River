class Harbor extends Panel{
    Harbor(float x, float y, float w, float h, PImage harbor){
       super(x, y, w, h, harbor);
       name = "Harbor";
    }
    
    void update(){
       //Placement System 
    }
    
    void draw(){
      fill(255, 255, 0);
      rect(position.x, position.y, size.x, size.y); 
      fill(255);
      textSize(txtSize);
      textAlign(CENTER, CENTER);
      text("HARBOR", width/2, position.y + size.y/2);
    }
}
