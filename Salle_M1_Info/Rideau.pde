class Rideau extends QShape {
  PImage texture;
  float largeur, hauteur;
  boolean ouvert;
  float positionZ;
  float positionFerme;
  float positionOuvert;
  float vitesseAnimation = 2; // Vitesse d'animation du rideau
  boolean gauche; // Indique si le rideau est à gauche ou à droite

  // Géométrie du rideau
  PShape rideauShape;
  float epaisseurRideau = 0; // Épaisseur du rideau

  Rideau(float x, float y, float z, float largeur, float hauteur, PImage texture, boolean gauche) {
    super(x, y, z);
    this.largeur = largeur;
    this.hauteur = hauteur;
    this.texture = texture;
    this.ouvert = false;
    this.gauche = gauche;
    this.positionZ = z;
    this.positionFerme = z;
    this.positionOuvert = gauche ? z - (largeur / 2) : z + (largeur / 2); // Position ouverte (le rideau monte ou descend)
  }

  void creerRideau() {
   

    // Créer la géométrie du rideau
    rideauShape = createShape(BOX, largeur, hauteur, epaisseurRideau);
    rideauShape.setTexture(texture);
    rideauShape.setStroke(false);
    rideauShape.translate(0, -hauteur / 2, 0); // Positionner le rideau sous la tringle
  }

  void tourner(float angle) {
    // Tourner le rideau
    rideauShape.rotateY(angle);
    rideauShape.translate(0, 0, -epaisseurRideau / 2);
   
    
  }

  void toggle() {
    // Basculer entre ouvert et fermé
    if (ouvert) {
      fermer();
    } else {
      ouvrir();
    }
  }

  void ouvrir() {
    // Animation pour ouvrir le rideau
    new Thread(() -> {
      while ((gauche && positionZ > positionOuvert) || (!gauche && positionZ < positionOuvert)) {
        positionZ += gauche ? -vitesseAnimation : vitesseAnimation;
        rideauShape.translate(0, 0, gauche ? -vitesseAnimation : vitesseAnimation);
        delay(16); // Simuler une fréquence d'image de ~60 FPS
      }
      ouvert = true;
    }).start();
  }

  void fermer() {
    // Animation pour fermer le rideau
    new Thread(() -> {
      while ((gauche && positionZ < positionFerme) || (!gauche && positionZ > positionFerme)) {
        positionZ += gauche ? vitesseAnimation : -vitesseAnimation;
        rideauShape.translate(0, 0, gauche ? vitesseAnimation : -vitesseAnimation);
        delay(16); // Simuler une fréquence d'image de ~60 FPS
      }
      ouvert = false;
    }).start();
  }

  @Override
  void drawShape() {
    shape(rideauShape);
  }
}