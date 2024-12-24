class BureauEtudiant extends QShape {
    private float largeur;
    private float profondeur;
    private float hauteur;
    private float epaisseurPlateau = 15; // Épaisseur par défaut en mm
    private PShape bureau; // Regroupe tout le bureau
    private PShape chaise; // Chaise associée
    private color chaiseCadre; // Couleur du cadre de la chaise
    private PImage textureBureau; // Texture pour le plateau
    private PImage textureEcran; // Texture pour l'écran
    private PImage textureChaise; // Texture pour la chaise
    private PImage textureSouris; // Texture pour la souris
    private PImage textureClavier; // Texture pour le clavier
    private PImage textureUC; // Texture pour l'unité centrale

    BureauEtudiant(float x, float y, float z) {
        super(x, y, z);
    }

    void creerBureauEtudiant(float largeur, float profondeur, float hauteur, PImage textureBureau, PImage textureEcran, PImage textureChaise, PImage textureSouris, PImage textureClavier, PImage textureUC, color chaiseCadre) {
        this.largeur = largeur;
        this.profondeur = profondeur;
        this.hauteur = hauteur;
        this.textureBureau = textureBureau;
        this.textureEcran = textureEcran;
        this.textureChaise = textureChaise;
        this.textureSouris = textureSouris;
        this.textureClavier = textureClavier;
        this.textureUC = textureUC;
        this.chaiseCadre = chaiseCadre;

        bureau = createShape(GROUP);

        // Créer le plateau du bureau
        PShape plateau = createShape(BOX, largeur, epaisseurPlateau, profondeur);
        plateau.setTexture(textureBureau);
        plateau.setFill(color(255));
        plateau.setStroke(false);
        plateau.translate(0, -epaisseurPlateau / 2, 0);
        bureau.addChild(plateau);

        // Ajouter les pieds du bureau
        float piedLargeur = 20; // Largeur des pieds en mm
        float piedProfondeur = 20; // Profondeur des pieds en mm
        float piedHauteur = hauteur - epaisseurPlateau - 50; // Hauteur des pieds en mm
        float piedOffsetX = largeur / 2 - piedLargeur / 2; // Décalage en X
        float piedOffsetZ = profondeur / 2 - piedProfondeur / 2; // Décalage en Z

        for (int i = -1; i <= 1; i += 2) {
             for (int j = -1; j <= 1; j += 2) {
                // Créer le pied noir
                PShape pied = createShape(BOX, piedLargeur, piedHauteur, piedProfondeur);
                pied.setFill(color(0)); // Couleur noire pour les pieds visibles
                pied.setStroke(false);
                pied.translate(i * piedOffsetX, piedHauteur / 2, j * piedOffsetZ);
                bureau.addChild(pied);

                PShape enveloppe = createShape(BOX, largeur, hauteur - 80, profondeur - 150);
                enveloppe.setFill(color(255, 255, 255, 150));
                enveloppe.setStroke(false);
                enveloppe.translate(0, hauteur / 2 - 50, 0);
                bureau.addChild(enveloppe);

            }
        }

        // Ajouter un tiroir pour l'unité centrale à l'avant
        float tiroirLargeur = 200; // Largeur du tiroir en mm
        float tiroirHauteur = 250; // Hauteur du tiroir en mm
        float tiroirProfondeur = 150; // Profondeur du tiroir en mm

        PShape tiroir = createShape(BOX, tiroirLargeur, tiroirHauteur, tiroirProfondeur);
        tiroir.setFill(color(0, 0, 0,150));
        tiroir.setStroke(false);
        tiroir.translate(tiroirLargeur / 2, tiroirHauteur / 2, profondeur / 2 - tiroirProfondeur / 2);
        bureau.addChild(tiroir);

        // Ajouter l'unité centrale dans le tiroir
        float ucLargeur = 40; // Largeur de l'unité centrale
        float ucHauteur = 100; // Hauteur de l'unité centrale
        float ucProfondeur = 80; // Profondeur de l'unité centrale
        PShape uniteCentrale = createShape(BOX, ucLargeur, ucHauteur, ucProfondeur);
        uniteCentrale.setTexture(textureUC);
        uniteCentrale.setStroke(false); 
        uniteCentrale.translate(ucHauteur , -tiroirHauteur / 2 + ucHauteur *2 , tiroirProfondeur + 20);
        bureau.addChild(uniteCentrale);

        float coffreLargeur = largeur / 2;
        float coffreHauteur = 10;
        float coffreProfondeur = profondeur / 3;
        PShape coffre = createShape(BOX, coffreLargeur, coffreHauteur, coffreProfondeur);

        // Ajouter une poignée au coffre
        PShape poignee = createShape(SPHERE, 10);
        poignee.setFill(color(0));
        poignee.setStroke(false);
        poignee.translate(0, 100, coffreProfondeur / 2 + 5);
        bureau.addChild(poignee);

        //ajouter clavier
        float clavierLargeur = 200;
        float clavierHauteur = 15;
        float clavierProfondeur = 50;
        PShape clavier = createShape(BOX, clavierLargeur, clavierHauteur, clavierProfondeur);
        clavier.setTexture(textureClavier);
        clavier.setFill(color(255));
        clavier.setStroke(false);
        clavier.translate(0, -epaisseurPlateau / 2 - clavierHauteur, profondeur / 2 - clavierProfondeur / 2);
        bureau.addChild(clavier);
       
        //ajouter souris
        float sourisLargeur = 50;
        float sourisHauteur = 10;
        float sourisProfondeur = 50;
        PShape souris = createShape(BOX, sourisLargeur, sourisHauteur, sourisProfondeur);
        souris.setTexture(textureSouris);
        souris.setFill(color(255));
        souris.setStroke(false);
        //souris a gauche du clavier
        souris.translate(-clavierLargeur / 2 - sourisLargeur, -epaisseurPlateau / 2 - sourisHauteur, profondeur / 2 - sourisProfondeur / 2);
        bureau.addChild(souris);

        //ajouter ecran
        float ecranLargeur = 220;
        float ecranHauteur = 130;
        float ecranProfondeur = 10;
        PShape ecran = createShape(BOX, ecranLargeur, ecranHauteur, ecranProfondeur);
        ecran.setTexture(textureEcran);
        ecran.setFill(color(255));
        ecran.setStroke(false);
        ecran.translate(0, -epaisseurPlateau / 2 - ecranHauteur / 2, profondeur / 2 - ecranProfondeur / 2 - clavierProfondeur - sourisProfondeur - 50);
        bureau.addChild(ecran);


        coffre.setFill(color(255));
        coffre.setTexture(textureBureau);
        coffre.setStroke(false);
        coffre.translate(0, -hauteur / 2, profondeur / 2 - coffreProfondeur - 50);
        bureau.addChild(coffre);
    

        // Créer la chaise
        creerChaise(textureChaise, chaiseCadre);

        shape = bureau;
        


    }

    void creerChaise(PImage textureChaise, color cadreCouleur) {
    // Dimensions de la chaise ajustées
    float largeurChaise = largeur / 3; // Largeur totale de la chaise proportionnelle au bureau
    float profondeurChaise = profondeur / 3; // Profondeur totale de la chaise
    float hauteurAssise = 20; // Épaisseur de l'assise
    float hauteurChaise = hauteur / 2; // Hauteur totale de la chaise
    float hauteurDossier = hauteurChaise - hauteurAssise; // Hauteur du dossier
    float epaisseurCadre = 10; // Épaisseur des pieds et du cadre

    // Créer un groupe pour la chaise
    chaise = createShape(GROUP);

    // Assise de la chaise
    PShape assise = createShape(BOX, largeurChaise, hauteurAssise, profondeurChaise);
    assise.setTexture(textureChaise);
    assise.setStroke(false);
    assise.translate(0, -hauteurChaise + hauteurAssise / 2, 0); // Position de l'assise
    chaise.addChild(assise);

    //cadre Dossier + barre de support
    for (int i = -1; i <= 1; i += 2) {
        PShape cadreDossier = createShape(BOX, epaisseurCadre, hauteurDossier, epaisseurCadre);
        cadreDossier.setFill(cadreCouleur);
        cadreDossier.setStroke(false);
        cadreDossier.translate(i * (largeurChaise / 2 - epaisseurCadre / 2), -hauteurChaise - hauteurDossier / 2, profondeurChaise / 2 - epaisseurCadre / 2);
        chaise.addChild(cadreDossier);
    }

    //barre dossier support 1
    PShape supportDossier = createShape(BOX, largeurChaise - epaisseurCadre, epaisseurCadre, epaisseurCadre);
    supportDossier.setFill(cadreCouleur);
    supportDossier.setStroke(false);
    //a la hauteur du dossier
    supportDossier.translate(0, -hauteurChaise - hauteurDossier, profondeurChaise / 2 - epaisseurCadre / 2);
    chaise.addChild(supportDossier);


    //  barre de support
    for (int i = -1; i <= 1; i += 2) {
        PShape support = createShape(BOX, largeurChaise - epaisseurCadre, epaisseurCadre, epaisseurCadre);
        support.setFill(cadreCouleur);
        support.setStroke(false);
        support.translate(0, -hauteurChaise + hauteurDossier / 2, i * (profondeurChaise / 2 - epaisseurCadre / 2));
        chaise.addChild(support);
    }



    // Dossier de la chaise
    PShape dossier = createShape(BOX, largeurChaise, hauteurDossier/ 2, epaisseurCadre);
    dossier.setTexture(textureChaise);
    dossier.setStroke(false);
    dossier.translate(0, -hauteurChaise - hauteurDossier / 2, profondeurChaise / 2 - epaisseurCadre / 2);
    chaise.addChild(dossier);


    // Pieds avant (gauche et droit)
    for (int i = -1; i <= 1; i += 2) {
        PShape piedAvant = createShape(BOX, epaisseurCadre, hauteurChaise, epaisseurCadre);
        piedAvant.setFill(cadreCouleur);
        piedAvant.setStroke(false);
        piedAvant.translate(i * (largeurChaise / 2 - epaisseurCadre / 2), -hauteurChaise / 2, profondeurChaise / 2 - epaisseurCadre / 2);
        chaise.addChild(piedAvant);
    }

    // Pieds arrière (gauche et droit)
    for (int i = -1; i <= 1; i += 2) {
        PShape piedArriere = createShape(BOX, epaisseurCadre, hauteurChaise, epaisseurCadre);
        piedArriere.setFill(cadreCouleur);
        piedArriere.setStroke(false);
        piedArriere.translate(i * (largeurChaise / 2 - epaisseurCadre / 2), -hauteurChaise / 2, -profondeurChaise / 2 + epaisseurCadre / 2);
        chaise.addChild(piedArriere);
    }

    // Barres de support reliant les pieds avant-arrière
    for (int i = -1; i <= 1; i += 2) {
        PShape support = createShape(BOX, largeurChaise - epaisseurCadre, epaisseurCadre, epaisseurCadre);
        support.setFill(cadreCouleur);
        support.setStroke(false);
        support.translate(0, -hauteurChaise + epaisseurCadre / 2, i * (profondeurChaise / 2 - epaisseurCadre / 2));
        chaise.addChild(support);
    }

    // Barres latérales reliant les pieds gauche-droite
    for (int i = -1; i <= 1; i += 2) {
        PShape support = createShape(BOX, epaisseurCadre, epaisseurCadre, profondeurChaise - epaisseurCadre);
        support.setFill(cadreCouleur);
        support.setStroke(false);
        support.translate(i * (largeurChaise / 2 - epaisseurCadre / 2), -hauteurChaise + epaisseurCadre / 2, 0);
        chaise.addChild(support);
    }

    // Positionner la chaise devant le bureau au sol
    chaise.translate(-profondeur /2 , hauteurChaise * 1.5 , profondeur + profondeurChaise / 4);
    bureau.addChild(chaise);
}

    private float vitesseAnimation = 2; // Vitesse de déplacement
    private float positionCoffreActuelle = 0; // Position actuelle du coffre
    private float positionEcranActuelle = 0; // Position actuelle de l'écran
    private boolean enAnimation = false; // Vérifie si une animation est en cours

   void ouvrirFermerCoffre() {
    if (!enAnimation) {
        if (positionCoffreActuelle == 0) {
            ouvrirCoffre();
        } else {
            fermerCoffre();
        }
    }
}

void delay(int ms) {
    try {
        Thread.sleep(ms);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
}

   void ouvrirCoffre() {
    enAnimation = true;
    new Thread(() -> {
        while (positionCoffreActuelle < hauteur / 2) {
            positionCoffreActuelle += vitesseAnimation; // Déplacer vers le haut
            positionEcranActuelle += vitesseAnimation; // Déplacer l'écran aussi
            println(bureau.getChild(6));
            println(bureau.getChild(8));
            bureau.getChild(12).translate(0, vitesseAnimation, 0); // Déplacer le coffre
            bureau.getChild(13).translate(0, vitesseAnimation, 0); // Déplacer l'écran
            bureau.getChild(14).translate(0, vitesseAnimation, 0); // Déplacer le clavier
            bureau.getChild(15).translate(0, vitesseAnimation, 0); // Déplacer la souris
            delay(16); // Simuler une fréquence d'image de ~60 FPS
        }
        enAnimation = false; // Animation terminée
    }).start();
}


 void fermerCoffre() {
    enAnimation = true;
    new Thread(() -> {
        while (positionCoffreActuelle > 0) {
            positionCoffreActuelle -= vitesseAnimation; // Déplacer vers le bas
            positionEcranActuelle -= vitesseAnimation; // Déplacer l'écran aussi
            bureau.getChild(12).translate(0, -vitesseAnimation, 0); // Déplacer le coffre
            bureau.getChild(13).translate(0, -vitesseAnimation, 0); // Déplacer l'écran
            bureau.getChild(14).translate(0, -vitesseAnimation, 0); // Déplacer le clavier
            bureau.getChild(15).translate(0, -vitesseAnimation, 0); // Déplacer la souris
            delay(16); // Simuler une fréquence d'image de ~60 FPS
        }
        enAnimation = false; // Animation terminée
    }).start();
}



    
}
