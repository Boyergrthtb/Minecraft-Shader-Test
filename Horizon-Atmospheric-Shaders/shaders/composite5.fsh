#version 330 compatibility

#define BLOOM // Enable bloom glow on bright areas

#define BLOOM_STRENGTH 2.25 // [0.5 1.0 1.5 2.0 2.25 3.0 4.0]

uniform sampler2D colortex0;
uniform sampler2D colortex4;
uniform sampler2D colortex7;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	vec3 scene = texture(colortex0, texcoord).rgb;

#ifdef BLOOM
	vec3 mainBloom = texture(colortex4, texcoord).rgb;
	vec3 subBloom = texture(colortex7, texcoord).rgb;
	scene += mainBloom * BLOOM_STRENGTH;
	scene += subBloom;
#endif

	color = vec4(scene, 1.0);
}
