class ToileProjecteur extends QShape {
  private float x, y, z; // Coordonnées de la position
  private float largeur;
  private float hauteur;
  private float profondeur;
  private float hauteurActuelle;
  private boolean estDeroulee;
  private PShape toile;
  private PShape barreHaut;
  private PShape barreBas;
  private PImage texture;

  ToileProjecteur(float x, float y, float z) {
    super(x, y, z); 
    this.x = x;
    this.y = y;
    this.z = z;
    this.hauteurActuelle = 0; // Initialement fermée
    this.estDeroulee = false; // La toile est fermée au début
  }

  void creerToile(float largeur, float hauteur, float profondeur, PImage texture) {
    this.largeur = largeur;
    this.hauteur = hauteur;
    this.profondeur = profondeur;
    this.texture = texture;

    // Créer les différentes parties
    creerBarreHaut();
    creerBarreBas();
    creerToile();

    // Créer le groupe de formes
    shape = createShape(GROUP);
    shape.addChild(barreHaut);
    shape.addChild(toile);
    shape.addChild(barreBas);
  }

  private void creerBarreHaut() {
    barreHaut = createShape();
    barreHaut.beginShape(QUADS);
    barreHaut.fill(50, 50, 120);
    barreHaut.noStroke();

    float epaisseurHaut = 30; // La barre du haut est plus épaisse
    float largeurHaut = largeur * 1.1f; // La barre du haut est un peu plus large

    // Barre en haut (horizontal)
    barreHaut.vertex(-largeurHaut / 2, -hauteur / 2, -profondeur / 2);
    barreHaut.vertex(largeurHaut / 2, -hauteur / 2, -profondeur / 2);
    barreHaut.vertex(largeurHaut / 2, -hauteur / 2 + epaisseurHaut, -profondeur / 2);
    barreHaut.vertex(-largeurHaut / 2, -hauteur / 2 + epaisseurHaut, -profondeur / 2);

    barreHaut.vertex(-largeurHaut / 2, -hauteur / 2, profondeur / 2);
    barreHaut.vertex(largeurHaut / 2, -hauteur / 2, profondeur / 2);
    barreHaut.vertex(largeurHaut / 2, -hauteur / 2 + epaisseurHaut, profondeur / 2);
    barreHaut.vertex(-largeurHaut / 2, -hauteur / 2 + epaisseurHaut, profondeur / 2);

    barreHaut.endShape(CLOSE);
  }

  private void creerBarreBas() {
    barreBas = createShape();
    barreBas.beginShape(QUADS);
    barreBas.fill(50, 50, 120);
    barreBas.noStroke();

    float epaisseurBas = 10; // La barre du bas est plus fine
    // Barre en bas
    barreBas.vertex(-largeur / 2, hauteur / 2, -profondeur / 2);
    barreBas.vertex(largeur / 2, hauteur / 2, -profondeur / 2);
    barreBas.vertex(largeur / 2, hauteur / 2 + epaisseurBas, -profondeur / 2);
    barreBas.vertex(-largeur / 2, hauteur / 2 + epaisseurBas, -profondeur / 2);

    barreBas.vertex(-largeur / 2, hauteur / 2, profondeur / 2);
    barreBas.vertex(largeur / 2, hauteur / 2, profondeur / 2);
    barreBas.vertex(largeur / 2, hauteur / 2 + epaisseurBas, profondeur / 2);
    barreBas.vertex(-largeur / 2, hauteur / 2 + epaisseurBas, profondeur / 2);

    barreBas.endShape(CLOSE);
  }

  private void creerToile() {
    toile = createShape();
    toile.beginShape(QUADS);
    toile.texture(texture);
    toile.noStroke();

    // Définir la toile
    toile.vertex(-largeur / 2, -hauteur / 2 + hauteurActuelle, -profondeur / 2);
    toile.vertex(largeur / 2, -hauteur / 2 + hauteurActuelle, -profondeur / 2);
    toile.vertex(largeur / 2, -hauteur / 2 + hauteur, profondeur / 2);
    toile.vertex(-largeur / 2, -hauteur / 2 + hauteur, profondeur / 2);
    toile.endShape(CLOSE);
  }

//allumer projecteur (crer un rectangle meme dimension que la toile avec une marge de 10)
  void allumerEteindreProjecteur(){
    print("Allumer/Eteindre projecteur\n");
    estDeroulee = !estDeroulee;

    if (estDeroulee) {
        float marge = 50;  

        float largeurProjecteur = largeur - 2 * marge;
        float hauteurProjecteur = hauteur - 2 * marge;

        // Créer le projecteur
        PShape projecteur = createShape(BOX, largeurProjecteur, hauteurProjecteur, 10);
        projecteur.setTexture(texture);
        projecteur.noStroke();
        shape.addChild(projecteur);    
            
    } else {
        shape.removeChild(shape.getChildCount() - 1);
    }
  }

  void dessiner() {
    shape(shape);
  }
  
}
