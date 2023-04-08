extends Node

@onready var tilemap = get_parent().get_parent().tilemap

func recreate_scene(scene_data):
	# recreates scene
	# first we get tiles and do pass through them, setting them on respective positions on tilemap using set_cell()
	# maybe separate node tilemap recreator?
	# second we iterate through all entities and objects and match them to respective nodes (packed into .tscn), then we instantiate them on correct positions
	# maybe separate nodes? object mapper? 
	pass
