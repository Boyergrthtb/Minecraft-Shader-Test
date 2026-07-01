// Iris shader options (scanned from this file)
// Must stay identical if duplicated elsewhere.

#define BLOOM // Enable bloom glow on bright areas
#define VIGNETTE // Darken screen edges for a cinematic look

//#define CHROMATIC_ABERRATION // Subtle color fringing at screen edges

#define BLOOM_QUALITY 1 // [0 1 2] Bloom quality level
#define COLOR_STRENGTH 0.65 // [0.45 0.65 0.8] Color grading strength
#define SATURATION 1.12 // [1.0 1.12 1.2] Color saturation
#define SHADOW_STRENGTH 0.85 // [0.7 0.85 0.95] Sunlight strength
#define MIN_LIGHT_LEVEL 0.001 // [0.0 0.0005 0.001 0.002 0.005 0.01 0.02 0.05]
#define AMBIENT_STRENGTH 0.01 // [0.0 0.005 0.01 0.02 0.05 0.1]
#define SKY_AMBIENT 0.03 // [0.0 0.01 0.03 0.06 0.1 0.15]
#define TONEMAP 1 // [0 1 2] Tonemapping mode
