/* RENDERTARGETS: 0,1,2,5 */

layout(location = 0) out vec4 color;
layout(location = 1) out vec4 lightmapData;
layout(location = 2) out vec4 encodedNormal;
layout(location = 3) out vec4 emissionBuffer;

void writeGbufferData(vec3 normal, vec2 lmcoord, vec3 emission) {
	lightmapData = vec4(lmcoord, 1.0, 1.0);
	encodedNormal = vec4(normal * 0.5 + 0.5, 1.0);
	emissionBuffer = vec4(emission, 1.0);
}

void writePassthroughGbuffer() {
	lightmapData = vec4(0.0, 0.0, 0.0, 0.0);
	encodedNormal = vec4(0.5, 0.5, 1.0, 1.0);
	emissionBuffer = vec4(0.0);
}
