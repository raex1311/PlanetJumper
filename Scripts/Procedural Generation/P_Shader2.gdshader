shader_type canvas_item;

uniform float scale = 5.0;
uniform vec4 ocean_color : source_color = vec4(0.0, 0.2, 0.7, 1.0);
uniform vec4 land_color : source_color = vec4(0.2, 0.8, 0.1, 1.0);
uniform vec2 planet_center;
uniform float planet_radius = 100.0;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

void fragment() {
    // Get fragment position relative to the planet center
    vec2 uv = (FRAGCOORD.xy - planet_center) / planet_radius;
    
    // Calculate distance from center to simulate a sphere
    float dist = length(uv);

    if (dist < 1.0) {  // Inside the planet radius
        // Generate noise based on UV coordinates
        float noise_value = noise(uv * scale);

        // Use noise to decide between land and ocean
        if (noise_value < 0.5) {
            COLOR = ocean_color;
        } else {
            COLOR = land_color;
        }
    } else {
        // Transparent for outside the planet's boundary
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    }
}
