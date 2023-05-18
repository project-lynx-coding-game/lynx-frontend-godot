extends Node

func wipe():
	Globals.WORLD_UPDATER.tilemap.clear()
	for object in Globals.WORLD_UPDATER.objects_container.get_children():
		Globals.WORLD_UPDATER.remove_object_by_id(object._id)
