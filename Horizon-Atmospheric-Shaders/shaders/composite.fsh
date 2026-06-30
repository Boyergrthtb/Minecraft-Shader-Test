#version 330 compatibility

#include "/lib/light_options.glsl"

uniform sampler2D colortex5;
uniform float viewWidth;
uniform float viewHeight;

in vec2 texcoord;

/* RENDERTARGETS: 6 */
layout(location = 0) out vec4 blurredEmission;

void main() {
	vec2 texel = vec2(1.0 / viewWidth, 1.0 / viewHeight) * BLOCK_LIGHT_RADIUS;

	vec3 sum = texture(colortex5, texcoord).rgb * 0.36;
	sum += texture(colortex5, texcoord + texel * vec2(-1.0, 0.0)).rgb * 0.16;
	sum += texture(colortex5, texcoord + texel * vec2(1.0, 0.0)).rgb * 0.16;
	sum += texture(colortex5, texcoord + texel * vec2(0.0, -1.0)).rgb * 0.16;
	sum += texture(colortex5, texcoord + texel * vec2(0.0, 1.0)).rgb * 0.16;

	blurredEmission = vec4(sum, 1.0);
}
