@tool
extends LynxObject

var action_queue: Node
var execute_action_timer: Timer

@export var action_speed: float

func _enter_tree():
	_setup_action_queue()
	_setup_execute_action_timer()
