shader_type canvas_item;

uniform sampler2D vision_tex;
uniform vec2 screen_size = vec2(1920.0, 1080.0);
uniform vec4 color1 : source_color;
uniform bool is_visible = false;

void fragment() {
    vec4 base = texture(TEXTURE, UV);

    // Convert this pixel to screen position
    vec2 screen_uv = SCREEN_UV;

	float vision = texture(vision_tex, screen_uv).r;
	float alpha = smoothstep(0.00, 0.0, vision);

    COLOR = vec4(base.rgb, base.a * alpha);
}

void light() {
	if (LIGHT_COLOR.b != 0.0)
	{
		LIGHT = vec4(COLOR.rgb * LIGHT_COLOR.rgb * LIGHT_ENERGY, LIGHT_COLOR.a);	
	}
}