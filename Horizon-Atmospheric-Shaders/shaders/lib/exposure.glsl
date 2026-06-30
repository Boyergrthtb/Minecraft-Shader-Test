// Future feature: adaptive auto-exposure (disabled for testing — re-enable in a later version)
//#define AUTO_EXPOSURE

#include "/lib/light_options.glsl"

// Crush threshold — equal RGB so dark areas stay neutral black, not orange-grey
vec3 getBlackCrushThreshold() {
	return vec3(MIN_LIGHT_LEVEL);
}

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

#ifdef AUTO_EXPOSURE
vec3 applyExposure(vec3 color) {
	vec3 crushed = crushToBlack(color);
	vec3 lifted = max(crushed - getBlackCrushThreshold() * 0.5, vec3(0.0));
	float scale = 1.0 / max(1.0 - MIN_LIGHT_LEVEL, 0.001);
	return max(lifted * scale, getBlackCrushThreshold());
}
#else
vec3 applyExposure(vec3 color) {
	return crushToBlack(color);
}
#endif
