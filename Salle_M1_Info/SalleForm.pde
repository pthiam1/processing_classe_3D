class SalleForme extends QShape {
  private float largeur;
  private float hauteur;
  private float profondeur;
  private PImage textureMur;
  private PImage textureSol;
  private PImage texturePlafond;
 
  SalleForme(float x, float y, float z) {
    super(x, y, z);
  }

  void creerSalle(float largeur, float hauteur, float profondeur, PImage textureMur, PImage textureSol, PImage texturePlafond) {
    this.largeur = largeur;
    this.hauteur = hauteur;
    this.profondeur = profondeur;
    this.textureMur = textureMur;
    this.textureSol = textureSol;
    this.texturePlafond = texturePlafond;
    
    shape = createShape(GROUP);
    
    // Mur gauche
    PShape murGauche = createShape();
    murGauche.beginShape(QUADS);
    murGauche.texture(textureMur);
    murGauche.noStroke();
    
    murGauche.vertex(-largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
    murGauche.vertex(-largeur / 2, -hauteur / 2, profondeur / 2, textureMur.width, 0);
    murGauche.vertex(-largeur / 2, hauteur / 2, profondeur / 2, textureMur.width, textureMur.height);
    murGauche.vertex(-largeur / 2, hauteur / 2, -profondeur / 2, 0, textureMur.height);
    
    murGauche.endShape();
    
    // Mur droit
    PShape murDroit = createShape();
    murDroit.beginShape(QUADS);
    murDroit.texture(textureMur);
    murDroit.noStroke();
    
    murDroit.vertex(largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
    murDroit.vertex(largeur / 2, -hauteur / 2, profondeur / 2, textureMur.width, 0);
    murDroit.vertex(largeur / 2, hauteur / 2, profondeur / 2, textureMur.width, textureMur.height);
    murDroit.vertex(largeur / 2, hauteur / 2, -profondeur / 2, 0, textureMur.height);
    
    murDroit.endShape();
    
    // Mur avant
    PShape murAvant = createShape();
    murAvant.beginShape(QUADS);
    murAvant.texture(textureMur);
    murAvant.noStroke();

    murAvant.vertex(-largeur / 2, -hauteur / 2, profondeur / 2, 0, 0);
    murAvant.vertex(largeur / 2, -hauteur / 2, profondeur / 2, textureMur.width, 0);
    murAvant.vertex(largeur / 2, hauteur / 2, profondeur / 2, textureMur.width, textureMur.height);
    murAvant.vertex(-largeur / 2, hauteur / 2, profondeur / 2, 0, textureMur.height);

    murAvant.endShape();

    // Mur arrière
    PShape murArriere = createShape();
    murArriere.beginShape(QUADS);
    murArriere.texture(textureMur);
    murArriere.noStroke();

    murArriere.vertex(-largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
    murArriere.vertex(largeur / 2, -hauteur / 2, -profondeur / 2, textureMur.width, 0);
    murArriere.vertex(largeur / 2, hauteur / 2, -profondeur / 2, textureMur.width, textureMur.height);
    murArriere.vertex(-largeur / 2, hauteur / 2, -profondeur / 2, 0, textureMur.height);

    murArriere.endShape();

    // Plafond
    Plafond plafond = new Plafond(0 , 0, 0);
    plafond.creerPlafond(largeur, profondeur, texturePlafond);
    PShape plafondShape = plafond.getShape();
  

    // Sol
    Sol sol = new Sol(0, 0, 0);
    sol.creerSol(largeur, profondeur, textureSol);
    PShape solShape = sol.getShape();

  

    // Ajouter les formes à la salle
    shape.addChild(murGauche);
    shape.addChild(murDroit);
    shape.addChild(murAvant);
    shape.addChild(murArriere);
    shape.addChild(plafondShape);
    shape.addChild(solShape);
  }

  void dessine() {
    shape(shape);
  }
}