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

// Déclaration des variables pour les lumières
PVector[] positionsLumieres = new PVector[4];
color[] couleursLumieres = new color[4];
boolean[] lumieresAllumees = {false, false, false, false}; // État des lumières

boolean lumiereAllumee = false;
PShader shader;



void setup() {
  // fullScreen(P3D);
  background(color(255));
  size(1000, 800, P3D);
  
  // Charger le shader

  shader = loadShader("resources/LightShaderTexFrag.glsl", "resources/LightShaderTexVert.glsl");
  shader.set("lightOn", lumiereAllumee);

  // Définir les positions des lumières au plafond
  positionsLumieres[0] = new PVector(-largeurSalle / 4, hauteurSalle / 2 - 10, -profondeurSalle / 4);
  positionsLumieres[1] = new PVector(largeurSalle / 4, hauteurSalle / 2 - 10, -profondeurSalle / 4);
  positionsLumieres[2] = new PVector(-largeurSalle / 4, hauteurSalle / 2 - 10, profondeurSalle / 4);
  positionsLumieres[3] = new PVector(largeurSalle / 4, hauteurSalle / 2 - 10, profondeurSalle / 4);
  
  // Définir les couleurs des lumières
  couleursLumieres[0] = color(255, 0, 0); // Rouge
  couleursLumieres[1] = color(0, 255, 0); // Vert
  couleursLumieres[2] = color(0, 0, 255); // Bleu
  couleursLumieres[3] = color(255, 255, 0); // Jaune

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
  PImage porteTexture = loadImage("resources/porte.png");

  // Porte arrière
  Porte porteAvant = new Porte(-800, -(hauteurSalle / 2 - 450), profondeurSalle / 2);
  porteAvant.creerPorte(porteTexture, color(0, 0, 255), color(255, 255, 0), false);
  formes.add(porteAvant);
  
  // Porte avant
  Porte porteArriere = new Porte(-800, -(hauteurSalle / 2 - 450), -profondeurSalle / 2);
  porteArriere.creerPorte(porteTexture, color(0, 0, 255), color(255, 255, 0) , false);
  formes.add(porteArriere);
 
  //porte droite
  Porte porteDroite = new Porte(largeurSalle / 2 , -(hauteurSalle / 2 - 450), -profondeurSalle / 2 + 550);
  porteDroite.creerPorte(porteTexture, color(0, 0, 255), color(255, 255, 0), true);
  formes.add(porteDroite);


  // Ajouter un SmartBoard
  SmartBoard smartBoard = new SmartBoard(-largeurSalle / 2 + 320, hauteurSalle / 2 - 400, -profondeurSalle / 2 + 500);
  smartBoard.creerSmartBoard(loadImage("resources/smart-screen.png"), color(0), color(100));
  formes.add(smartBoard);
  
  
  

  // Fenêtre sur le mur gauche
  PImage fenetreTexture = loadImage("resources/fenetre.jpg");
  Fenetre fenetre = new Fenetre(-largeurSalle / 2 + 0.1f, hauteurSalle / 2 - 500, -1000); 
  fenetre.creerFenetre(2500, 500, 50, fenetreTexture);
  fenetre.positionnerFenetre(-largeurSalle / 2, hauteurSalle / 2 - 400, 0);
  formes.add(fenetre);
  
  PImage radiateurTexture = loadImage("resources/radiateur.png");

  // Créer deux radiateurs sur le mur gauche
  Radiateur radiateur1 = new Radiateur(-largeurSalle / 2 + 50, -hauteurSalle / 2 + 650, -profondeurSalle / 2 + 500);
  radiateur1.creerRadiateur(400, 200, 20, radiateurTexture);
  radiateur1.positionnerRadiateur(-largeurSalle / 2 + 900, -hauteurSalle / 2 + 400, 0);
  formes.add(radiateur1);

  Radiateur radiateur2 = new Radiateur(-largeurSalle / 2 + 50, -hauteurSalle / 2 + 650, profondeurSalle / 2 - 500);
  radiateur2.creerRadiateur(400, 200, 20, radiateurTexture);
  radiateur2.positionnerRadiateur(-largeurSalle / 2 + 900, -hauteurSalle / 2 + 400, 0);
  formes.add(radiateur2);

  // Charger la texture du rideau
  PImage textureRideau = loadImage("resources/rideau.png");

  // Créer les rideaux
  Rideau rideauGauche = new Rideau(-largeurSalle / 2 + 0.1f, hauteurSalle / 2 - 250, -1000, 500, 500, textureRideau, true);
  rideauGauche.creerRideau();
  rideauGauche.tourner(PI / 2);
  formes.add(rideauGauche);

  Rideau rideauDroite = new Rideau(-largeurSalle / 2 + 0.1f, hauteurSalle / 2 - 250, 1000, 500, 500, textureRideau, false);
  rideauDroite.creerRideau();
  rideauDroite.tourner(PI / 2);
  formes.add(rideauDroite);
  
  
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

  //poteau cote fenetre
  Poteau poteau = new Poteau(-largeurSalle / 2 + 10, 0 , -profondeurSalle / 2 + 2100 ,15, 120, hauteurSalle);
  poteau.creerPoteau(murTexture);
  formes.add(poteau);


  // Créer  bureau étudiant
  PImage textureBureau = loadImage("resources/whitewood.png");
  PImage textureEcran = loadImage("resources/screen_ubuntu.png");
  PImage textureChaise = loadImage("resources/wood.jpg");
  PImage textureSouris = loadImage("resources/souris.png");
  PImage textureClavier = loadImage("resources/keyboard.jpg");
  PImage textureUC = loadImage("resources/tour.jpg");


// Créer un bureau étudiant au sol
  // BureauEtudiant bureauEtudiant = new BureauEtudiant(-largeurSalle / 2 + 1800, -hauteurSalle / 2 + 550, -profondeurSalle / 2 + 1000);
  // bureauEtudiant.creerBureauEtudiant(500, 300, 300, textureBureau, textureEcran, textureChaise, textureSouris, textureClavier, textureUC, color(255, 255, 0));
  // formes.add(bureauEtudiant);
  
  for (int i = 0; i < 4  ; i++) {
    for (int j = 0; j < 3; j++) {
      //pas espace entre les bureaux
      float x = -largeurSalle / 2 + 1900 - i * 400;
      float y = -hauteurSalle / 2 + 550;
      float z = -profondeurSalle / 2 + 1000 + j * 600;
      BureauEtudiant bureauEtudiant = new BureauEtudiant(x, y, z);
      bureauEtudiant.creerBureauEtudiant(450, 300, 300, textureBureau, textureEcran, textureChaise, textureSouris, textureClavier, textureUC, color(255, 255, 0));
      formes.add(bureauEtudiant);
    }
  }

  
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

  lights();


  // Activer les lumières colorées allumées
  for (int i = 0; i < positionsLumieres.length; i++) {
      if (lumieresAllumees[i]) {
          pointLight(red(couleursLumieres[i]), green(couleursLumieres[i]), blue(couleursLumieres[i]), 
                     positionsLumieres[i].x, positionsLumieres[i].y, positionsLumieres[i].z);
      }
  }
  // Appliquer le shader
  shader.set("lightOn", lumiereAllumee);
  shader(shader);

  // Afficher toutes les formes
  for (QShape forme : formes) {
    pushMatrix();
    translate(forme.x, forme.y, forme.z);
    forme.drawShape();
    popMatrix();
  }

  resetShader();

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
  if (key == 'o' || key == 'O') {
    for (QShape forme : formes) {
      if (forme instanceof Porte) {
        ((Porte) forme).ouvrirFermerPorte();
      }
    }
  
  }
  if (key == 'c' || key == 'C') {
    for (QShape forme : formes) {
      if (forme instanceof BureauEtudiant) {
        ((BureauEtudiant) forme).ouvrirFermerCoffre();
      }
    }
  }
  // Ouvrir ou fermer la toile de projecteur
  if (key == 'p' || key == 'P') {
    for (QShape forme : formes) {
      if (forme instanceof ToileProjecteur) {
        ToileProjecteur toileProjecteur = (ToileProjecteur) forme;
        toileProjecteur.allumerEteindreProjecteur();
      }
    }
  }

  // Allumer ou éteindre la lumière de la salle
  if (key == 'l' || key == 'L') {
    lumiereAllumee = !lumiereAllumee;
  }

  // Ouvrir ou fermer les rideaux
  if (key == 'r' || key == 'R') {
    for (QShape forme : formes) {
      if (forme instanceof Rideau) {
        ((Rideau) forme).toggle();
      }
    }
  }
  
  // Allumer ou éteindre les lumières colorées
  if (key == '1') {
    lumieresAllumees[0] = !lumieresAllumees[0];
  } else if (key == '2') {
    lumieresAllumees[1] = !lumieresAllumees[1];
  } else if (key == '3') {
    lumieresAllumees[2] = !lumieresAllumees[2];
  } else if (key == '4') {
    lumieresAllumees[3] = !lumieresAllumees[3];
  }
}


