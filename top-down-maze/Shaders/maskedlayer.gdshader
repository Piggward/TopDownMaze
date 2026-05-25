ader_type canvas_item;

uniform sampler2D mask_texture;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 mask = texture(mask_texture, UV);
	if (mask.r != 1.0) {
		color.a *= 0.0;
	}
	COLOR = color;
}
