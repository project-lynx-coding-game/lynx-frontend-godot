extends Node2D

func get_object_by_id(id: int):
	return get_node(str(id))
	
func remove_object_by_id(id: int):
	var object = get_node(str(id))
	if object:
		remove_child(object)
		object.queue_free()

func get_objects_by_position(position: Vector2):
	var objects: Array = []
	for object in get_children():
		if object._position == position:
			objects.append(object)
	return objects
