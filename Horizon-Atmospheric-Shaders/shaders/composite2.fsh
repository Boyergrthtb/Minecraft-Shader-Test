#version 330 compatibility

#include "/lib/settings.glsl"

uniform sampler2D colortex3;
uniform float viewWidth;
uniform float viewHeight;

in vec2 texcoord;

/* RENDERTARGETS: 4 */
layout(location = 0) out vec4 blurH;

void main() {
	vec2 texel = vec2(1.0 / viewWidth, 1.0 / viewHeight);

#if BLOOM && BLOOM_QUALITY >= 1
	vec3 sum = vec3(0.0);
	sum += texture(colortex3, texcoord + texel * vec2(-2.0, 0.0)).rgb * 0.05;
	sum += texture(colortex3, texcoord + texel * vec2(-1.0, 0.0)).rgb * 0.25;
	sum += texture(colortex3, texcoord).rgb * 0.40;
	sum += texture(colortex3, texcoord + texel * vec2(1.0, 0.0)).rgb * 0.25;
	sum += texture(colortex3, texcoord + texel * vec2(2.0, 0.0)).rgb * 0.05;
	blurH = vec4(sum, 1.0);
#else
	blurH = texture(colortex3, texcoord);
#endif
}
