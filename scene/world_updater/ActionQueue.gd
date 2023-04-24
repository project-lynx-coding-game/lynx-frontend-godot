extends Node

@onready var objects_container = get_owner().objects_container

func _on_execute_action_timer_timeout():
	var next_action = self.get_child(0) # first child (action) from queue
	if !next_action:
		return
	next_action.apply()
