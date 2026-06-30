#version 330 compatibility

#define BLOOM // Enable bloom glow on bright areas
#define VIGNETTE // Darken screen edges for a cinematic look

//#define CHROMATIC_ABERRATION // Subtle color fringing at screen edges

#define BLOOM_QUALITY 1 // [0 1 2] Bloom quality level
#define COLOR_STRENGTH 0.65 // [0.45 0.65 0.8] Color grading strength
#define SATURATION 1.12 // [1.0 1.12 1.2] Color saturation
#define SHADOW_STRENGTH 0.85 // [0.7 0.85 0.95] Sunlight strength
#define AMBIENT_STRENGTH 0.18 // [0.14 0.18 0.22] Ambient light level
#define TONEMAP 1 // [0 1 2] Tonemapping mode

#include "/lib/lighting.glsl"
#include "/lib/color.glsl"

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform vec3 sunPosition;
uniform vec3 fogColor;
uniform float rainStrength;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	vec4 scene = texture(colortex0, texcoord);
	vec4 gbuffer = texture(colortex1, texcoord);
	vec3 encodedNormal = texture(colortex2, texcoord).rgb;

	vec3 result;
	if (gbuffer.a < 0.5) {
		result = scene.rgb;
	} else {
		vec3 normal = decodeNormal(encodedNormal);
		vec3 sunDir = normalize(sunPosition);
		result = applyCustomLighting(scene.rgb, normal, gbuffer.rg, sunDir, SHADOW_STRENGTH, AMBIENT_STRENGTH);
	}

	result = applyColorGrade(result, COLOR_STRENGTH, SATURATION);

	// Atmospheric fog tint
	float fogAmount = rainStrength * 0.15;
	result = mix(result, fogColor, fogAmount);

	color = vec4(result, scene.a);
}
