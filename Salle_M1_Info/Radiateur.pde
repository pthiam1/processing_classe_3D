class Radiateur extends QShape {
    private float largeur;
    private float hauteur;
    private float profondeur;
    private PImage texture;

    Radiateur(float x, float y, float z) {
        super(x, y, z);
    }

    void creerRadiateur(float largeur, float hauteur, float profondeur, PImage texture) {
        this.largeur = largeur;
        this.hauteur = hauteur;
        this.profondeur = profondeur;
        this.texture = texture;

        shape = createShape();
        shape.beginShape(QUADS);
        shape.texture(texture);
        shape.noStroke();

        // Face avant
        shape.vertex(-largeur / 2, -hauteur / 2, profondeur / 2, 0, 0);
        shape.vertex(largeur / 2, -hauteur / 2, profondeur / 2, texture.width, 0);
        shape.vertex(largeur / 2, hauteur / 2, profondeur / 2, texture.width, texture.height);
        shape.vertex(-largeur / 2, hauteur / 2, profondeur / 2, 0, texture.height);

        // Face arrière
        shape.vertex(-largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
        shape.vertex(largeur / 2, -hauteur / 2, -profondeur / 2, texture.width, 0);
        shape.vertex(largeur / 2, hauteur / 2, -profondeur / 2, texture.width, texture.height);
        shape.vertex(-largeur / 2, hauteur / 2, -profondeur / 2, 0, texture.height);

        // Côtés
        shape.vertex(-largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
        shape.vertex(-largeur / 2, -hauteur / 2, profondeur / 2, texture.width, 0);
        shape.vertex(-largeur / 2, hauteur / 2, profondeur / 2, texture.width, texture.height);
        shape.vertex(-largeur / 2, hauteur / 2, -profondeur / 2, 0, texture.height);

        shape.vertex(largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
        shape.vertex(largeur / 2, -hauteur / 2, profondeur / 2, texture.width, 0);
        shape.vertex(largeur / 2, hauteur / 2, profondeur / 2, texture.width, texture.height);
        shape.vertex(largeur / 2, hauteur / 2, -profondeur / 2, 0, texture.height);

        // Haut
        shape.vertex(-largeur / 2, hauteur / 2, -profondeur / 2, 0, 0);
        shape.vertex(largeur / 2, hauteur / 2, -profondeur / 2, texture.width, 0);
        shape.vertex(largeur / 2, hauteur / 2, profondeur / 2, texture.width, texture.height);
        shape.vertex(-largeur / 2, hauteur / 2, profondeur / 2, 0, texture.height);

        // Bas
        shape.vertex(-largeur / 2, -hauteur / 2, -profondeur / 2, 0, 0);
        shape.vertex(largeur / 2, -hauteur / 2, -profondeur / 2, texture.width, 0);
        shape.vertex(largeur / 2, -hauteur / 2, profondeur / 2, texture.width, texture.height);
        shape.vertex(-largeur / 2, -hauteur / 2, profondeur / 2, 0, texture.height);

        shape.endShape();

        // Ajouter les poignées

        // Poignée en bas à gauche (en bleu)
        poignee(-largeur / 2, -hauteur / 2, profondeur / 2);

        // Poignée en bas à droite (en vert)
        poignee(largeur / 2, -hauteur / 2, profondeur / 2);
    


    }

    //ajout poignée en haut à droite (en rouge)
    void poignee(float x, float y, float z){
        PShape poignee = createShape();
        poignee.beginShape(QUADS);
        poignee.noStroke();
        poignee.fill(255, 0, 0);
        poignee.vertex(x, y, z, 0, 0);
        poignee.vertex(x, y, z+10, 0, 0);
        poignee.vertex(x, y+10, z+10, 0, 0);
        poignee.vertex(x, y+10, z, 0, 0);
        poignee.endShape();
        shape.addChild(poignee);
    }

    void positionnerRadiateur(float x, float y, float z) {
        shape.resetMatrix(); 
        shape.translate(x, y, z);
        shape.rotateY(HALF_PI); // Pivote de 90° pour correspondre au mur gauche
    }

    void dessine() {
        shape(shape);
    }
}
