extends Node

@export var tilemap: TileMap
@export var objects_container: Node2D
var state_getter: Node

# TODO: create ObjectsContainer.gd and move object-related functions there
func get_object_by_id(id: int):
	return objects_container.get_node(str(id))
	
func remove_object_by_id(id: int):
	var object = objects_container.get_node(str(id))
	if object:
		objects_container.remove_child(object)
		object.queue_free()

func get_objects_by_position(position: Vector2):
	var objects: Array = []
	for object in objects_container.get_children():
		if object._position == position:
			objects.append(object)
	return objects

func _ready():
	Globals.TILE_SIZE = tilemap.tile_set.tile_size
	self.state_getter = get_node("StateGetter")
