extends Node

@onready var entity = preload("res://entities/entity.tscn")
@onready var scene = get_node("/root/Scene")
@onready var tilemap = get_node("/root/Scene/WorldUpdater").tilemap

func recreate_scene(scene_json):
	for entity_json in scene_json["entities"]:
		recreate_object(entity_json)

func recreate_object(object_json):
	var object = entity.deserialize(object_json)
	scene.add_child(object)
