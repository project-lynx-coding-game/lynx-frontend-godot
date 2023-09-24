shader_type canvas_item;

uniform bool is_player = false;
uniform vec4 tint_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 outline_color : source_color = vec4(1.0);
uniform float outline_thickness = 1.0;

bool hasContraryNeighbour(vec2 uv, vec2 texture_pixel_size, sampler2D texture) {
	for (float i = -ceil(outline_thickness); i <= ceil(outline_thickness); i++) {
		float x = abs(i) > outline_thickness ? outline_thickness * sign(i) : i;
		float offset= outline_thickness - abs(x);
		
		for (float j = -ceil(offset); j <= ceil(offset); j++) {
			float y = abs(j) > offset ? offset * sign(j) : j;
			vec2 xy = uv + texture_pixel_size * vec2(x, y);
			
			if (xy != clamp(xy, vec2(0.0), vec2(1.0)) || texture(texture, xy).a == 0.0) {
				return true;
			}
		}
	}
	
	return false;
}

void fragment() {
	vec2 uv = UV;
	
	vec4 texture_color = texture(TEXTURE, uv);
	COLOR = texture_color * tint_color;
	
	if (is_player && (COLOR.a > 0.0) && hasContraryNeighbour(uv, TEXTURE_PIXEL_SIZE, TEXTURE)) {
		COLOR.rgb = mix(COLOR.rgb, outline_color.rgb, outline_color.a);
		COLOR.a += (1.0 - COLOR.a) * outline_color.a;
	}
}