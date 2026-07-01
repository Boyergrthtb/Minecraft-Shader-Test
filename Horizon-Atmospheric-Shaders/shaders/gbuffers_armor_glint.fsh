#version 330 compatibility

#include "/lib/gbuffer_data.glsl"

uniform sampler2D lightmap;
uniform sampler2D gtexture;
uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	color *= texture(lightmap, lmcoord);
	if (color.a < alphaTestRef) {
		discard;
	}
	writePassthroughGbuffer();
}
