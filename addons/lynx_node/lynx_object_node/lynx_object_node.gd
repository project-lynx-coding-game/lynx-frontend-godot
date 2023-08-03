@tool
extends LynxObject

var action_queue: Node
var execute_action_timer: Timer

@export var action_speed: float

func _setup_action_queue():
	var ActionQueue = load('res://addons/lynx_node/shared/action_queue.tscn')
	action_queue = ActionQueue.instantiate()
	self.add_child(action_queue)
	
func _setup_execute_action_timer():
	var ExecuteActionTimer = load('res://addons/lynx_node/shared/execute_action_timer.tscn')
	
	execute_action_timer = ExecuteActionTimer.instantiate()
	action_speed = execute_action_timer.wait_time
	
	self.add_child(execute_action_timer)
	
	execute_action_timer.connect("timeout", action_queue._on_execute_action_timer_timeout)
	execute_action_timer.start()

func _enter_tree():
	_setup_action_queue()
	_setup_execute_action_timer()
	
func _get_configuration_warnings() -> PackedStringArray:
	for child in get_children():
		if child is AnimatedSprite2D:
			return []
	return ["Add AnimatedSprite2D as a child."]
