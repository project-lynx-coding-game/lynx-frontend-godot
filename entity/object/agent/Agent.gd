extends LynxObject
class_name LynxAgent

var _tick = String()
@onready var _border = get_node("Border")

func _ready():
	if Globals.USER_ID == self._owner:
		self._border.set_default_color(Color.DARK_BLUE)

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
