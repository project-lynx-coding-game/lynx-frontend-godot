extends Node

@onready var object = get_parent()

func _on_execute_action_timer_timeout():
	if self.get_child_count() == 0:
		return
	var next_action = self.get_child(0) # first child (action) from queue
	if !next_action:
		return
	next_action.apply()
	
