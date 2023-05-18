extends Node

@onready var world_updater = get_owner()
@onready var objects_container = world_updater.objects_container
@onready var tilemap: TileMap = world_updater.tilemap

func wipe():
	tilemap.clear()
	for object in objects_container.get_children():
		world_updater.remove_object_by_id(object._id)
