#include "/lib/light_options.glsl"

// Optional black crush for sensor noise — per-pixel only, never view-averaged.
vec3 crushToBlack(vec3 color) {
	if (MIN_LIGHT_LEVEL <= 0.0) {
		return max(color, vec3(0.0));
	}

	float lum = dot(color, vec3(0.2126, 0.7152, 0.0722));
	if (lum >= MIN_LIGHT_LEVEL) {
		return color;
	}

	float t = smoothstep(0.0, MIN_LIGHT_LEVEL, lum);
	return color * t * t;
}
