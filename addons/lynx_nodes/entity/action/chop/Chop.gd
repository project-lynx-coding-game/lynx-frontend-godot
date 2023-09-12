extends LynxAction

var _object_id = int()
var _direction = Vector2()
var _animation_name = "default"
var _active_item_animation_name = "axe"

func _init():
	self.accepted_attributes = ["object_id", "direction"]
	
func _ready():
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
	object.start_active_item_animation(_active_item_animation_name, _direction)
	
	await get_tree().create_timer(Globals.DEFAULT_ACTION_SPEED / Globals.ACTION_SPEED_MULTIPLIER).timeout
	
	object.end_animation()
	object.end_active_item_animation(_active_item_animation_name, _direction)
