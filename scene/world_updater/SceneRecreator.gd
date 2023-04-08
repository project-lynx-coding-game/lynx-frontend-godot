extends Node

@onready var scene = get_node("/root/Scene")
@onready var tilemap = get_node("/root/Scene/WorldUpdater").tilemap

# following dictionary should contain all object types
@onready var objects = [{"Agent": preload("res://objects/agent.tscn")}]

func recreate_scene(scene_json):
	for entity_json in scene_json["entities"]:
		# we do NOT need actions when recreating a scene
		if entity_json["type"] in objects.keys():
			recreate_object(entity_json)

func recreate_object(object_json):
	var new_object = call(objects[object_json["type"]] + ".instantiate()")
	
	# we only need object id and position
	new_object.id = object_json["attributes"]["id"]
	new_object.position = Vector2(object_json["attributes"]["id"]["x"],object_json["attributes"]["id"]["y"])
	
	scene.add_child(new_object)
