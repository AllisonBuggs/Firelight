shader_type canvas_item;

// 0.0 → 1.0
uniform float progress : hint_range(0.0, 1.0) = 0.5;

// Tint applied to the filled region
uniform vec4 overlay_color : source_color = vec4(0.2, 1.0, 0.2, 0.5);

// Fill direction
uniform vec2 fill_dir = vec2(0.0, -1.0);

// Alpha cutoff
uniform float alpha_cutoff : hint_range(0.0, 1.0) = 0.01;

// Water wave settings
uniform float wave_height : hint_range(0.0, 0.1) = 0.02;
uniform float wave_frequency : hint_range(1.0, 30.0) = 12.0;
uniform float wave_speed : hint_range(0.0, 5.0) = 1.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    if (tex.a <= alpha_cutoff) {
        discard;
    }

    // Normalize fill direction
    vec2 dir = fill_dir;
    float len_dir = length(dir);
    dir = (len_dir < 1e-5) ? vec2(1.0, 0.0) : normalize(dir);

    // Perpendicular direction
    vec2 perp = vec2(-dir.y, dir.x);

    // Projection range
    vec2 min_corner = vec2(dir.x > 0.0 ? 0.0 : 1.0,
                           dir.y > 0.0 ? 0.0 : 1.0);
    vec2 max_corner = vec2(1.0 - min_corner.x,
                           1.0 - min_corner.y);

    float min_proj = dot(min_corner, dir);
    float max_proj = dot(max_corner, dir);

    float p = dot(UV, dir);
    float t = clamp((p - min_proj) / max(1e-6, max_proj - min_proj), 0.0, 1.0);

    // Position along the wave
    float wave_pos = dot(UV, perp);

    // Animated wave
    float wave =
        sin(wave_pos * wave_frequency * 6.28318 + TIME * wave_speed)
        * wave_height;

    // Wavy fill boundary
    if (t <= progress + wave) {
        COLOR = mix(tex, overlay_color, overlay_color.a);
    } else {
        COLOR = tex;
    }
}