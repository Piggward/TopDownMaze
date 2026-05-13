shader_type canvas_item;

uniform sampler2D texture2 : repeat_enable;
uniform sampler2D colortexture;
uniform vec4 modulate: source_color;
uniform sampler2D texture23;
uniform bool fade = true;
uniform bool fade_in_radius = false;
uniform vec2 speed;
uniform vec2 speed2;

uniform float radius : hint_range(0.0, 1.0) = 0.5;  // How far the fade goes
uniform float softness : hint_range(0.0, 1.0) = 0.2; // How soft the edge fade is

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
	float textureColor1 = texture(TEXTURE, UV + speed * TIME).r;
	float textureColor2 = texture(texture2, UV + speed2 * TIME).r;
	float energy = textureColor1 * textureColor2;
	if (fade){
		if (fade_in_radius){
		    vec2 center = vec2(0.5);
	    	float dist = distance(UV, center);
		    // Fade starts at radius and smoothly transitions outward
		    float alpha = smoothstep(radius, radius - softness, dist);
		    alpha = clamp(1.0 - alpha, 0.0, 1.0);
			//energy = energy - (1.0 - UV.y) * 0.9 + 0.25;
			energy *= 1.0  - alpha;
		}
		else {
			energy = energy - (1.0 - UV.y) * 0.9 + 0.25;
		}
	}
	float texturecolor3 = texture(texture23, UV).r;
	energy *= texturecolor3;
	vec4 color = texture(colortexture, vec2(energy)) * modulate;
	COLOR = color;
}

