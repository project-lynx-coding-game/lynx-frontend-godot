extends Node2D

func _await_creation_of_object(id: int):
	while(id in Globals.OBJECTS_IN_CREATION):
		await get_tree().process_frame

func get_object_by_id(id: int):
	await _await_creation_of_object(id)
	return get_node(str(id))
	
func remove_object_by_id(id: int):
	var object = await get_object_by_id(id)
	if object:
		remove_child(object)
		object.queue_free()
	else:
		push_warning("[WARNING] Object could not be removed, because it does not exist")

func get_objects_by_position(position: Vector2):
	var objects: Array = []
	for object in get_children():
		if Vector2i(object._position) == Vector2i(position):
			objects.append(object)
	return objects
