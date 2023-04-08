extends Node

@onready var tilemap = get_node("/root/Scene/WorldUpdater").tilemap

func apply_deltas(deltas_data):
	# each object has its ID, we put in in node name
	# then we can query each node by id and do stuff (actions)
	pass
