class BureauEtudiant extends QShape {
    private float largeur;
    private float profondeur;
    private float hauteur;
    private float epaisseurPlateau;
    private PShape plateau;
    private PShape structure;
    private PShape coffre;
    private PShape ecran;
    private PImage texturePlateau; // Texture pour le plateau en mélaminé
    private int couleurStructure; // Couleur de la structure en acier

    BureauEtudiant(float x, float y, float z, float largeur, float profondeur, float hauteur, 
                           PImage texturePlateau, int couleurStructure) {
        super(x, y, z);
        this.largeur = largeur;
        this.profondeur = profondeur;
        this.hauteur = hauteur;
        this.epaisseurPlateau = 25; // Plateau épaisseur 25 mm
        this.texturePlateau = texturePlateau;
        this.couleurStructure = couleurStructure;

        creerBureau();
    }

    private void creerBureau() {
        // Créer le groupe global
        shape = createShape(GROUP);

        // Créer les différentes parties du bureau
        creerPlateau();
        creerStructure();
        creerCoffre();

        // Ajouter les éléments au groupe
        shape.addChild(plateau);
        shape.addChild(structure);
        shape.addChild(coffre);
    }

    private void creerPlateau() {
        plateau = createShape();
        plateau.beginShape(QUADS);
        plateau.texture(texturePlateau);
        plateau.noStroke();

        // Plateau principal
        plateau.vertex(-largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
        plateau.vertex(largeur / 2, -hauteur / 2, -profondeur / 2, texturePlateau.width, 0);
        plateau.vertex(largeur / 2, -hauteur / 2, profondeur / 2, texturePlateau.width, texturePlateau.height);
        plateau.vertex(-largeur / 2, -hauteur / 2, profondeur / 2, 0, texturePlateau.height);

        // Chant plaqué épaisseur 2mm
        float chantEpaisseur = 2;
        plateau.fill(150); // Couleur gris clair pour le chant
        plateau.vertex(-largeur / 2, -hauteur / 2, profondeur / 2);
        plateau.vertex(largeur / 2, -hauteur / 2, profondeur / 2);
        plateau.vertex(largeur / 2, -hauteur / 2 + chantEpaisseur, profondeur / 2);
        plateau.vertex(-largeur / 2, -hauteur / 2 + chantEpaisseur, profondeur / 2);

        plateau.endShape(CLOSE);
    }

    private void creerStructure() {
        structure = createShape();
        structure.beginShape(QUADS);
        structure.fill(couleurStructure); // Couleur de la structure (peinture époxy)
        structure.noStroke();

        float epaisseurTube = 5; // Épaisseur du piètement
        float hauteurStructure = hauteur;

        // Pied gauche
        structure.vertex(-largeur / 2 + epaisseurTube, -hauteur / 2, -profondeur / 2);
        structure.vertex(-largeur / 2, -hauteur / 2, -profondeur / 2);
        structure.vertex(-largeur / 2, hauteurStructure / 2, -profondeur / 2);
        structure.vertex(-largeur / 2 + epaisseurTube, hauteurStructure / 2, -profondeur / 2);

        structure.vertex(-largeur / 2 + epaisseurTube, -hauteur / 2, profondeur / 2);
        structure.vertex(-largeur / 2, -hauteur / 2, profondeur / 2);
        structure.vertex(-largeur / 2, hauteurStructure / 2, profondeur / 2);
        structure.vertex(-largeur / 2 + epaisseurTube, hauteurStructure / 2, profondeur / 2);

        // Pied droit
        structure.vertex(largeur / 2 - epaisseurTube, -hauteur / 2, -profondeur / 2);
        structure.vertex(largeur / 2, -hauteur / 2, -profondeur / 2);
        structure.vertex(largeur / 2, hauteurStructure / 2, -profondeur / 2);
        structure.vertex(largeur / 2 - epaisseurTube, hauteurStructure / 2, -profondeur / 2);

        structure.vertex(largeur / 2 - epaisseurTube, -hauteur / 2, profondeur / 2);
        structure.vertex(largeur / 2, -hauteur / 2, profondeur / 2);
        structure.vertex(largeur / 2, hauteurStructure / 2, profondeur / 2);
        structure.vertex(largeur / 2 - epaisseurTube, hauteurStructure / 2, profondeur / 2);

        structure.endShape(CLOSE);
    }

    private void creerCoffre() {
        coffre = createShape();
        coffre.beginShape(QUADS);
        coffre.fill(100); // Couleur gris foncé pour le coffre
        coffre.noStroke();

        float hauteurCoffre = 10; // Hauteur du coffre en tôle
        float profondeurCoffre = profondeur * 0.9f;

        // Coffre rectangulaire pour sécuriser les écrans
        coffre.vertex(-largeur / 2, -hauteur / 2 + hauteurCoffre, -profondeurCoffre / 2);
        coffre.vertex(largeur / 2, -hauteur / 2 + hauteurCoffre, -profondeurCoffre / 2);
        coffre.vertex(largeur / 2, -hauteur / 2 + hauteurCoffre, profondeurCoffre / 2);
        coffre.vertex(-largeur / 2, -hauteur / 2 + hauteurCoffre, profondeurCoffre / 2);

        coffre.vertex(-largeur / 2, -hauteur / 2, -profondeurCoffre / 2);
        coffre.vertex(largeur / 2, -hauteur / 2, -profondeurCoffre / 2);
        coffre.vertex(largeur / 2, -hauteur / 2, profondeurCoffre / 2);
        coffre.vertex(-largeur / 2, -hauteur / 2, profondeurCoffre / 2);

        coffre.endShape(CLOSE);
    }

    // Fonction pour activer la levée ou l'inclinaison de l'écran
    void leverEcran(float hauteurEcran) {
        // Logique pour lever l'écran jusqu'à une inclinaison de 18°
    }
}
