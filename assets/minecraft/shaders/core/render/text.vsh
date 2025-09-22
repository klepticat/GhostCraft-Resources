#version 150
#define VERTEX_SHADER
#define RENDERTYPE_TEXT

#moj_import <fog.glsl>
#moj_import <util.glsl>
#moj_import <text.glsl>
#moj_import <version.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

out float depth;

void main() {
	transform.color = Color;
	transform.magicAtlas = texelFetch(Sampler0, ivec2(6, 0), 0) * 255.0;
	transform.textureColor = getVertexColor(Sampler0, gl_VertexID, UV0) * 255;
	transform.textureUV = UV0;
	transform.screenSize = ScreenSize;
	transform.position = Position;
	transform.screenOffset = vec4(0);
	transform.initScreen = ProjMat * ModelViewMat * vec4(Position, 1.0);
	transform.textDepth = Position.z;

	#if defined(MC_1_20_2)
	hideScoreboardNumbers(vec3(0.94, -0.35, 0), vec3(255, 85, 85), 4);
	anchorZ(1.0, 0.03, -1);
	#elif defined(MC_1_20_5)
	hideScoreboardNumbers(vec3(0.94, -0.35, 2000), vec3(255, 85, 85), 4);
	anchorZ(1.0, 2200.03, -1);
	#endif

	verticalSlide(2, Color.a);
	atlasOffset(vec4(44, 255, 0, 199), vec2(5, 0), vec2(1, 1.98));
	offset(3, vec2(0, 0), vec2(0, 1), true);

	depth = Position.z;
	texCoord0 = transform.textureUV;
	vertexDistance = fog_distance_custom(transform.position, FogShape);
	vertexColor = transform.color * texelFetch(Sampler2, UV2 / 16, 0);
	gl_Position = (ProjMat * ModelViewMat * vec4(transform.position, 1.0)) + transform.screenOffset;
}