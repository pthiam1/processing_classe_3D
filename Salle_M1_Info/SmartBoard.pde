class SmartBoard extends QShape {
  final float LARGEUR_TABLEAU = 500;  // Largeur du SmartBoard
  final float HAUTEUR_TABLEAU = 300; // Hauteur du SmartBoard
  final float EPAISSEUR_TABLEAU = 5; // Épaisseur du SmartBoard
  final float HAUTEUR_SUPPORT = 200; // Hauteur du support central
  final float DIAMETRE_ROULETTE = 20; // Diamètre des roulettes
  final float LARGEUR_BARRE = 50; // Largeur des barres
  final float LARGEUR_PIED = 60; // Largeur du pied central
  final float EPAISSEUR_BARRE = 10; // Épaisseur des barres
  final float HAUTEUR_BARRE_INCLINEE = 50; // Hauteur verticale des barres inclinées
  
  PShape tableau;

  SmartBoard(float x, float y, float z) {
    super(x, y, z);
  }

  void creerSmartBoard(PImage textureEcran, color couleurCadre, color couleurRoulette) {
    shape = createShape(GROUP);

    // Créer le tableau principal
    tableau = createShape(BOX, LARGEUR_TABLEAU, HAUTEUR_TABLEAU, EPAISSEUR_TABLEAU);
    tableau.setFill(color(255)); // Couleur blanche pour l'écran
    tableau.setTexture(textureEcran);
    tableau.setStroke(false);
    shape.addChild(tableau);

    // Ajouter le cadre noir (inchangé)
    PShape cadre = createShape(GROUP);
    // Code du cadre ici
    shape.addChild(cadre);

    // Créer le pied central (Cube)
    PShape piedCentral = createShape(BOX, LARGEUR_PIED, HAUTEUR_SUPPORT, LARGEUR_PIED);
    piedCentral.setFill(couleurCadre);
    piedCentral.translate(0, HAUTEUR_TABLEAU / 2 + HAUTEUR_SUPPORT / 2, 0);
    shape.addChild(piedCentral);

    // Créer les barres inclinées
    float yBas = HAUTEUR_TABLEAU / 2 + HAUTEUR_SUPPORT; // Position verticale en bas
    float xGauche = -LARGEUR_BARRE / 2 - LARGEUR_BARRE / 2; // Position à gauche
    float xDroite = LARGEUR_BARRE / 2 + LARGEUR_BARRE / 2; // Position à droite

    PShape barreInclinéeGauche = createShape(BOX, LARGEUR_BARRE, EPAISSEUR_BARRE, EPAISSEUR_BARRE);
    barreInclinéeGauche.rotateX(-QUARTER_PI); // Inclinaison vers l'extérieur
    barreInclinéeGauche.translate(xGauche, yBas, 0);
    barreInclinéeGauche.setFill(couleurCadre);
    shape.addChild(barreInclinéeGauche);

    PShape barreInclinéeDroite = createShape(BOX, LARGEUR_BARRE, EPAISSEUR_BARRE, EPAISSEUR_BARRE);
    barreInclinéeDroite.rotateX(-QUARTER_PI);
    barreInclinéeDroite.translate(xDroite, yBas, 0);
    barreInclinéeDroite.setFill(couleurCadre);
    shape.addChild(barreInclinéeDroite);

    // Barre horizontale reliant le pied central et les barres inclinées
    PShape barreHorizontale = createShape(BOX, LARGEUR_BARRE, EPAISSEUR_BARRE, EPAISSEUR_BARRE);
    barreHorizontale.translate(0, yBas, 0); // Au bas
    barreHorizontale.setFill(couleurCadre);
    shape.addChild(barreHorizontale);

    // Ajouter les roulettes (4 roulettes en bas des barres inclinées)
    PShape rouletteGauche1 = createShape(SPHERE, DIAMETRE_ROULETTE / 2);
    rouletteGauche1.translate(xGauche - LARGEUR_BARRE / 4, yBas + DIAMETRE_ROULETTE / 2, 0);
    rouletteGauche1.setFill(couleurRoulette);
    shape.addChild(rouletteGauche1);

    PShape rouletteDroite1 = createShape(SPHERE, DIAMETRE_ROULETTE / 2);
    rouletteDroite1.translate(xDroite + LARGEUR_BARRE / 4, yBas + DIAMETRE_ROULETTE / 2, 0);
    rouletteDroite1.setFill(couleurRoulette);
    shape.addChild(rouletteDroite1);
  }

  void dessine() {
    shape(shape);
  }
}
