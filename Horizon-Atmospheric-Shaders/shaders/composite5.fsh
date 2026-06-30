#version 330 compatibility

#define BLOOM // Enable bloom glow on bright areas

#define BLOOM_STRENGTH 0.45 // [0.15 0.3 0.45 0.6 0.75 1.0 1.5]
#define BLOOM_CLAMP 0.22 // [0.1 0.15 0.22 0.3 0.4 0.55]

uniform sampler2D colortex0;
uniform sampler2D colortex4;
uniform sampler2D colortex7;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	vec3 scene = texture(colortex0, texcoord).rgb;

#ifdef BLOOM
	vec3 mainBloom = texture(colortex4, texcoord).rgb;
	vec3 subBloom = texture(colortex7, texcoord).rgb;
	vec3 bloomAdd = mainBloom * BLOOM_STRENGTH + subBloom;
	bloomAdd = min(bloomAdd, vec3(BLOOM_CLAMP));
	scene += bloomAdd;
#endif

	color = vec4(scene, 1.0);
}
