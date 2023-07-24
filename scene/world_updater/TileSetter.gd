extends Node

@onready var tilemap: TileMap = get_owner().tilemap

func set_tile(name: String, position: Vector2i):
	if not tilemap.tiles.has(name):
		push_error("[ERROR] Unknown tile name: " + name)
		return null
	
	tilemap.set_cell(0, position, 0, tilemap.tiles.get(name), 0)
	return tilemap.get_cell_tile_data(0, position)
