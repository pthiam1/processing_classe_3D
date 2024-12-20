/**
 * Ce programme Processing permet de simuler la salle M1 info de l'université du Havre  
 * Sol [maron], murs [blanc], porte [bleu], fenêtre [noir + vitre], tableau [vert], 
 * chaise [maron + cadre jaune], bureau [bois blanc], ordinateur [noir], plafond [blanc] 
 * avec des lampes [blanc], détecteur de fumée [rouge], smartScreen [noir], projecteur [blanc], 
 * haut-parleur [gris]. 
 * @auteur : THIAM Papa
 * @date : 2024
 * @version : 1.0
 */

// PShape sol, mur1, mur2, mur3, mur4, plafond, porte, fenetre, tableau, chaise, bureau, ordinateur, lampe, detecteur, bigSmartScreen, projecteur, hautParleur;

float camX = 0;
float camY = 0;
float camZ = 500;  // Position initiale de la caméra

float rayon = 500;
float theta = 0;
float phi = 0;

boolean isRotating = false;
Tableau tableau;
SalleForme salle;

float largeurSalle = 2200;
float hauteurSalle = 800;
float profondeurSalle = 3000;

ArrayList<QShape> formes = new ArrayList<QShape>();

PImage murTexture, plafondTexture, solTexture;



void setup() {
  // fullScreen(P3D);

  size(1000, 800, P3D);
  PShader colorShader = loadShader("resources/LightShaderTexFrag.glsl", "resources/LightShaderTexVert.glsl");

  // Charger les textures
  murTexture = loadImage("resources/white.jpg");
  plafondTexture = loadImage("resources/plafond.jpg");
  solTexture = loadImage("resources/sol.jpg");

  // Créer la salle
  salle = new SalleForme(0, 0, 0);
  salle.creerSalle(largeurSalle, hauteurSalle, profondeurSalle, murTexture, solTexture, plafondTexture);
  formes.add(salle);

  // Créer un tableau accroché au mur
  tableau = new Tableau(hauteurSalle / 2 - 250, 0, -profondeurSalle / 2 + 100);
  tableau.creerTableau(loadImage("resources/tableau.jpg"));
  formes.add(tableau);

 // Créer les portes
  PImage porteTexture = loadImage("resources/metal.jpg");

  // Porte arrière
  Porte porteAvant = new Porte(-800, -(hauteurSalle / 2 - 550), profondeurSalle / 2);
  porteAvant.creerPorte(porteTexture, color(0, 0, 255), color(255, 255, 0), false);
  formes.add(porteAvant);
  
  // Porte avant
  Porte porteArriere = new Porte(-800, -(hauteurSalle / 2 - 550), -profondeurSalle / 2);
  porteArriere.creerPorte(porteTexture, color(0, 0, 255), color(255, 255, 0) , false);
  formes.add(porteArriere);
 
//porte droite
  Porte porteDroite = new Porte(largeurSalle / 2 , -(hauteurSalle / 2 - 550), -profondeurSalle / 2 + 550);
  porteDroite.creerPorte(porteTexture, color(0, 0, 255), color(255, 255, 0), true);
  formes.add(porteDroite);


  // Ajouter un SmartBoard
  SmartBoard smartBoard = new SmartBoard(-largeurSalle / 2 + 320, hauteurSalle / 2 - 400, -profondeurSalle / 2 + 500);
  smartBoard.creerSmartBoard(loadImage("resources/smart-screen.png"), color(0), color(100));
  formes.add(smartBoard);
  
  
  

  // Fenêtre sur le mur gauche
  PImage fenetreTexture = loadImage("resources/fenetre.jpg");
  Fenetre fenetre = new Fenetre(-largeurSalle / 2 + 0.1f, hauteurSalle / 2 - 500, -1000); 
  fenetre.creerFenetre(2500, 500, 5, fenetreTexture);
  fenetre.positionnerFenetre(-largeurSalle / 2, hauteurSalle / 2 - 400, 0);
  formes.add(fenetre);
  
  PImage radiateurTexture = loadImage("resources/radiateur.png");

  // Créer deux radiateurs sur le mur gauche
  Radiateur radiateur1 = new Radiateur(-largeurSalle / 2 + 50, -hauteurSalle / 2 + 700, -profondeurSalle / 2 + 500);
  radiateur1.creerRadiateur(400, 200, 20, radiateurTexture);
  radiateur1.positionnerRadiateur(-largeurSalle / 2 + 900, -hauteurSalle / 2 + 400, 0);
  formes.add(radiateur1);

  Radiateur radiateur2 = new Radiateur(-largeurSalle / 2 + 50, -hauteurSalle / 2 + 700, profondeurSalle / 2 - 500);
  radiateur2.creerRadiateur(400, 200, 20, radiateurTexture);
  radiateur2.positionnerRadiateur(-largeurSalle / 2 + 900, -hauteurSalle / 2 + 400, 0);
  formes.add(radiateur2);


  // Charger les textures
   PImage toileTexture = loadImage("resources/toile.png");

  // Créer une toile de projecteur
  ToileProjecteur toile = new ToileProjecteur(0, hauteurSalle / 2 - 400, -profondeurSalle / 2 + 150);
  toile.creerToile(700, 500, 5, toileTexture);
  formes.add(toile);

  PImage textureBoitier = loadImage("resources/projecteur.png");
  PImage textureLentille = loadImage("resources/lentilles.png");

  Projecteur projecteur = new Projecteur(0, hauteurSalle / 2 - 680, -profondeurSalle / 2 + 700, textureBoitier, textureLentille);
  projecteur.creerProjecteur();
  formes.add(projecteur);



  // Initialiser la caméra dans le coin supérieur gauche près du plafond
  camX = -largeurSalle / 2;
  camY = -hauteurSalle / 2;
  camZ = profondeurSalle / 2;

  rayon = dist(camX, camY, camZ, 0, 0, 0); // Calculer la distance de la caméra au centre
  theta = atan2(camZ, camX);
  phi = atan2(camY, sqrt(camX * camX + camZ * camZ));

}

