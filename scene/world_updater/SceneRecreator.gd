extends Node

@onready var scene = get_parent().get_parent()
@onready var tilemap = scene.tilemap

# we do not need actions when recreating a scene
# only objects in following dictionary will be recreated
@onready var objects = [{"Agent": preload("res://objects/agent.tscn")}]

func recreate_scene(scene_data):
	for entity_data in scene_data["entities"]:
		if entity_data["type"] in objects.keys():
			recreate_object(entity_data)

func recreate_object(object_data):
	var new_object = call(objects[object_data["type"]] + ".instantiate()")
	new_object.from_json(object_data["attributes"])
	scene.add_child(new_object)
