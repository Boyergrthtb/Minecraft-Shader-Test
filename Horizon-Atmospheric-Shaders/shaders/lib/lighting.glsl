#include "/lib/light_options.glsl"
#include "/lib/block_lights.glsl"

vec3 decodeNormal(vec3 encoded) {
	return encoded * 2.0 - 1.0;
}

vec3 calculateSunColor(vec3 sunDir) {
	float dayFactor = smoothstep(-0.1, 0.35, sunDir.y);
	vec3 dayColor = vec3(1.0, 0.97, 0.88);
	vec3 nightColor = vec3(0.45, 0.55, 0.85);
	return mix(nightColor, dayColor, dayFactor);
}

vec3 calculateMoonColor(vec3 moonDir) {
	float nightFactor = smoothstep(-0.05, 0.25, moonDir.y);
	return mix(vec3(0.08, 0.10, 0.16), vec3(0.55, 0.65, 0.95), nightFactor);
}

vec3 sampleColoredBlockLight(sampler2D blurredEmission, vec2 uv, float blockLightLevel) {
	vec3 spill = texture(blurredEmission, uv).rgb;
	vec3 fallback = getDefaultBlockLightColor() * blockLightLevel;
	vec3 mixed = max(spill, fallback * 0.35);
	return mixed * blockLightLevel * BLOCK_LIGHT_RADIUS;
}

vec3 applyCustomLighting(vec3 albedo, vec3 normal, vec2 lmcoord, vec3 sunDir, vec3 moonDir, sampler2D blurredEmission, vec2 texcoord) {
	float blockLight = clamp(lmcoord.x, 0.0, 1.0);
	float skyLight = clamp(lmcoord.y, 0.0, 1.0);

	vec3 sunColor = calculateSunColor(sunDir);
	vec3 moonColor = calculateMoonColor(moonDir);

	float sunNdotL = max(dot(normal, sunDir), 0.0);
	float moonNdotL = max(dot(normal, moonDir), 0.0);

	float sunDiffuse = sunNdotL * skyLight * SHADOW_STRENGTH * SUN_INTENSITY;
	float moonDiffuse = moonNdotL * skyLight * MOON_INTENSITY * (1.0 - smoothstep(-0.1, 0.2, sunDir.y));

	float ambient = AMBIENT_STRENGTH + skyLight * 0.18;
	vec3 skyLighting = sunColor * sunDiffuse + moonColor * moonDiffuse + vec3(ambient);

	vec3 blockLighting = sampleColoredBlockLight(blurredEmission, texcoord, blockLight);

	vec3 totalLight = skyLighting + blockLighting;
	return albedo * totalLight;
}
