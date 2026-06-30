// Color grading and tonemapping utilities

vec3 acesTonemap(vec3 x) {
	const float a = 2.51;
	const float b = 0.03;
	const float c = 2.43;
	const float d = 0.59;
	const float e = 0.14;
	return clamp((x * (a * x + b)) / (x * (c * x + d) + e), 0.0, 1.0);
}

vec3 adjustSaturation(vec3 color, float amount) {
	float luma = dot(color, vec3(0.2126, 0.7152, 0.0722));
	return mix(vec3(luma), color, amount);
}

vec3 applyColorGrade(vec3 color, float strength, float saturation) {
	vec3 graded = color;
	graded.r = pow(graded.r, 0.95);
	graded.g = pow(graded.g, 1.0);
	graded.b = pow(graded.b, 1.05);
	graded = mix(color, graded, strength);
	graded = adjustSaturation(graded, saturation);
	return graded;
}
