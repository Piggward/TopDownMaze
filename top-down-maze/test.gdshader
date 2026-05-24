shader_type canvas_item;

render_mode blend_add;

uniform sampler2D visibility_mask;
uniform vec4 color1 : source_color;

void fragment() {
    vec4 light_tex = texture(TEXTURE, UV);

    float visibility = texture(
        visibility_mask,
        SCREEN_UV
    ).r;

    float alpha = light_tex.a * (1.0 - visibility);

	COLOR.a = alpha * color1.a;
}

void light() {
    DIFFUSE_LIGHT += LIGHT_COLOR * vec3(1,0,0); //Everything except red turns to 0
}