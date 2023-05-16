extends Node

@export var tilemap: TileMap
@export var objects_container: Node2D
var state_getter: Node

func get_object_by_id(id: int):
	for object in objects_container.get_children():
		if object._id == id:
			return object
	return null

func get_objects_by_position(position: Vector2):
	var objects: Array = []
	for object in objects_container.get_children():
		if object._position == position:
			objects.append(object)
	return objects

func _ready():
	Globals.TILE_SIZE = tilemap.tile_set.tile_size
	self.state_getter = get_node("StateGetter")
