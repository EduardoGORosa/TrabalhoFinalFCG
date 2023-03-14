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
#define SPHERE 0
#define BUNNY  1
#define PLANE  2
#define CAR    3
uniform int object_id;

// Parâmetros da axis-aligned bounding box (AABB) do modelo
uniform vec4 bbox_min;
uniform vec4 bbox_max;

// Variáveis para acesso das imagens de textura
uniform sampler2D TextureImage0;
uniform sampler2D TextureImage1;
uniform sampler2D TextureImage2;

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
    vec4 l = normalize(vec4(1.0, 1.0, 0.0, 1.0));

    // Vetor que define o sentido da câmera em relação ao ponto atual.
    vec4 v = normalize(camera_position - p);

    vec4 r = -l + 2*n*dot(n,l); // PREENCHA AQUI o vetor de reflexão especular ideal

    // Coordenadas de textura U e V
    float U = 0.0;
    float V = 0.0;
    // Parâmetros que definem as propriedades espectrais da superfície
    vec3 Ka; // Refletância ambiente
    float q; // Expoente especular para o modelo de iluminação de Phong

    if( object_id == CAR )
    {
        U = texcoords.x;
        V = texcoords.y;
        q = 1.0;
    }
    else if ( object_id == PLANE )
    {
        q = 20.0;
        U = texcoords.x;
        V = texcoords.y;
    }
    else // Objeto desconhecido = preto
    {
        U = texcoords.x;
        V = texcoords.y;
    }

    // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
    vec3 Kd = texture(TextureImage2, vec2(U,V)).rgb;

    vec3 I = vec3(1.0, 1.0, 1.0);

    // Espectro da luz ambiente
    vec3 Ia = vec3(1.0, 1.0, 1.0); // PREENCHA AQUI o espectro da luz ambiente

    // Termo difuso utilizando a lei dos cossenos de Lambert
    vec3 lambert_diffuse_term = Kd; // PREENCHA AQUI o termo difuso de Lambert

    // Termo ambiente
    vec3 ambient_term = Ka*Ia; // PREENCHA AQUI o termo ambiente


    color.rgb = lambert_diffuse_term + ambient_term;

    color.rgb = pow(color.rgb, vec3(1.0,1.0,1.0)/2.2);

}

