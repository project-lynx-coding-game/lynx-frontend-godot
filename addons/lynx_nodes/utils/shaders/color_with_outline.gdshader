shader_type canvas_item;

uniform bool is_player = false;
uniform vec4 tint_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 line_color : source_color = vec4(1.0);
uniform float line_thickness : hint_range(0, 10) = 1.0;

const vec2 OFFSETS[8] = {
	vec2(-1, -1), vec2(-1, 0), vec2(-1, 1), vec2(0, -1), vec2(0, 1), 
	vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if (AT_LIGHT_PASS) {
		COLOR = texture_color;
	} else {
		COLOR = texture_color * tint_color;
	}
	
	if (is_player) {
		vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
		float outline = 0.0;
	
		for (int i = 0; i < OFFSETS.length(); i++) {
			outline += texture(TEXTURE, UV + size * OFFSETS[i]).a;
		}
		outline = min(outline, 1.0);
	
		COLOR = mix(COLOR, line_color, outline - COLOR.a);
	}
}