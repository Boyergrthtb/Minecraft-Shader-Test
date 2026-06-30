#include "/lib/light_options.glsl"
#include "/lib/block_lights.glsl"
#include "/lib/exposure.glsl"

vec3 decodeNormal(vec3 encoded) {
	return encoded * 2.0 - 1.0;
}

float remapLightLevel(float level) {
	float shifted = clamp((level - 0.03) / 0.97, 0.0, 1.0);
	return pow(shifted, LIGHT_DARKNESS);
}

float wrapDiffuse(vec3 normal, vec3 lightDir) {
	return clamp(dot(normal, lightDir) * 0.55 + 0.45, 0.0, 1.0);
}

vec3 calculateSunColor(vec3 sunDir) {
	float dayFactor = smoothstep(-0.1, 0.35, sunDir.y);
	vec3 dayColor = vec3(1.0, 0.97, 0.88);
	vec3 nightColor = vec3(0.12, 0.14, 0.20);
	return mix(nightColor, dayColor, dayFactor);
}

vec3 calculateMoonColor(vec3 moonDir) {
	float nightFactor = smoothstep(-0.05, 0.25, moonDir.y);
	return mix(vec3(0.04, 0.05, 0.08), vec3(0.40, 0.48, 0.70), nightFactor);
}

vec3 sampleColoredBlockLight(sampler2D blurredEmission, vec2 uv, float blockLightLevel) {
	float curved = remapLightLevel(blockLightLevel);
	if (curved < 0.001) {
		return vec3(0.0);
	}

	vec3 spill = texture(blurredEmission, uv).rgb;
	vec3 fallback = getDefaultBlockLightColor() * curved;
	vec3 mixed = mix(fallback * 0.15, spill, 0.65) * curved;
	return min(mixed * BLOCK_LIGHT_RADIUS, vec3(0.65));
}

vec3 applyCustomLighting(vec3 albedo, vec3 normal, vec2 lmcoord, vec3 sunDir, vec3 moonDir, sampler2D blurredEmission, vec2 texcoord) {
	float skyLight = remapLightLevel(clamp(lmcoord.y, 0.0, 1.0));

	vec3 sunColor = calculateSunColor(sunDir);
	vec3 moonColor = calculateMoonColor(moonDir);

	float sunDiffuse = wrapDiffuse(normal, sunDir) * skyLight * SHADOW_STRENGTH * SUN_INTENSITY;
	float moonDiffuse = wrapDiffuse(normal, moonDir) * skyLight * MOON_INTENSITY * (1.0 - smoothstep(-0.1, 0.2, sunDir.y));

	float ambient = MIN_LIGHT_LEVEL + AMBIENT_STRENGTH + skyLight * SKY_AMBIENT;
	vec3 skyLighting = sunColor * sunDiffuse + moonColor * moonDiffuse + vec3(ambient);

	vec3 blockLighting = sampleColoredBlockLight(blurredEmission, texcoord, lmcoord.x);

	vec3 totalLight = skyLighting + blockLighting;
	vec3 lit = albedo * totalLight;
	return applyExposure(lit);
}
