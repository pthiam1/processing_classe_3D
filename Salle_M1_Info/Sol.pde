class Sol extends QShape {
  Sol(float x, float y, float z) {
    super(x, y, z);
  }

  void creerSol(float largeur, float profondeur, PImage texture) {
    shape = createShape();
    shape.beginShape(QUADS);
    shape.texture(texture);
    shape.noStroke();
    
    shape.vertex(-largeur / 2, hauteurSalle / 2, -profondeur / 2, 0, 0);  
    shape.vertex(largeur / 2, hauteurSalle / 2, -profondeur / 2, texture.width, 0); 
    shape.vertex(largeur / 2, hauteurSalle / 2, profondeur / 2, texture.width, texture.height); 
    shape.vertex(-largeur / 2, hauteurSalle / 2, profondeur / 2, 0, texture.height); 
    
    shape.endShape();

  }
  
  
  void dessine() {
    shape(shape);
  }
}
