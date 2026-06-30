#version 330 compatibility

#define BLOOM // Enable bloom glow on bright areas

#define BLOOM_QUALITY 1 // [0 1 2] Bloom quality level

uniform sampler2D colortex0;
uniform sampler2D colortex4;
uniform float viewWidth;
uniform float viewHeight;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	vec3 scene = texture(colortex0, texcoord).rgb;
	vec3 bloom = texture(colortex4, texcoord).rgb;

#ifdef BLOOM
	float bloomStrength = 0.35 + float(BLOOM_QUALITY) * 0.15;
	scene += bloom * bloomStrength;
#endif

	color = vec4(scene, 1.0);
}
