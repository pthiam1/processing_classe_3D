#define PROCESSING_TEXLIGHT_SHADER

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

// Définition des variables uniformes
uniform int lightCount;
uniform vec4 lightPosition[8];
uniform vec3 lightDiffuse[8];
uniform vec3 lightAmbient[8];
uniform vec3 lightSpecular[8];
uniform sampler2D texture;
uniform bool lightOn;

// Variables interpolées
varying vec4 vertColor;
varying vec4 vertEmissive;
varying float vertShininess;
varying vec3 ecNormal;
varying vec3 ecPosition;
varying vec2 uv;

// Fonction pour calculer l'éclairage de Lambert
float lambertFactor(vec3 lightDir, vec3 vecNormal) {
    return max(0.0, dot(normalize(lightDir), normalize(vecNormal)));
}

// Fonction pour calculer l'éclairage spéculaire Blinn-Phong
float blinnPhongFactor(vec3 lightDir, vec3 vertPos, vec3 vecNormal, float shininess) {
    vec3 np = normalize(vertPos);
    vec3 ldp = normalize(lightDir - np);
    return pow(max(0.0, dot(ldp, normalize(vecNormal))), shininess);
}

void main() {
    vec3 dfColor = vec3(0.0);
    vec3 amColor = vec3(0.0);
    vec3 spColor = vec3(0.0);
    vec3 normal = normalize(ecNormal);
    vec4 texColor = texture2D(texture, uv.st);

    // Si l'objet émet de la lumière, afficher directement cette couleur
    if (vertEmissive.r > 0.0 || vertEmissive.g > 0.0 || vertEmissive.b > 0.0) {
        gl_FragColor = vertEmissive;
        return;
    }

    // Gestion de l'éclairage
    if (lightOn) {
        for (int i = 0; i < lightCount; i++) {
            vec3 lightDir = normalize(lightPosition[i].xyz - ecPosition);
            float intensity = lambertFactor(lightDir, normal);
            float spec = (vertShininess > 0.0) ? blinnPhongFactor(lightDir, ecPosition, normal, vertShininess) : 0.0;

            dfColor += vertColor.rgb * texColor.rgb * lightDiffuse[i] * intensity;
            spColor += lightSpecular[i] * spec;
            amColor += lightAmbient[i];
        }
    } else {
        dfColor = texColor.rgb; // Réduction de la luminosité lorsque la lumière est éteinte
    }

    // Assemblage de la couleur finale
    gl_FragColor = vec4(dfColor + amColor + spColor, vertColor.a * texColor.a);
}
