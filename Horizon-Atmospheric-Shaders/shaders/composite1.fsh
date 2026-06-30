#version 330 compatibility

#include "/lib/settings.glsl"

uniform sampler2D colortex0;
uniform float viewWidth;
uniform float viewHeight;

in vec2 texcoord;

/* RENDERTARGETS: 3 */
layout(location = 0) out vec4 bloomExtract;

float luminance(vec3 c) {
	return dot(c, vec3(0.2126, 0.7152, 0.0722));
}

void main() {
	vec3 scene = texture(colortex0, texcoord).rgb;

#ifdef BLOOM
	float threshold = 0.85;
	vec3 bright = max(scene - threshold, vec3(0.0));
	bloomExtract = vec4(bright, 1.0);
#else
	bloomExtract = vec4(0.0);
#endif
}
