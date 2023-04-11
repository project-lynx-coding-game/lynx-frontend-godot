extends Node

@onready var entity = preload("res://entities/entity.tscn")
@onready var scene = get_node("/root/Scene")
@onready var tilemap = get_node("/root/Scene/WorldUpdater").tilemap

func recreate_scene(scene_json):
	for entity_json in scene_json["entities"]:
		recreate_object(entity_json)

func recreate_object(object_json):
	# TODO: remove "instantiate()"
	# deserialize should be able to get called without an instantiated scene 
	var object = entity.instantiate().deserialize(object_json)
	if object:
		scene.add_child(object)
