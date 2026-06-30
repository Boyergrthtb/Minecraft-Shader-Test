// Sun and moon
#define SUN_INTENSITY 1.0 // [0.5 0.75 1.0 1.25 1.5] Sunlight intensity
#define MOON_INTENSITY 0.55 // [0.2 0.4 0.55 0.75 1.0] Moonlight intensity
#define SHADOW_STRENGTH 0.85 // [0.7 0.85 0.95] Directional light strength
#define MIN_LIGHT_LEVEL 0.028 // [0.0 0.015 0.028 0.04 0.06 0.08 0.1] Minimum brightness floor
#define AMBIENT_STRENGTH 0.012 // [0.0 0.005 0.01 0.02 0.05 0.1] Ambient fill light
#define SKY_AMBIENT 0.015 // [0.0 0.01 0.015 0.03 0.06 0.1 0.15] Sky ambient contribution
#define LIGHT_DARKNESS 2.0 // [1.0 1.5 2.0 2.5 3.0 3.5 4.0 5.0] Darkness curve (higher = darker caves)
#define BLOCK_LIGHT_RADIUS 0.85 // [0.5 0.75 0.85 1.0 1.25 1.5] Colored block light spread

// Bloom
#define BLOOM_STRENGTH 1.0 // [0.25 0.5 0.75 1.0 1.5 2.0 2.5 3.0] Main bloom intensity
#define BLOOM_THRESHOLD 0.65 // [0.35 0.45 0.55 0.65 0.75 0.85] Main bloom threshold
#define SUB_BLOOM_INTENSITY 1.5 // [0.5 1.0 1.5 2.0 3.0 4.0 6.0] Tight glow on light blocks
#define SUB_BLOOM_RADIUS 1.0 // [0.5 0.75 1.0 1.25 1.5 2.0 3.0] Tight glow radius (pixels)
#define BLOOM_CLAMP 0.45 // [0.2 0.3 0.45 0.6 0.8 1.0] Max bloom contribution per channel

// Torch (warm)
#define TORCH_RED 1.0 // [0.0 0.25 0.5 0.75 1.0]
#define TORCH_GREEN 0.70 // [0.0 0.25 0.5 0.75 1.0]
#define TORCH_BLUE 0.30 // [0.0 0.25 0.5 0.75 1.0]
#define TORCH_INTENSITY 1.0 // [0.0 0.5 0.75 1.0 1.25 1.5]

// Lantern
#define LANTERN_RED 1.0 // [0.0 0.25 0.5 0.75 1.0]
#define LANTERN_GREEN 0.85 // [0.0 0.25 0.5 0.75 1.0]
#define LANTERN_BLUE 0.50 // [0.0 0.25 0.5 0.75 1.0]
#define LANTERN_INTENSITY 1.1 // [0.0 0.5 0.75 1.0 1.25 1.5]

// Soul fire / soul torch
#define SOUL_RED 0.45 // [0.0 0.25 0.5 0.75 1.0]
#define SOUL_GREEN 0.65 // [0.0 0.25 0.5 0.75 1.0]
#define SOUL_BLUE 1.0 // [0.0 0.25 0.5 0.75 1.0]
#define SOUL_INTENSITY 1.0 // [0.0 0.5 0.75 1.0 1.25 1.5]

// Glowstone / shroomlight
#define GLOW_RED 1.0 // [0.0 0.25 0.5 0.75 1.0]
#define GLOW_GREEN 0.95 // [0.0 0.25 0.5 0.75 1.0]
#define GLOW_BLUE 0.70 // [0.0 0.25 0.5 0.75 1.0]
#define GLOW_INTENSITY 1.25 // [0.0 0.5 0.75 1.0 1.25 1.5]

// Sea lantern / sea pickle
#define SEA_RED 0.30 // [0.0 0.25 0.5 0.75 1.0]
#define SEA_GREEN 0.75 // [0.0 0.25 0.5 0.75 1.0]
#define SEA_BLUE 0.95 // [0.0 0.25 0.5 0.75 1.0]
#define SEA_INTENSITY 1.0 // [0.0 0.5 0.75 1.0 1.25 1.5]

// Lava / magma
#define LAVA_RED 1.0 // [0.0 0.25 0.5 0.75 1.0]
#define LAVA_GREEN 0.35 // [0.0 0.25 0.5 0.75 1.0]
#define LAVA_BLUE 0.05 // [0.0 0.25 0.5 0.75 1.0]
#define LAVA_INTENSITY 1.35 // [0.0 0.5 0.75 1.0 1.25 1.5]

// Fire / campfire
#define FIRE_RED 1.0 // [0.0 0.25 0.5 0.75 1.0]
#define FIRE_GREEN 0.50 // [0.0 0.25 0.5 0.75 1.0]
#define FIRE_BLUE 0.12 // [0.0 0.25 0.5 0.75 1.0]
#define FIRE_INTENSITY 1.15 // [0.0 0.5 0.75 1.0 1.25 1.5]

// End rod
#define END_RED 0.85 // [0.0 0.25 0.5 0.75 1.0]
#define END_GREEN 0.90 // [0.0 0.25 0.5 0.75 1.0]
#define END_BLUE 1.0 // [0.0 0.25 0.5 0.75 1.0]
#define END_INTENSITY 1.0 // [0.0 0.5 0.75 1.0 1.25 1.5]

// Redstone
#define REDSTONE_RED 1.0 // [0.0 0.25 0.5 0.75 1.0]
#define REDSTONE_GREEN 0.15 // [0.0 0.25 0.5 0.75 1.0]
#define REDSTONE_BLUE 0.10 // [0.0 0.25 0.5 0.75 1.0]
#define REDSTONE_INTENSITY 0.9 // [0.0 0.5 0.75 1.0 1.25 1.5]

// Amethyst / sculk accent
#define AMETHYST_RED 0.75 // [0.0 0.25 0.5 0.75 1.0]
#define AMETHYST_GREEN 0.45 // [0.0 0.25 0.5 0.75 1.0]
#define AMETHYST_BLUE 0.95 // [0.0 0.25 0.5 0.75 1.0]
#define AMETHYST_INTENSITY 0.85 // [0.0 0.5 0.75 1.0 1.25 1.5]

// Froglight / beacon / misc bright
#define BRIGHT_RED 1.0 // [0.0 0.25 0.5 0.75 1.0]
#define BRIGHT_GREEN 0.95 // [0.0 0.25 0.5 0.75 1.0]
#define BRIGHT_BLUE 0.55 // [0.0 0.25 0.5 0.75 1.0]
#define BRIGHT_INTENSITY 1.2 // [0.0 0.5 0.75 1.0 1.25 1.5]

// Fallback for unknown block light
#define DEFAULT_BLOCK_RED 1.0 // [0.0 0.25 0.5 0.75 1.0]
#define DEFAULT_BLOCK_GREEN 0.80 // [0.0 0.25 0.5 0.75 1.0]
#define DEFAULT_BLOCK_BLUE 0.55 // [0.0 0.25 0.5 0.75 1.0]
#define DEFAULT_BLOCK_INTENSITY 0.85 // [0.0 0.5 0.75 1.0 1.25 1.5]
