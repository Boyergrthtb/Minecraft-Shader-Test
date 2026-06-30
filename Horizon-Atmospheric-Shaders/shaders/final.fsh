#version 330 compatibility

#include "/lib/settings.glsl"
#include "/lib/color.glsl"

uniform sampler2D colortex0;
uniform float viewWidth;
uniform float viewHeight;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	vec3 scene = texture(colortex0, texcoord).rgb;

#if TONEMAP == 1
	scene = acesTonemap(scene * 1.1);
#elif TONEMAP == 2
	scene = acesTonemap(scene * 1.35);
#else
	scene = clamp(scene, 0.0, 1.0);
#endif

#if VIGNETTE
	vec2 uv = texcoord * 2.0 - 1.0;
	float vignette = 1.0 - dot(uv, uv) * 0.18;
	scene *= vignette;
#endif

#if CHROMATIC_ABERRATION
	vec2 offset = (texcoord - 0.5) * 0.002;
	scene.r = texture(colortex0, texcoord + offset).r;
	scene.b = texture(colortex0, texcoord - offset).b;
#endif

	color = vec4(scene, 1.0);
}
