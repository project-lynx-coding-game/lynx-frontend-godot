extends Node2D

@onready var world_updater = get_owner().get_node("WorldUpdater")
@onready var tooltips = get_owner().get_node("CanvasLayer/UI").tooltips

func _get_tile_type(tile_position):
	var cell_atlas_coords = world_updater.tilemap.get_cell_atlas_coords(0, tile_position)
	var tile_type = world_updater.tilemap.tiles.find_key(Vector2(cell_atlas_coords))
	
	if tile_type:
		return tile_type
	
	# could not determine tile type from cell atlas coords
	return ""
	
func _get_tile_object_counts(tile_position):
	var tile_object_counts: Dictionary = {}
	var objects_on_tile = world_updater.get_objects_by_position(Vector2(tile_position))
	
	for object in objects_on_tile:
		if object.type in tile_object_counts.keys():
			tile_object_counts[object.type] += 1
		else:
			tile_object_counts[object.type] = 1
	
	return tile_object_counts

func _process(delta):
	tooltips.tile_position = world_updater.tilemap.local_to_map(get_global_mouse_position())
	tooltips.tile_type = _get_tile_type(tooltips.tile_position)
	tooltips.tile_object_counts = _get_tile_object_counts(tooltips.tile_position)
