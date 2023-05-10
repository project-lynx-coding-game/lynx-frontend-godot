extends Node

@export var tilemap: TileMap
@export var objects_container: Node2D
var state_getter: Node

func _ready():
	Globals.TILE_SIZE = tilemap.tile_set.tile_size
	self.state_getter = get_node("StateGetter")
