#include "/lib/light_options.glsl"
#include "/lib/block_lights.glsl"

vec3 decodeNormal(vec3 encoded) {
	return encoded * 2.0 - 1.0;
}

float remapLightLevel(float level) {
	float shifted = clamp((level - 0.05) / 0.95, 0.0, 1.0);
	return pow(shifted, LIGHT_DARKNESS);
}

vec3 calculateSunColor(vec3 sunDir) {
	float dayFactor = smoothstep(-0.1, 0.35, sunDir.y);
	vec3 dayColor = vec3(1.0, 0.97, 0.88);
	vec3 nightColor = vec3(0.04, 0.05, 0.08);
	return mix(nightColor, dayColor, dayFactor);
}

vec3 calculateMoonColor(vec3 moonDir) {
	float nightFactor = smoothstep(-0.05, 0.25, moonDir.y);
	return mix(vec3(0.0), vec3(0.35, 0.42, 0.65), nightFactor);
}

vec3 sampleColoredBlockLight(sampler2D blurredEmission, vec2 uv, float blockLightLevel) {
	float curved = remapLightLevel(blockLightLevel);
	if (curved < 0.00001) {
		return vec3(0.0);
	}

	vec3 spill = texture(blurredEmission, uv).rgb;
	vec3 fallback = getDefaultBlockLightColor() * curved;
	vec3 mixed = max(spill * curved, fallback * 0.08);
	return mixed * BLOCK_LIGHT_RADIUS;
}

vec3 crushShadows(vec3 color) {
	float floor = MIN_LIGHT_LEVEL;
	vec3 crushed = max(color - vec3(floor), vec3(0.0));
	float scale = 1.0 / max(1.0 - floor, 0.001);
	return crushed * scale;
}

vec3 applyCustomLighting(vec3 albedo, vec3 normal, vec2 lmcoord, vec3 sunDir, vec3 moonDir, sampler2D blurredEmission, vec2 texcoord) {
	float blockLight = remapLightLevel(clamp(lmcoord.x, 0.0, 1.0));
	float skyLight = remapLightLevel(clamp(lmcoord.y, 0.0, 1.0));

	vec3 sunColor = calculateSunColor(sunDir);
	vec3 moonColor = calculateMoonColor(moonDir);

	float sunNdotL = max(dot(normal, sunDir), 0.0);
	float moonNdotL = max(dot(normal, moonDir), 0.0);

	float sunDiffuse = sunNdotL * skyLight * SHADOW_STRENGTH * SUN_INTENSITY;
	float moonDiffuse = moonNdotL * skyLight * MOON_INTENSITY * (1.0 - smoothstep(-0.1, 0.2, sunDir.y));

	float ambient = MIN_LIGHT_LEVEL + AMBIENT_STRENGTH + skyLight * SKY_AMBIENT;
	vec3 skyLighting = sunColor * sunDiffuse + moonColor * moonDiffuse + vec3(ambient);

	vec3 blockLighting = sampleColoredBlockLight(blurredEmission, texcoord, lmcoord.x);

	vec3 totalLight = skyLighting + blockLighting;
	vec3 lit = albedo * totalLight;
	return crushShadows(lit);
}
