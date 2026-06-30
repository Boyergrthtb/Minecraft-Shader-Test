#version 330 compatibility

#define BLOOM // Enable bloom glow on bright areas

#define SUB_BLOOM_INTENSITY 4.5 // [1.0 2.0 3.0 4.0 4.5 6.0 8.0]
#define SUB_BLOOM_RADIUS 1.25 // [0.5 0.75 1.0 1.25 1.5 2.0 3.0]

#include "/lib/color.glsl"

uniform sampler2D colortex5;
uniform float viewWidth;
uniform float viewHeight;

in vec2 texcoord;

/* RENDERTARGETS: 7 */
layout(location = 0) out vec4 subBloom;

void main() {
#ifdef BLOOM
	vec2 texel = vec2(1.0 / viewWidth, 1.0 / viewHeight);
	subBloom = vec4(tightSubBloom(colortex5, texcoord, texel, SUB_BLOOM_RADIUS, SUB_BLOOM_INTENSITY), 1.0);
#else
	subBloom = vec4(0.0);
#endif
}
