class Porte extends QShape {
  final float LARGEUR_PORTE = 350;
  final float HAUTEUR_PORTE = 650;
  final float EPAISSEUR_PORTE = 10;
  

  Porte(float x, float y, float z) {
    super(x, y, z);
  }

  void creerPorte(PImage texturePorte, color couleurCadre, color couleurClanche, boolean isLaterale) {
    shape = createShape(GROUP);

    // Partie principale de la porte
    PShape panneauPorte = createShape(BOX, LARGEUR_PORTE, HAUTEUR_PORTE, EPAISSEUR_PORTE);
    panneauPorte.setTexture(texturePorte);
    panneauPorte.setFill(color(255)); // Si la texture ne charge pas
    panneauPorte.setStroke(false);

    // Ajustement pour le point de rotation
    if (isLaterale) {
        panneauPorte.translate(-LARGEUR_PORTE / 20, 0, 0); // Déplacer le panneau pour aligner le pivot au bord gauche
    }

    shape.addChild(panneauPorte);

    // Cadre droit
    PShape cadreDroit = createShape(BOX, 5, HAUTEUR_PORTE + 10, 5);
    cadreDroit.translate((LARGEUR_PORTE / 2) + 2.5f, 0, 0);
    cadreDroit.setFill(couleurCadre);
    shape.addChild(cadreDroit);

    // Cadre gauche
    PShape cadreGauche = createShape(BOX, 5, HAUTEUR_PORTE + 10, 5);
    cadreGauche.translate(-(LARGEUR_PORTE / 2) - 2.5f, 0, 0);
    cadreGauche.setFill(couleurCadre);
    shape.addChild(cadreGauche);

    // Cadre haut
    PShape cadreHaut = createShape(BOX, LARGEUR_PORTE + 10, 5, 5);
    cadreHaut.translate(0, -(HAUTEUR_PORTE / 2) - 2.5f, 0);
    cadreHaut.setFill(couleurCadre);
    shape.addChild(cadreHaut);

    // Clanche (poignée)
    PShape clanche = createShape(BOX, 10, 2, 20);
    if (isLaterale) {
        clanche.translate((LARGEUR_PORTE / 2) + 10, -50, -(EPAISSEUR_PORTE / 2) - 5);
    } else {
        clanche.translate((LARGEUR_PORTE / 2) - 10, -50, (EPAISSEUR_PORTE / 2) + 5);
    }
    clanche.setFill(couleurClanche);
    shape.addChild(clanche);

    // Si porte latérale, appliquer une rotation initiale
    if (isLaterale) {
        shape.rotateY(HALF_PI);
    }
}

  void dessine() {
    shape(shape);
  }


float rotationY = 0;

void ouvrir() {
    if (shape != null) {
        if (rotationY < HALF_PI) {
            shape.rotateY(QUARTER_PI);
            rotationY += QUARTER_PI;
        }
    }
}



}
