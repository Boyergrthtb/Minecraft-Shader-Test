#version 330 compatibility

#include "/lib/gbuffer_data.glsl"
#include "/lib/block_lights.glsl"

uniform sampler2D gtexture;
uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 normal;
in float blockId;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	if (color.a < alphaTestRef) {
		discard;
	}
	vec3 emission = computeBlockEmission(int(blockId + 0.5), lmcoord.x);
	writeGbufferData(normal, lmcoord, emission);
}
