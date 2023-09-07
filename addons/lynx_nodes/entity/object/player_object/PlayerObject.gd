extends LynxObject
class_name LynxPlayerObject

func _generate_color_from_id(agent_id: int) -> Color:
	# Hash agent_id for more diverse color generation.
	var hashed_id = hash(agent_id) 
	var r = ((hashed_id >> 5) & 0xFF) / 255.0
	var g = ((hashed_id >> 13) & 0xFF) / 255.0
	var b = ((hashed_id >> 21) & 0xFF) / 255.0
	
	return Color(r, g, b)

func _ready():
	var color = self._generate_color_from_id(int(self._owner))
	var sprite = get_node("AnimatedSprite2D")
	
	sprite.material = ShaderMaterial.new()
	sprite.material.shader = load("res://addons/lynx_nodes/utils/shaders/color_with_outline.gdshader")
	sprite.material.set_shader_parameter("is_player", self._owner == Globals.USER_ID)
	sprite.material.set_shader_parameter("tint_color", color)
