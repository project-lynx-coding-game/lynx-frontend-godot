extends LynxAction

var _object_id = int()
var _position = Vector2()
var _direction = Vector2()
var _animation_name = "default"

func _init():
	self.accepted_attributes = ["object_id", "position"]

func _ready():
	var object = get_parent().object
	_direction = _position - Vector2(object._position)
	
	if _direction == Config.SOUTH:
		_animation_name = "action_south"
	elif _direction == Config.NORTH:
		_animation_name = "action_north"
	elif _direction == Config.WEST:
		_animation_name = "action_west"
	elif _direction == Config.EAST:
		_animation_name = "action_east"

func _execute():
	var object = get_parent().object
	
	object.start_animation(_animation_name)
	
	await get_tree().create_timer(Globals.DEFAULT_ACTION_SPEED / Globals.ACTION_SPEED_MULTIPLIER).timeout
	
	object.end_animation()
