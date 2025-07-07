shader_type canvas_item;

uniform sampler2D noise_texture;
uniform vec2 planet_center;
uniform float planet_radius = 100.0;
uniform vec4 ocean_color : source_color = vec4(0.0, 0.2, 0.7, 1.0);
uniform vec4 land_color : source_color = vec4(0.2, 0.8, 0.1, 1.0);

void fragment() {
    // Get fragment position relative to the planet center
    vec2 uv = (FRAGCOORD.xy - planet_center) / planet_radius;

    // Calculate distance from the center to simulate spherical surface
    float dist = length(uv);

    if (dist < 1.0) {  // Inside the planet radius
        // Sample the noise texture
        float noise_value = texture(noise_texture, FRAGCOORD.xy / vec2(textureSize(noise_texture, 0))).r;

        // Use noise to differentiate between land and ocean
        if (noise_value < 0.5) {
            COLOR = ocean_color;
        } else {
            COLOR = land_color;
        }
    } else {
        // Set background (space) as transparent
        COLOR = vec4(1.0, 1.0, 1.0, 1.0);
    }
}
