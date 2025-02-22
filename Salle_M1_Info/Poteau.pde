class Poteau extends QShape {
  private float largeur;
  private float profondeur;
  private float hauteur;
  private PShape poteau;
  private PImage textureMur; // Texture identique au mur

  Poteau(float x, float y, float z, float largeur, float profondeur, float hauteur) {
    super(x, y, z);
    this.largeur = largeur;
    this.profondeur = profondeur;
    this.hauteur = hauteur;
  }

  void creerPoteau(PImage texture) {
    this.textureMur = texture;
    
    poteau = createShape(BOX, largeur, hauteur, profondeur);
    poteau.setTexture(textureMur);
  }

  void rotateY(float angle) {
    poteau.rotateY(angle);
  }

  void translate(float x, float y, float z) {
    poteau.translate(x, y, z);
  }
  
  @Override
  void drawShape() {
    shape(poteau);
  }
}
