#include "/lib/light_options.glsl"
#include "/lib/block_lights.glsl"

vec3 decodeNormal(vec3 encoded) {
	return encoded * 2.0 - 1.0;
}

vec3 calculateSunColor(vec3 sunDir) {
	float dayFactor = smoothstep(-0.1, 0.35, sunDir.y);
	vec3 dayColor = vec3(1.0, 0.97, 0.88);
	vec3 nightColor = vec3(0.12, 0.14, 0.22);
	return mix(nightColor, dayColor, dayFactor);
}

vec3 calculateMoonColor(vec3 moonDir) {
	float nightFactor = smoothstep(-0.05, 0.25, moonDir.y);
	return mix(vec3(0.01, 0.012, 0.02), vec3(0.45, 0.55, 0.85), nightFactor);
}

float curveBlockLight(float blockLightLevel) {
	return blockLightLevel * blockLightLevel * blockLightLevel;
}

vec3 sampleColoredBlockLight(sampler2D blurredEmission, vec2 uv, float blockLightLevel) {
	float curved = curveBlockLight(blockLightLevel);
	if (curved < 0.0001) {
		return vec3(0.0);
	}

	vec3 spill = texture(blurredEmission, uv).rgb;
	vec3 fallback = getDefaultBlockLightColor() * curved;
	vec3 mixed = max(spill * curved, fallback * 0.12);
	return mixed * BLOCK_LIGHT_RADIUS;
}

vec3 applyCustomLighting(vec3 albedo, vec3 normal, vec2 lmcoord, vec3 sunDir, vec3 moonDir, sampler2D blurredEmission, vec2 texcoord) {
	float blockLight = clamp(lmcoord.x, 0.0, 1.0);
	float skyLight = clamp(lmcoord.y, 0.0, 1.0);
	float curvedSky = skyLight * skyLight;

	vec3 sunColor = calculateSunColor(sunDir);
	vec3 moonColor = calculateMoonColor(moonDir);

	float sunNdotL = max(dot(normal, sunDir), 0.0);
	float moonNdotL = max(dot(normal, moonDir), 0.0);

	float sunDiffuse = sunNdotL * curvedSky * SHADOW_STRENGTH * SUN_INTENSITY;
	float moonDiffuse = moonNdotL * curvedSky * MOON_INTENSITY * (1.0 - smoothstep(-0.1, 0.2, sunDir.y));

	float ambient = MIN_LIGHT_LEVEL + AMBIENT_STRENGTH + curvedSky * SKY_AMBIENT;
	vec3 skyLighting = sunColor * sunDiffuse + moonColor * moonDiffuse + vec3(ambient);

	vec3 blockLighting = sampleColoredBlockLight(blurredEmission, texcoord, blockLight);

	vec3 totalLight = skyLighting + blockLighting;
	return albedo * totalLight;
}
