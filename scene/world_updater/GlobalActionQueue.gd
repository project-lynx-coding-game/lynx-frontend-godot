extends Node

func _process(delta):
	for action in get_children():
		action.apply()
