extends LynxPlayerObject
class_name LynxAgent

var _tick = String()

@onready var active_item = get_node("ActiveItem")
@onready var _audio_node = get_node("SoundEffect")
@onready var camera = get_node("/root/Scene/Camera2D")
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

# TODO: move active item logic to a separate scene
func start_active_item_animation(animation_name: String, direction: Vector2):
	active_item.visible = true
	
	active_item.set_animation(animation_name)
	
	var offset = active_item.sprite_frames.get_frame_texture(animation_name, 0).get_width() / 2
	active_item.set_position(Vector2i(active_item.position) + offset * Vector2i(direction))
	
	if direction == Config.WEST:
		active_item.set_flip_h(true)
	elif direction == Config.SOUTH:
		active_item.set_flip_v(true)

func end_active_item_animation(animation_name: String, direction: Vector2):
	active_item.visible = false
	
	var offset = active_item.sprite_frames.get_frame_texture(animation_name, 0).get_width() / 2
	active_item.set_position(Vector2i(active_item.position) - offset * Vector2i(direction))
	
	if direction == Config.WEST:
		active_item.set_flip_h(false)
	elif direction == Config.SOUTH:
		active_item.set_flip_v(false)

#Function used to play sound around agents, like sound animation of action
func play_audio(effect):
	self._audio_node.stop() 
	self._audio_node.stream = effect
	self._audio_node.max_distance = 120 + 15 * (4 - self.camera.zoom.x)
	self._audio_node.play() 
