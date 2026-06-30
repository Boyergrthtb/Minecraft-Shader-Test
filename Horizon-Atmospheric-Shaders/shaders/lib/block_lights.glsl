#include "/lib/light_options.glsl"

const int BLOCK_TORCH = 1;
const int BLOCK_LANTERN = 2;
const int BLOCK_SOUL = 3;
const int BLOCK_GLOW = 4;
const int BLOCK_SEA = 5;
const int BLOCK_LAVA = 6;
const int BLOCK_FIRE = 7;
const int BLOCK_MAGMA = 8;
const int BLOCK_END = 9;
const int BLOCK_PICKLE = 10;
const int BLOCK_REDSTONE = 11;
const int BLOCK_JACK = 12;
const int BLOCK_PORTALISH = 13;
const int BLOCK_AMETHYST = 14;
const int BLOCK_FROG = 15;
const int BLOCK_BEACON = 16;
const int BLOCK_ENCHANT = 17;

vec3 makeLightColor(float r, float g, float b, float intensity) {
	vec3 c = vec3(r, g, b);
	float peak = max(max(c.r, c.g), c.b);
	if (peak < 0.001) {
		return vec3(0.0);
	}
	return (c / peak) * intensity * peak;
}

vec3 getEmitterColorForBlock(int blockId) {
	if (blockId == BLOCK_TORCH) {
		return makeLightColor(TORCH_RED, TORCH_GREEN, TORCH_BLUE, TORCH_INTENSITY);
	}
	if (blockId == BLOCK_LANTERN) {
		return makeLightColor(LANTERN_RED, LANTERN_GREEN, LANTERN_BLUE, LANTERN_INTENSITY);
	}
	if (blockId == BLOCK_SOUL) {
		return makeLightColor(SOUL_RED, SOUL_GREEN, SOUL_BLUE, SOUL_INTENSITY);
	}
	if (blockId == BLOCK_GLOW) {
		return makeLightColor(GLOW_RED, GLOW_GREEN, GLOW_BLUE, GLOW_INTENSITY);
	}
	if (blockId == BLOCK_SEA || blockId == BLOCK_PICKLE) {
		return makeLightColor(SEA_RED, SEA_GREEN, SEA_BLUE, SEA_INTENSITY);
	}
	if (blockId == BLOCK_LAVA || blockId == BLOCK_MAGMA) {
		return makeLightColor(LAVA_RED, LAVA_GREEN, LAVA_BLUE, LAVA_INTENSITY);
	}
	if (blockId == BLOCK_FIRE || blockId == BLOCK_JACK) {
		return makeLightColor(FIRE_RED, FIRE_GREEN, FIRE_BLUE, FIRE_INTENSITY);
	}
	if (blockId == BLOCK_END) {
		return makeLightColor(END_RED, END_GREEN, END_BLUE, END_INTENSITY);
	}
	if (blockId == BLOCK_REDSTONE) {
		return makeLightColor(REDSTONE_RED, REDSTONE_GREEN, REDSTONE_BLUE, REDSTONE_INTENSITY);
	}
	if (blockId == BLOCK_AMETHYST || blockId == BLOCK_ENCHANT) {
		return makeLightColor(AMETHYST_RED, AMETHYST_GREEN, AMETHYST_BLUE, AMETHYST_INTENSITY);
	}
	if (blockId == BLOCK_FROG || blockId == BLOCK_BEACON || blockId == BLOCK_PORTALISH) {
		return makeLightColor(BRIGHT_RED, BRIGHT_GREEN, BRIGHT_BLUE, BRIGHT_INTENSITY);
	}
	return vec3(0.0);
}

vec3 getDefaultBlockLightColor() {
	return makeLightColor(DEFAULT_BLOCK_RED, DEFAULT_BLOCK_GREEN, DEFAULT_BLOCK_BLUE, DEFAULT_BLOCK_INTENSITY);
}

vec3 computeBlockEmission(int blockId, float blockLightLevel) {
	vec3 emitter = getEmitterColorForBlock(blockId);
	if (length(emitter) < 0.001) {
		if (blockLightLevel > 0.02) {
			emitter = getDefaultBlockLightColor();
		} else {
			return vec3(0.0);
		}
	}
	float strength = clamp(blockLightLevel, 0.0, 1.0);
	strength = strength * strength;
	return emitter * strength * 2.0;
}
