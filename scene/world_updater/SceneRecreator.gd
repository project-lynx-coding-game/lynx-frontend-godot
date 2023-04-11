extends Node

@onready var entity_deserializer = get_node("EntityDeserializer")

@onready var scene = get_node("/root/Scene")
@onready var tilemap = get_node("/root/Scene/WorldUpdater").tilemap

func recreate_scene(scene_json):
	for entity_json in scene_json["entities"]:
		# recreate object
		var object = entity_deserializer.deserialize(entity_json)
		if !object:
			print("Error deserializing object!")
		scene.add_child(object)
