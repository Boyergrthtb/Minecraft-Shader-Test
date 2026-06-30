#version 330 compatibility

#include "/lib/gbuffer_data.glsl"

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec4 glcolor;

void main() {
	color = glcolor;
	if (color.a < alphaTestRef) {
		discard;
	}
	writeGbufferData(vec3(0.0, 1.0, 0.0), lmcoord);
}
