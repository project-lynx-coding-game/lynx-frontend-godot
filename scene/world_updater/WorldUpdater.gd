extends Node

@export var tilemap: TileMap
@export var objects_container: Node2D

func _ready():
	Globals.TILE_SIZE = tilemap.tile_set.tile_size
