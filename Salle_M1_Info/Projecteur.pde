class Projecteur extends QShape {
  private float largeur, hauteur, profondeur;
  private PShape boitier, lentille, fixation;
  private PImage textureBoitier, textureLentille;

  Projecteur(float x, float y, float z, PImage textureBoitier, PImage textureLentille) {
    super(x, y, z);
    this.textureBoitier = textureBoitier;
    this.textureLentille = textureLentille;
    this.largeur = 150;
    this.hauteur = 60;
    this.profondeur = 80;
  }

  // Créer le projecteur
  void creerProjecteur() {
    boitier = createShape();
    boitier.beginShape(QUADS);
    boitier.texture(textureBoitier);
    boitier.noStroke();
    
    // Face avant
    boitier.vertex(-largeur / 2, -hauteur / 2, profondeur / 2, 0, 0);
    boitier.vertex(largeur / 2, -hauteur / 2, profondeur / 2, textureBoitier.width, 0);
    boitier.vertex(largeur / 2, hauteur / 2, profondeur / 2, textureBoitier.width, textureBoitier.height);
    boitier.vertex(-largeur / 2, hauteur / 2, profondeur / 2, 0, textureBoitier.height);

    // Face arrière
    boitier.vertex(-largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
    boitier.vertex(largeur / 2, -hauteur / 2, -profondeur / 2, textureBoitier.width, 0);
    boitier.vertex(largeur / 2, hauteur / 2, -profondeur / 2, textureBoitier.width, textureBoitier.height);
    boitier.vertex(-largeur / 2, hauteur / 2, -profondeur / 2, 0, textureBoitier.height);

    // Côtés
    boitier.vertex(-largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
    boitier.vertex(-largeur / 2, -hauteur / 2, profondeur / 2, textureBoitier.width, 0);
    boitier.vertex(-largeur / 2, hauteur / 2, profondeur / 2, textureBoitier.width, textureBoitier.height);
    boitier.vertex(-largeur / 2, hauteur / 2, -profondeur / 2, 0, textureBoitier.height);

    boitier.vertex(largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
    boitier.vertex(largeur / 2, -hauteur / 2, profondeur / 2, textureBoitier.width, 0);
    boitier.vertex(largeur / 2, hauteur / 2, profondeur / 2, textureBoitier.width, textureBoitier.height);
    boitier.vertex(largeur / 2, hauteur / 2, -profondeur / 2, 0, textureBoitier.height);
    
    boitier.endShape(CLOSE);

    // Créer la lentille du projecteur
    lentille = createShape();
    lentille.beginShape(QUADS);
    lentille.texture(textureLentille);
    lentille.noStroke();

    // Lentille circulaire (avant du projecteur)
    float rayonLentille = 30;
    lentille.vertex(-rayonLentille, -rayonLentille, profondeur / 2, 0, 0);
    lentille.vertex(rayonLentille, -rayonLentille, profondeur / 2, textureLentille.width, 0);
    lentille.vertex(rayonLentille, rayonLentille, profondeur / 2, textureLentille.width, textureLentille.height);
    lentille.vertex(-rayonLentille, rayonLentille, profondeur / 2, 0, textureLentille.height);

    lentille.endShape(CLOSE);

    // Créer la fixation (supports) du projecteur
    fixation = createShape();
    fixation.beginShape(QUADS);
    fixation.fill(0);
    fixation.noStroke();
  
    float fixationHeight = 80; // Nouvelle hauteur de la fixation

    // Support supérieur
    fixation.vertex(-largeur / 4, -hauteur / 2 - 10, -profondeur / 2, 0, 0);
    fixation.vertex(largeur / 4, -hauteur / 2 - 10, -profondeur / 2, 10, 0);
    fixation.vertex(largeur / 4, -hauteur / 2 - 10, profondeur / 2, 10, 10);
    fixation.vertex(-largeur / 4, -hauteur / 2 - 10, profondeur / 2, 0, 10);

    // Partie verticale de la fixation (augmente la hauteur ici)
    fixation.vertex(-largeur / 4, -hauteur / 2 - 10, -profondeur / 2, 0, 0);
    fixation.vertex(largeur / 4, -hauteur / 2 - 10, -profondeur / 2, 10, 0);
    fixation.vertex(largeur / 4, -hauteur / 2 - fixationHeight, -profondeur / 2, 10, 10);
    fixation.vertex(-largeur / 4, -hauteur / 2 - fixationHeight, -profondeur / 2, 0, 10);

    fixation.endShape(CLOSE);

    // Grouper les parties du projecteur
    shape = createShape(GROUP);
    shape.addChild(boitier);
    shape.addChild(lentille);
    shape.addChild(fixation);
  }

  void dessiner() {
    shape(shape);
  }

  void positionnerProjecteur() {
    // Positionner le projecteur sous le plafond, de manière fixe
    translate(x, y, z);
    rotateX(HALF_PI);
  }
}

