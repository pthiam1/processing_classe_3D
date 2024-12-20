class Fenetre extends QShape {
    private float largeur;
    private float hauteur;
    private float profondeur;
    private PImage texture;

    Fenetre(float x, float y, float z) {
        super(x, y, z);
    }

    void creerFenetre(float largeur, float hauteur, float profondeur, PImage texture) {
        this.largeur = largeur;
        this.hauteur = hauteur;
        this.profondeur = profondeur;
        this.texture = texture;

        shape = createShape();
        shape.beginShape(QUADS);
        shape.texture(texture);
        shape.noStroke();

        // Définir les sommets de la fenêtre (par défaut au centre)
        shape.vertex(-largeur / 2, -hauteur / 2, 0, 0, 0);
        shape.vertex(largeur / 2, -hauteur / 2, 0, texture.width, 0);
        shape.vertex(largeur / 2, hauteur / 2, 0, texture.width, texture.height);
        shape.vertex(-largeur / 2, hauteur / 2, 0, 0, texture.height);

        shape.endShape();
    }

    void positionnerFenetre(float x, float y, float z) {
        shape.resetMatrix(); 
        shape.translate(x, y, z); 
        shape.rotateY(HALF_PI); 
    }

 
    void dessine() {
        shape(shape);
    }
}
