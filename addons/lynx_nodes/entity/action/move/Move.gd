extends LynxAction

var _object_id = int()
var _direction = Vector2()
var _animation_name = "default"
@onready var _animation_effect = load("res://assets/Music/walking.wav")

func _init():
	self.accepted_attributes = ["object_id", "direction"]

func _ready():
	if _direction == Config.SOUTH:
		_animation_name = "move_south"
	elif _direction == Config.NORTH:
		_animation_name = "move_north"
	elif _direction == Config.WEST:
		_animation_name = "move_west"
	elif _direction == Config.EAST:
		_animation_name = "move_east"

func _execute():
	var object = get_parent().object
	
	object.start_animation(_animation_name)
	object.play_audio(_animation_effect, object._position * 16 )
	
	await object.move(Vector2i(object._position) + Vector2i(self._direction), Globals.DEFAULT_ACTION_SPEED / Globals.ACTION_SPEED_MULTIPLIER)
	object.end_animation()
