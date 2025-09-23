#version 150
#define FRAGMENT_SHADER
#define RENDERTYPE_TEXT

#moj_import <fog.glsl>
#moj_import <text.glsl>
#moj_import <version.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in float depth;

out vec4 fragColor;

void main() {
    transform.vertexColor = vertexColor;
    transform.colorMod = ColorModulator;
    transform.texColor = texture(Sampler0, texCoord0);
    transform.color = transform.texColor * vertexColor * ColorModulator;
    transform.textDepth = depth;

	#if defined(MC_1_20_2)
    disableShadow(0);
	#elif defined(MC_1_20_5)
    disableShadow(2200);
	#endif

    fragColor = linear_fog(transform.color, vertexDistance, FogStart, FogEnd, FogColor);
}