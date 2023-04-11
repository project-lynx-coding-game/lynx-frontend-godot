extends Node

func run_next_action():
	get_child(0).run() # runs first child (action) from queue
