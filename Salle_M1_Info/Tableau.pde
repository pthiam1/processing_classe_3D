class Tableau extends QShape {
  // Dimensions du tableau
  float largeur = 1100;
  float hauteur = 400;
  float profondeur = 5;

// Texture du tableau
PImage texture;

    Tableau(float x, float y, float z) {
        super(x, y, z);
    }
    
    // Creer le tableau avec une texture
    void creerTableau(PImage textureTableau) {
        texture = textureTableau;
        
        shape = createShape();
        shape.beginShape(QUADS);
        shape.texture(texture);
        shape.noStroke();
        
        shape.vertex(-largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
        shape.vertex(largeur / 2, -hauteur / 2, -profondeur / 2, texture.width, 0);
        shape.vertex(largeur / 2, hauteur / 2, -profondeur / 2, texture.width, texture.height);
        shape.vertex(-largeur / 2, hauteur / 2, -profondeur / 2, 0, texture.height);
        
        shape.endShape();
    }
    
    void dessine() {
        shape(shape);
    }
    }

