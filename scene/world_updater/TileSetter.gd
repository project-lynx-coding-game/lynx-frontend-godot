extends Node

@onready var tilemap: TileMap = get_parent().get_parent().get_parent().tilemap

func set_tile(name: String, position: Vector2i):
	if not tilemap.tiles.has(name):
		print("[ERROR] Unknown tile name: " + name)
		return
	
	tilemap.set_cell(0, position, 0, tilemap.tiles.get(name), 0)