void draw() {
  background(255);

  bougerCamera();
  camera(camX, camY, camZ, 0, 0, 0, 0, 1, 0);
  

  // Afficher toutes les formes
  for (QShape forme : formes) {
    pushMatrix();
    translate(forme.x, forme.y, forme.z);
    forme.drawShape();
    popMatrix();
    
    if (forme instanceof ToileProjecteur) {
      ((ToileProjecteur) forme).mettreAJour();
    }
  }
  
}


void bougerCamera() {
  camX = rayon * cos(theta);
  camY = rayon * sin(phi);
  camZ = rayon * sin(theta);
}

void mouseDragged() {
  theta += (mouseX - pmouseX) * 0.01;
  phi += (mouseY - pmouseY) * 0.01;
  // phi = constrain(phi, -HALF_PI, HALF_PI); // Limiter l'angle phi
}

void mouseWheel(MouseEvent event) {
  rayon -= event.getCount() * 10;
  // rayon = constrain(rayon, 100, 1000); // Limiter la distance de la caméra
}

//ouvrir la porte
void keyPressed() {
  if (key == 'o') {
    for (QShape forme : formes) {
      if (forme instanceof Porte) {
        ((Porte) forme).ouvrir();
      }
    }
  
  }
  // Ouvrir ou fermer la toile de projecteur
  if (key == 'p' || key == 'P') {
    for (QShape forme : formes) {
      if (forme instanceof ToileProjecteur) {
        ToileProjecteur toileProjecteur = (ToileProjecteur) forme;
        
        if (toileProjecteur.estDeroulee) {
          toileProjecteur.refermer(); // Ferme la toile
        } else {
          toileProjecteur.derouler(); // Ouvre la toile
        }
      }
    }
  }
}


