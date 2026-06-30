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

float diffuseTerm(vec3 normal, vec3 lightDir) {
	return max(dot(normal, lightDir), 0.0);
}

vec3 calculateSunColor(vec3 sunDir) {
	float dayFactor = smoothstep(-0.1, 0.35, sunDir.y);
	vec3 dayColor = vec3(1.0);
	vec3 nightColor = vec3(0.55, 0.57, 0.60);
	return mix(nightColor, dayColor, dayFactor);
}

vec3 calculateMoonColor(vec3 moonDir) {
	float nightFactor = smoothstep(-0.05, 0.25, moonDir.y);
	return mix(vec3(0.15, 0.16, 0.18), vec3(0.42, 0.46, 0.55), nightFactor);
}

vec3 neutralBlockFill(float blockLightLevel) {
	float curved = remapLightLevel(blockLightLevel);
	return vec3(curved * 0.42);
}

vec3 applyEmitterSurface(vec3 baseLit, vec3 emission) {
	float emit = dot(emission, vec3(0.2126, 0.7152, 0.0722));
	if (emit < 0.008) {
		return baseLit;
	}
	vec3 tinted = emission * EMISSION_SURFACE;
	float blend = clamp(emit * 1.5, 0.0, 0.55);
	return mix(baseLit, tinted, blend);
}

vec3 applyCustomLighting(vec3 albedo, vec3 normal, vec2 lmcoord, vec3 sunDir, vec3 moonDir, vec3 localEmission) {
	float skyLight = remapLightLevel(clamp(lmcoord.y, 0.0, 1.0));
	float blockLight = remapLightLevel(clamp(lmcoord.x, 0.0, 1.0));

	vec3 sunColor = calculateSunColor(sunDir);
	vec3 moonColor = calculateMoonColor(moonDir);

	float sunDiffuse = diffuseTerm(normal, sunDir) * skyLight * SHADOW_STRENGTH * SUN_INTENSITY;
	float moonDiffuse = diffuseTerm(normal, moonDir) * skyLight * MOON_INTENSITY * (1.0 - smoothstep(-0.1, 0.2, sunDir.y));

	float lightPresence = max(skyLight, blockLight);
	float ambientGate = smoothstep(0.0, 0.04, lightPresence);
	float neutralAmbient = AMBIENT_STRENGTH * ambientGate + skyLight * SKY_AMBIENT;
	vec3 skyLighting = sunColor * sunDiffuse + moonColor * moonDiffuse + vec3(neutralAmbient);

	vec3 totalLight = skyLighting + neutralBlockFill(lmcoord.x);
	vec3 lit = albedo * totalLight;
	lit = applyEmitterSurface(lit, localEmission);
	return applyExposure(lit);
}
