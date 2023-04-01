#version 330 core

// Atributos de fragmentos recebidos como entrada ("in") pelo Fragment Shader.
// Neste exemplo, este atributo foi gerado pelo rasterizador como a
// interpolação da posição global e a normal de cada vértice, definidas em
// "shader_vertex.glsl" e "main.cpp".
in vec4 position_world;
in vec4 normal;

// Posição do vértice atual no sistema de coordenadas local do modelo.
in vec4 position_model;

// Coordenadas de textura obtidas do arquivo OBJ (se existirem!)
in vec2 texcoords;

// Matrizes computadas no código C++ e enviadas para a GPU
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

// Identificador que define qual objeto está sendo desenhado no momento
#define PLANE             0
#define CHEVETAO          1
#define BACK              2
#define LEFT              3
#define RIGHT             4
#define CAR               5
#define BANDIDAO          6
#define POLICE            7
#define FERRARI           8
#define INTERFACE_INICIAL 9
#define MORTE             10
#define GRAMA             11
#define ARVORE            12
#define AVIAO             13


uniform int object_id;
uniform float time_past;
uniform float tempoDec;
// Parâmetros da axis-aligned bounding box (AABB) do modelo
uniform vec4 bbox_min;
uniform vec4 bbox_max;

// Variáveis para acesso das imagens de textura
uniform sampler2D TextureImage0;
uniform sampler2D TextureImage1;
uniform sampler2D TextureImage2;
uniform sampler2D TextureImage3;
uniform sampler2D TextureImage4;
uniform sampler2D TextureImage5;
uniform sampler2D TextureImage6;
uniform sampler2D TextureImage7;
uniform sampler2D TextureImage8;
uniform sampler2D TextureImage9;
uniform sampler2D TextureImage10;
uniform sampler2D TextureImage11;
uniform sampler2D TextureImage12;
uniform sampler2D TextureImage13;

// O valor de saída ("out") de um Fragment Shader é a cor final do fragmento.
out vec4 color;

// Constantes
#define M_PI   3.14159265358979323846
#define M_PI_2 1.57079632679489661923

