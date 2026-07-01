#version 330 compatibility

#define BLOOM // Enable bloom glow on bright areas

#define BLOOM_QUALITY 1 // [0 1 2] Bloom quality level

#include "/lib/light_options.glsl"

uniform sampler2D colortex3;
uniform float viewWidth;
uniform float viewHeight;

in vec2 texcoord;

/* RENDERTARGETS: 4 */
layout(location = 0) out vec4 blurPass;

void main() {
	vec2 texel = vec2(1.0 / viewWidth, 1.0 / viewHeight) * BLOCK_LIGHT_RADIUS;

#ifdef BLOOM
#if BLOOM_QUALITY >= 2
	vec3 sum = vec3(0.0);
	float wsum = 0.0;
	for (int x = -3; x <= 3; x++) {
		for (int y = -3; y <= 3; y++) {
			float dist = length(vec2(x, y));
			float w = exp(-dist * dist / 4.5);
			sum += texture(colortex3, texcoord + texel * vec2(float(x), float(y)) * 2.5).rgb * w;
			wsum += w;
		}
	}
	blurPass = vec4(sum / wsum, 1.0);
#elif BLOOM_QUALITY >= 1
	vec3 sum = vec3(0.0);
	sum += texture(colortex3, texcoord + texel * vec2(-3.0, 0.0)).rgb * 0.06;
	sum += texture(colortex3, texcoord + texel * vec2(-2.0, 0.0)).rgb * 0.09;
	sum += texture(colortex3, texcoord + texel * vec2(-1.0, 0.0)).rgb * 0.14;
	sum += texture(colortex3, texcoord).rgb * 0.42;
	sum += texture(colortex3, texcoord + texel * vec2(1.0, 0.0)).rgb * 0.14;
	sum += texture(colortex3, texcoord + texel * vec2(2.0, 0.0)).rgb * 0.09;
	sum += texture(colortex3, texcoord + texel * vec2(3.0, 0.0)).rgb * 0.06;
	sum += texture(colortex3, texcoord + texel * vec2(0.0, -3.0)).rgb * 0.06;
	sum += texture(colortex3, texcoord + texel * vec2(0.0, -2.0)).rgb * 0.09;
	sum += texture(colortex3, texcoord + texel * vec2(0.0, -1.0)).rgb * 0.14;
	sum += texture(colortex3, texcoord + texel * vec2(0.0, 1.0)).rgb * 0.14;
	sum += texture(colortex3, texcoord + texel * vec2(0.0, 2.0)).rgb * 0.09;
	sum += texture(colortex3, texcoord + texel * vec2(0.0, 3.0)).rgb * 0.06;
	blurPass = vec4(sum, 1.0);
#else
	blurPass = texture(colortex3, texcoord);
#endif
#else
	blurPass = vec4(0.0);
#endif
}
