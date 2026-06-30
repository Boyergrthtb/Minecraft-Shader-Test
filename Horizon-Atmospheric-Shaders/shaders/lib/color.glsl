// Color grading and tonemapping utilities

vec3 acesTonemap(vec3 x) {
	const float a = 2.51;
	const float b = 0.03;
	const float c = 2.43;
	const float d = 0.59;
	const float e = 0.14;
	return clamp((x * (a * x + b)) / (x * (c * x + d) + e), 0.0, 1.0);
}

vec3 acesTonemapPreserveBlacks(vec3 x, float blackFloor) {
	vec3 lifted = max(x - vec3(blackFloor), vec3(0.0));
	return acesTonemap(lifted * 1.05);
}

vec3 adjustSaturation(vec3 color, float amount) {
	float luma = dot(color, vec3(0.2126, 0.7152, 0.0722));
	return mix(vec3(luma), color, amount);
}

vec3 applyColorGrade(vec3 color, float strength, float saturation) {
	if (strength < 0.01) {
		return adjustSaturation(color, saturation);
	}
	vec3 graded = adjustSaturation(color, saturation);
	return mix(color, graded, strength * 0.5);
}

float luminance(vec3 c) {
	return dot(c, vec3(0.2126, 0.7152, 0.0722));
}

vec3 extractBloom(vec3 color, float threshold) {
	float lum = luminance(color);
	float knee = smoothstep(threshold - 0.12, threshold + 0.04, lum);
	vec3 bright = max(color - vec3(threshold - 0.08), vec3(0.0));
	return bright * knee;
}

vec3 tightViewBloom(sampler2D viewTex, vec2 uv, vec2 texel, float radius, float intensity) {
	vec2 px = texel * radius;
	vec3 glow = vec3(0.0);
	float wsum = 0.0;

	for (int x = -2; x <= 2; x++) {
		for (int y = -2; y <= 2; y++) {
			vec2 offset = px * vec2(float(x), float(y));
			float dist = length(vec2(x, y));
			float w = exp(-dist * dist / 2.0);
			vec3 sampleColor = texture(viewTex, uv + offset).rgb;
			float lum = luminance(sampleColor);
			sampleColor = extractBloom(sampleColor, 0.35);
			sampleColor *= smoothstep(0.04, 0.22, lum);
			glow += sampleColor * w;
			wsum += w;
		}
	}

	glow /= max(wsum, 0.001);
	return min(glow * intensity, vec3(0.22));
}
