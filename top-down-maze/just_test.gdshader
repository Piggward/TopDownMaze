shader_type canvas_item;

uniform sampler2D light_mask;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    COLOR.a = 0.0;
}