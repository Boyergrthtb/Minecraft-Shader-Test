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

	vec3 sum = vec3(0.0);
	float wsum = 0.0;
	const vec2 offsets[5] = vec2[5](
		vec2(0.0, 0.0),
		vec2(-1.0, 0.0),
		vec2(1.0, 0.0),
		vec2(0.0, -1.0),
		vec2(0.0, 1.0)
	);
	const float weights[5] = float[5](0.36, 0.16, 0.16, 0.16, 0.16);

	for (int i = 0; i < 5; i++) {
		vec3 sampleColor = texture(colortex5, texcoord + texel * offsets[i]).rgb;
		float bright = max(max(sampleColor.r, sampleColor.g), sampleColor.b);
		sampleColor *= smoothstep(0.04, 0.18, bright);
		sum += sampleColor * weights[i];
		wsum += weights[i];
	}

	blurredEmission = vec4(sum / max(wsum, 0.001), 1.0);
}
