#include <string>

#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <glm/mat4x4.hpp>
#include <glm/vec4.hpp>


bool bbcollision(glm::vec3 bbox_min1,glm::vec3 bbox_min2,glm::vec3 bbox_max1,glm::vec3 bbox_max2)
{
    return(
        bbox_min1.x <= bbox_max2.x &&
        bbox_max1.x >= bbox_min2.x &&
        bbox_min1.z <= bbox_max2.z &&
        bbox_max1.z >= bbox_min2.z);
}

