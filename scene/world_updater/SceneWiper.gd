extends Node

@onready var objects_container = get_owner().objects_container
@onready var tilemap: TileMap = get_owner().tilemap

func wipe():
	tilemap.clear()
	for object in objects_container.get_children():
		objects_container.remove_child(object)
		object.queue_free()
