// Deferred lighting from encoded gbuffer data

vec3 decodeNormal(vec3 encoded) {
	return encoded * 2.0 - 1.0;
}

vec3 calculateSunColor(vec3 sunDir) {
	float dayFactor = smoothstep(-0.1, 0.3, sunDir.y);
	vec3 dayColor = vec3(1.0, 0.97, 0.88);
	vec3 nightColor = vec3(0.45, 0.55, 0.85);
	return mix(nightColor, dayColor, dayFactor);
}

vec3 calculateBlockLightColor(float blockLight) {
	return mix(vec3(1.0), vec3(1.0, 0.65, 0.35), blockLight);
}

vec3 applyCustomLighting(vec3 albedo, vec3 normal, vec2 lmcoord, vec3 sunDir, float shadowStrength, float ambientStrength) {
	float blockLight = clamp(lmcoord.x, 0.0, 1.0);
	float skyLight = clamp(lmcoord.y, 0.0, 1.0);

	vec3 sunColor = calculateSunColor(sunDir);
	vec3 blockColor = calculateBlockLightColor(blockLight);

	float NdotL = max(dot(normal, sunDir), 0.0);
	float diffuse = NdotL * skyLight * shadowStrength;
	float ambient = ambientStrength + skyLight * 0.2;
	float blockContrib = blockLight * 0.85;

	vec3 lighting = sunColor * diffuse + blockColor * blockContrib + vec3(ambient);
	return albedo * lighting;
}
