// Future feature: adaptive auto-exposure (disabled for testing — re-enable in a later version)
//#define AUTO_EXPOSURE

#include "/lib/light_options.glsl"

#ifdef AUTO_EXPOSURE
vec3 applyExposure(vec3 color) {
	float floor = MIN_LIGHT_LEVEL;
	vec3 lifted = max(color - vec3(floor * 0.5), vec3(0.0));
	float scale = 1.0 / max(1.0 - floor, 0.001);
	return max(lifted * scale, vec3(floor));
}
#else
vec3 applyExposure(vec3 color) {
	return max(color, vec3(MIN_LIGHT_LEVEL));
}
#endif
