extends LynxObject
class_name LynxAgent

var _tick = String()

func _ready():
	var color = self._generate_color_from_id(int(self._owner))
	var border = get_node("Border")
	var sprite = get_node("AnimatedSprite2D")
	
	sprite.modulate = color
	if self._owner == Globals.USER_ID:
		border.set_default_color(Color.WHITE)
	else:
		border.visible = false

func init(_position, _id, _owner, _tick):
	self._position = _position
	self._id = _id
	self._owner = _owner
	self._tick = _tick

# TODO: move to Entity
func serialize():
	# TODO: generate attributes json automatically, use logic similar to populate
	var attributes_json = {
		"type": "Object",
		"attributes": {
			"id": self._id,
			"name": "Agent",
			"position": {
				"x": int(self._position.x),
				"y": int(self._position.y)
			},
			"owner": self._owner,
			"tick": self._tick
		}
	}
	return attributes_json
	
func _generate_color_from_id(agent_id: int) -> Color:
	# Hash agent_id for more diverse color generation.
	var hashed_id = hash(agent_id) 
	var r = ((hashed_id >> 5) & 0xFF) / 255.0
	var g = ((hashed_id >> 13) & 0xFF) / 255.0
	var b = ((hashed_id >> 21) & 0xFF) / 255.0
	
	return Color(r, g, b)
