#version 150
#define VERTEX_SHADER
#define RENDERTYPE_ENTITY_TRANSLUCENT_CULL

#moj_import <light.glsl>
#moj_import <fog.glsl>
#moj_import <util.glsl>
#moj_import <item.glsl>
#moj_import <version.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in vec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

out float depth;
out float vertexDistance;
out vec4 vertexColor;
out vec4 overlayColor;
out vec4 shadeColor;
out vec4 lightColor;
out vec2 texCoord0;
out vec2 texCoord1;
out vec2 texCoord2;

void main() {
    transform.color = Color;
    transform.position = Position;

	#if defined(MC_1_20_5)
    anchorZ(551, 2201);
    #endif

    gl_Position = ProjMat * ModelViewMat * vec4(transform.position, 1.0);

    depth = Position.z;
    overlayColor = vec4(1);
    shadeColor = Color;
    lightColor = texelFetch(Sampler2, UV2 / 16, 0);

    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, transform.color);
    vertexDistance = fog_distance_custom((ModelViewMat * vec4(transform.position, 1)).xyz, FogShape);
    texCoord0 = UV0;
    texCoord1 = UV1;
    texCoord2 = UV2;
}
