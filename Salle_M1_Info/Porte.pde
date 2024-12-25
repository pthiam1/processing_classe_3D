class Porte extends QShape {
    final float LARGEUR_PORTE = 350;
    final float HAUTEUR_PORTE = 650;
    final float EPAISSEUR_PORTE = 10;

    boolean estOuverte = false; // État initial de la porte
    float angleActuel = 0; // Angle de rotation actuel
    final float angleOuverture = HALF_PI; // Angle d'ouverture
    final float angleFermeture = 0; // Angle de fermeture
    final float vitesseRotation = 0.05; // Vitesse de rotation

    PShape panneauPorte; 
    PShape cadre; 

    Porte(float x, float y, float z) {
        super(x, y, z);
    }

    void creerPorte(PImage texturePorte, color couleurCadre, color couleurClanche, boolean isLaterale) {
        shape = createShape(GROUP); // Conteneur principal

        // Créer le cadre fixe de la porte
        cadre = createShape(GROUP);

        // Cadre droit
        PShape cadreDroit = createShape(BOX, 5, HAUTEUR_PORTE + 10, 5);
        cadreDroit.translate((LARGEUR_PORTE / 2) + 2.5f, 0, 0);
        cadreDroit.setFill(couleurCadre);
        cadre.addChild(cadreDroit);

        // Cadre gauche
        PShape cadreGauche = createShape(BOX, 5, HAUTEUR_PORTE + 10, 5);
        cadreGauche.translate(-(LARGEUR_PORTE / 2) - 2.5f, 0, 0);
        cadreGauche.setFill(couleurCadre);
        cadre.addChild(cadreGauche);

        // Cadre haut
        PShape cadreHaut = createShape(BOX, LARGEUR_PORTE + 10, 5, 5);
        cadreHaut.translate(0, -(HAUTEUR_PORTE / 2) - 2.5f, 0);
        cadreHaut.setFill(couleurCadre);
        cadre.addChild(cadreHaut);

        // Ajouter le cadre fixe au conteneur principal
        shape.addChild(cadre);

        // Créer le panneau de la porte 
        panneauPorte = createShape(BOX, LARGEUR_PORTE, HAUTEUR_PORTE, EPAISSEUR_PORTE);
        panneauPorte.setTexture(texturePorte);
        panneauPorte.setFill(color(255)); // Si la texture ne charge pas
        panneauPorte.setStroke(false);

        // Ajuster pour le pivot si c'est une porte latérale
        if (isLaterale) {
            panneauPorte.translate(0, 0, -EPAISSEUR_PORTE / 2);
            cadre.translate(0, 0, -EPAISSEUR_PORTE / 2);
            cadre.rotateY(HALF_PI);
            panneauPorte.rotateY(HALF_PI);
        }
        
        // Ajouter le panneau de la porte au conteneur principal
        shape.addChild(panneauPorte);
    }

    void ouvrirFermerPorte() {
      new Thread(() -> {
        float angleCible = estOuverte ? angleFermeture : angleOuverture;
     
        while (angleActuel != angleCible) {
          if (estOuverte) {
            angleActuel = max(angleActuel - vitesseRotation, angleCible);
            appliquerCouleurMur(true);
          } else {
            angleActuel = min(angleActuel + vitesseRotation, angleCible);
            appliquerCouleurMur(false);
          }
          panneauPorte.rotateY(angleActuel - angleCible);
          delay(10);
        }
        estOuverte = !estOuverte;
      }).start();
      
    }

    
    void appliquerCouleurMur(boolean appliquer) {
        if (appliquer) {
            cadre.setFill(color(255, 0, 0));
        } else {
            cadre.setFill(color(255));
        } 
    }

    void dessine() {
        shape(shape);
    }
}