void main()
{
    // Obtemos a posição da câmera utilizando a inversa da matriz que define o
    // sistema de coordenadas da câmera.
    vec4 origin = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 camera_position = inverse(view) * origin;

    // O fragmento atual é coberto por um ponto que percente à superfície de um
    // dos objetos virtuais da cena. Este ponto, p, possui uma posição no
    // sistema de coordenadas global (World coordinates). Esta posição é obtida
    // através da interpolação, feita pelo rasterizador, da posição de cada
    // vértice.
    vec4 p = position_world;

    // Normal do fragmento atual, interpolada pelo rasterizador a partir das
    // normais de cada vértice.
    vec4 n = normalize(normal);

    // Vetor que define o sentido da fonte de luz em relação ao ponto atual.
    vec4 l = normalize(vec4(2.5, 1.5, 1.0, 0.0));

    // Vetor que define o sentido da câmera em relação ao ponto atual.
    vec4 v = normalize(camera_position - p);

    vec4 r = -l + 2*n*dot(n,l); // PREENCHA AQUI o vetor de reflexão especular ideal

    // Coordenadas de textura U e V
    float U = 0.0;
    float V = 0.0;
    float q = 3.5;
    vec3 Kd;
    vec3 I = vec3(1.0,1.0,1.0);
    vec3 Ks = vec3(1.0,1.0,0.8);
    vec3 phong_specular_term  = Ks*I*(pow(max(0,dot(r,v)),q));


    vec3 lambert = I * max(0,dot(n,l));
        vec3 Ia = vec3(0.0,0.0,0.0);
        vec3 Ka = vec3(0.5,0.2,0.2);
        vec3 ambient_term = Ka*Ia;



    if( object_id == GRAMA )
    {

        U = texcoords.x*7;
        V = texcoords.y*7 - pow(tempoDec,2)/200;
        Kd = texture(TextureImage11, vec2(U,V)).rgb;

        color.rgb = Kd * (lambert+0.7) + phong_specular_term;
    }

    if( object_id == AVIAO )
    {

        U = texcoords.x;
        V = texcoords.y;
        Kd = texture(TextureImage13, vec2(U,V)).rgb;

        color.rgb = Kd * (lambert+0.7) + phong_specular_term +ambient_term;
    }

    if( object_id == ARVORE )
    {

        U = texcoords.x;
        V = texcoords.y;
        Kd = texture(TextureImage12, vec2(U,V)).rgb;

        color.rgb = Kd * (lambert+0.7)+ambient_term;// + phong_specular_term +ambient_term;
    }


    if( object_id == CAR )
    {

        U = texcoords.x;
        V = texcoords.y;
        Kd = texture(TextureImage4, vec2(U,V)).rgb;

        color.rgb = Kd * (lambert+0.7) + phong_specular_term +ambient_term;
    }
    if( object_id == CHEVETAO )
    {
        U = texcoords.x;
        V = texcoords.y;

        Kd = texture(TextureImage7, vec2(U,V)).rgb;
        color.rgb = Kd * (lambert+1) + phong_specular_term+ambient_term;
    }
    else if ( object_id == PLANE )
    {
        U = texcoords.x;
        V = texcoords.y * 10 - pow(tempoDec,2)/200;
        Kd = texture(TextureImage0, vec2(U,V)).rgb;

        color.rgb = Kd * (lambert+1.0);
    }
    else if ( object_id == BACK )
    {
        U = texcoords.x;
        V = texcoords.y;
        Kd = texture(TextureImage1, vec2(U,V)).rgb;

        color.rgb = Kd * (lambert + 1);
    }
    else if ( object_id == LEFT )
    {
        U = texcoords.x;
        V = texcoords.y;
        Kd = texture(TextureImage3, vec2(U,V)).rgb;

        color.rgb = Kd * (lambert + 1);
    }
    else if ( object_id == RIGHT )
    {
        U = texcoords.x;
        V = texcoords.y;
        Kd = texture(TextureImage2, vec2(U,V)).rgb;
        color.rgb = Kd * (lambert + 1);
    }
    else if( object_id == BANDIDAO )
    {
        U = texcoords.x;
        V = texcoords.y;

        Kd = texture(TextureImage5, vec2(U,V)).rgb;
        vec3 lambert = I * max(0,dot(n,l));
        vec3 Ia = vec3(0.87,0,0.42);
        vec3 Ka = vec3(0.2,0.2,0.2);
        vec3 ambient_term = Ka*Ia;
        color.rgb = Kd*(lambert+1) + phong_specular_term+(ambient_term*0.25);
    }
    else if( object_id == POLICE )
    {
        U = texcoords.x;
        V = texcoords.y;

        Kd = texture(TextureImage6, vec2(U,V)).rgb;
        float lambert = max(0,dot(n,l));
        color.rgb = Kd * (lambert + 1)+phong_specular_term;
    }
    else if( object_id == POLICE )
    {
        U = texcoords.x;
        V = texcoords.y;

        Kd = texture(TextureImage6, vec2(U,V)).rgb;
        float lambert = max(0,dot(n,l));
        color.rgb = Kd * (lambert + 0.01)/10+phong_specular_term;
    }
    else if( object_id == FERRARI )
    {
        U = texcoords.x;
        V = texcoords.y;

        Kd = texture(TextureImage8, vec2(U,V)).rgb;
        float lambert = max(0,dot(n,l));
        color.rgb = Kd * (lambert + 1)+phong_specular_term;
    }
    else if(object_id == INTERFACE_INICIAL)
    {
        U = texcoords.x;
        V = texcoords.y;

        Kd = texture(TextureImage9, vec2(U,V)).rgb;
        color.rgb = Kd;
    }
    else if(object_id == MORTE)
    {
        U = texcoords.x;
        V = texcoords.y;

        Kd = texture(TextureImage10, vec2(U,V)).rgb;
        color.rgb = Kd;
    }
    else // Objeto desconhecido = preto
    {
        Kd = vec3(0.0,0.0,0.0);
    }

    color.rgb = pow(color.rgb, vec3(1.0,1.0,1.0)/2.2);

}
