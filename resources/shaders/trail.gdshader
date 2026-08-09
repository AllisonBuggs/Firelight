shader_type canvas_item;

uniform vec2 dash_direction = vec2(1.0, 0.0); // Normalized world direction
uniform float stretch = 0.5;                  // Trail length
uniform float fade = 0.6;                     // Tail fade amount
uniform vec4 tint : source_color = vec4(1.0);

void fragment() {
    vec2 uv = UV;

    // Stretch opposite the dash direction
    uv -= dash_direction * (1.0 - uv.x) * stretch;

    vec4 color = texture(TEXTURE, uv);

    // Fade toward the back of the dash
    float tail = dot(UV, normalize(abs(dash_direction)));
    color.a *= mix(fade, 1.0, tail);

    COLOR = color * tint;
}