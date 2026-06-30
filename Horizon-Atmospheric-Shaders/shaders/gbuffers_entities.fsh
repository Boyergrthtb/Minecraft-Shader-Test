#version 330 compatibility

#include "/lib/gbuffer_data.glsl"

uniform sampler2D gtexture;
uniform vec4 entityColor;
uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 normal;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	color.rgb = mix(color.rgb, entityColor.rgb, entityColor.a);
	if (color.a < alphaTestRef) {
		discard;
	}
	writeGbufferData(normal, lmcoord, vec3(0.0));
}
