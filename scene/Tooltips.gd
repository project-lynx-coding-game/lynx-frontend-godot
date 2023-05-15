extends Node2D

@onready var tilemap: TileMap = get_owner().get_node("WorldUpdater").tilemap
@onready var objects_container: Node2D = get_owner().get_node("WorldUpdater").objects_container
@onready var tooltips = get_owner().get_node("CanvasLayer/UI").tooltips

func _get_tile_type(tile_position):
	var cell_atlas_coords = tilemap.get_cell_atlas_coords(0, tile_position)
	var tile_type = tilemap.tiles.find_key(Vector2(cell_atlas_coords))
	
	if tile_type:
		return tile_type
	
	# could not determine tile type from cell atlas coords
	return ""
	
func _get_tile_objects(tile_position):
	var tile_objects: Dictionary = {}
	
	for object in objects_container.get_children():
		if object._position != Vector2(tile_position):
			continue
		
		if object._type in tile_objects.keys():
			tile_objects[object._type] += 1
		else:
			tile_objects[object._type] = 1
	
	return tile_objects

func _process(delta):
	tooltips.tile_position = tilemap.local_to_map(get_global_mouse_position())
	tooltips.tile_type = _get_tile_type(tooltips.tile_position)
	tooltips.tile_objects = _get_tile_objects(tooltips.tile_position)
