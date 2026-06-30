#version 330 compatibility

#define BLOOM // Enable bloom glow on bright areas

#define BLOOM_QUALITY 1 // [0 1 2] Bloom quality level
#define BLOOM_STRENGTH 1.0 // [0.25 0.5 0.75 1.0 1.5 2.0 2.5 3.0]
#define BLOOM_THRESHOLD 0.65 // [0.35 0.45 0.55 0.65 0.75 0.85]

#include "/lib/color.glsl"

uniform sampler2D colortex0;

in vec2 texcoord;

/* RENDERTARGETS: 3 */
layout(location = 0) out vec4 bloomExtract;

void main() {
	vec3 scene = texture(colortex0, texcoord).rgb;

#ifdef BLOOM
	bloomExtract = vec4(extractBloom(scene, BLOOM_THRESHOLD), 1.0);
#else
	bloomExtract = vec4(0.0);
#endif
}
