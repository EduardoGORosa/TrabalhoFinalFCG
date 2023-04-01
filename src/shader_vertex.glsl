#version 330 core

// Atributos de vértice recebidos como entrada ("in") pelo Vertex Shader.
// Veja a função BuildTrianglesAndAddToVirtualScene() em "main.cpp".
layout (location = 0) in vec4 model_coefficients;
layout (location = 1) in vec4 normal_coefficients;
layout (location = 2) in vec2 texture_coefficients;

// Matrizes computadas no código C++ e enviadas para a GPU
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform sampler2D TextureImage0;
uniform sampler2D TextureImage1;
uniform sampler2D TextureImage2;
uniform sampler2D TextureImage3;

uniform int object_id;
uniform float time_past;
uniform float tempoDec;

#define PLANE             0
#define BACK              2
#define LEFT              3
#define RIGHT             4
// Atributos de vértice que serão gerados como saída ("out") pelo Vertex Shader.
// ** Estes serão interpolados pelo rasterizador! ** gerando, assim, valores
// para cada fragmento, os quais serão recebidos como entrada pelo Fragment
// Shader. Veja o arquivo "shader_fragment.glsl".
out vec4 position_world;
out vec4 position_model;
out vec4 normal;
out vec2 texcoords;
out vec3 vexColor;

void main()
{

    position_world = model * model_coefficients;

    normal = inverse(transpose(model)) * normal_coefficients;
    // Coordenadas de textura obtidas do arquivo OBJ (se existirem!)
    texcoords = texture_coefficients;

    gl_Position = projection * view * model * model_coefficients;
/*

    // Normal do fragmento atual, interpolada pelo rasterizador a partir das
    // normais de cada vértice.
    vec4 n = normalize(normal);

    // Vetor que define o sentido da fonte de luz em relação ao ponto atual.
    vec4 l = normalize(vec4(2.5, 1.5, 1.0, 0.0));

        // Vetor que define o sentido da câmera em relação ao ponto atual.
    vec4 v = normalize(l - position_world);

    vec4 r = -l + 2*n*dot(n,l); // PREENCHA AQUI o vetor de reflexão especular ideal
    // Coordenadas de textura U e V
    vec3 Kd = vec3(1.0f, 1.0f, 1.0f);
    vec3 I = vec3(1.0,1.0,1.0);
    float q = 3.5;
    vec3 Ks = vec3(1.0,1.0,0.8);
    vec3 phong_specular_term  = Ks*I*(pow(max(0,dot(r,v)),q));
    vec3 lambert = Kd*I* max(0,dot(n,l));
    if(lambert != vec3(0.0f, 0.0f, 0.0f)){
        if ( object_id == PLANE )
        {
            vexColor.rgb = lambert + phong_specular_term;
        }
        else if ( object_id == BACK )
        {
            vexColor.rgb = lambert + phong_specular_term;
        }
        else if ( object_id == LEFT )
        {
            vexColor.rgb = lambert + phong_specular_term;
        }
        else if ( object_id == RIGHT )
        {
            vexColor.rgb = lambert + phong_specular_term;
        }
        else
        {*/
            vexColor.rgb = pow(vexColor.rgb, vec3(1.0,1.0,1.0)/2.2);
        //}}
}

