#version 330 compatibility

#define BLOOM // Enable bloom glow on bright areas

#define BLOOM_QUALITY 1 // [0 1 2] Bloom quality level
#define BLOOM_STRENGTH 0.45 // [0.15 0.3 0.45 0.6 0.75 1.0 1.5]
#define BLOOM_THRESHOLD 0.78 // [0.55 0.65 0.72 0.78 0.85 0.92]

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
