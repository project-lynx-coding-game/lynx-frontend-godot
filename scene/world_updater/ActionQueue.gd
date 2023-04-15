extends Node

func run_next_action():
	var next_action = self.get_child(0) # first child (action) from queue
	next_action.apply()
	next_action.queue_free()
