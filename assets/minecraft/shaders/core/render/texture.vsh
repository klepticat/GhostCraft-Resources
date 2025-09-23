#version 150
#define VERTEX_SHADER
#define POSITION_TEX

#moj_import <util.glsl>
#moj_import <texture.glsl>
#moj_import <version.glsl>

in vec3 Position;
in vec2 UV0;

uniform sampler2D Sampler0;
uniform vec2 ScreenSize;
uniform float GameTime;
uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec2 texCoord0;

void main() {
	texCoord0 = UV0;

	transform.position = Position;
	transform.textureUV = UV0;
	transform.gameTime = GameTime;
	transform.guiScale = getGuiScale(ProjMat, ScreenSize);
	transform.color = getVertexColor(Sampler0, gl_VertexID, texCoord0) * 255.0;
	transform.elementDepth = Position.z;

	#if defined(MC_1_20_5)
	anchorZ(400, 1300);
	#endif

	paddingElement(Sampler0);
	offsetElement(1.0, 0, -200);

	gl_Position = ProjMat * ModelViewMat * vec4(transform.position, 1.0);
	texCoord0 = transform.textureUV;
}