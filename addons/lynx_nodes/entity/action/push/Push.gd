extends LynxAction

var _object_id = int()
var _direction = Vector2()
var _animation_name = "default"
var _pushed_object_ids: Array[int] = []

func _init():
	self.accepted_attributes = ["object_id", "direction", "pushed_object_ids"]
	
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
	
	for pushed_object_id in _pushed_object_ids:
		var pushed_object = await Globals.WORLD_UPDATER.objects_container.get_object_by_id(pushed_object_id)
		await pushed_object.move(Vector2i(pushed_object._position) + Vector2i(self._direction), Globals.DEFAULT_ACTION_SPEED / Globals.ACTION_SPEED_MULTIPLIER)
	
	object.end_animation()
