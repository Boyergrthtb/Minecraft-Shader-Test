#version 330 compatibility

#define BLOOM // Enable bloom glow on bright areas
#define VIGNETTE // Darken screen edges for a cinematic look

//#define CHROMATIC_ABERRATION // Subtle color fringing at screen edges

#define BLOOM_QUALITY 1 // [0 1 2] Bloom quality level
#define COLOR_STRENGTH 0.65 // [0.45 0.65 0.8] Color grading strength
#define SATURATION 1.12 // [1.0 1.12 1.2] Color saturation
#define TONEMAP 1 // [0 1 2] Tonemapping mode
#define MIN_LIGHT_LEVEL 0.0 // [0.0 0.0005 0.001 0.002 0.005 0.01 0.02 0.05]

#include "/lib/color.glsl"

uniform sampler2D colortex0;
uniform float viewWidth;
uniform float viewHeight;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	vec3 scene = texture(colortex0, texcoord).rgb;

	scene = max(scene - vec3(MIN_LIGHT_LEVEL), vec3(0.0));

#if TONEMAP == 1
	scene = acesTonemapPreserveBlacks(scene, MIN_LIGHT_LEVEL * 0.5);
#elif TONEMAP == 2
	scene = acesTonemapPreserveBlacks(scene * 1.15, MIN_LIGHT_LEVEL * 0.35);
#else
	scene = clamp(scene, 0.0, 1.0);
#endif

#ifdef VIGNETTE
	vec2 uv = texcoord * 2.0 - 1.0;
	float vignette = 1.0 - dot(uv, uv) * 0.18;
	scene *= vignette;
#endif

#ifdef CHROMATIC_ABERRATION
	vec2 offset = (texcoord - 0.5) * 0.002;
	scene.r = texture(colortex0, texcoord + offset).r;
	scene.b = texture(colortex0, texcoord - offset).b;
#endif

	color = vec4(scene, 1.0);
}
