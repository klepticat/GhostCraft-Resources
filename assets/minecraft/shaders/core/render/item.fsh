#version 150
#define FRAGMENT_SHADER
#define RENDERTYPE_ENTITY_TRANSLUCENT_CULL

#moj_import <fog.glsl>
#moj_import <util.glsl>
#moj_import <item.glsl>
#moj_import <version.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float depth;
in float vertexDistance;
in vec4 vertexColor;
in vec4 overlayColor;
in vec4 shadeColor;
in vec4 lightColor;
in vec2 texCoord0;

out vec4 fragColor;

void main() {
    transform.vertexDistance = vertexDistance;
    transform.texColor = texture(Sampler0, texCoord0);
    transform.vertColor = vertexColor;
    transform.colorMod = ColorModulator;
    transform.shadeColor = shadeColor;
    transform.lightColor = lightColor;
    transform.alpha = textureLod(Sampler0, texCoord0, 0).a * 255.0;
    transform.overlayColor = overlayColor;
    transform.depth = depth;

    emissiveModel();
    perspectiveModel(253.0, 252.0);

    if(transform.color.a < 0.1)
        discard;

    fragColor = linear_fog(transform.color, transform.vertexDistance - (1.0 - transform.emissive) * 4.0, FogStart, FogEnd, FogColor);
}
