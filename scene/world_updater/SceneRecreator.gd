extends Node

@onready var entity_deserializer = get_node("/root/Scene/WorldUpdater/StateGetter/EntityDeserializer")

@onready var scene = get_node("/root/Scene")
@onready var tilemap = get_node("/root/Scene/WorldUpdater").tilemap

func recreate_scene(scene_json):
	for entity_json in scene_json["entities"]:
		var entity = entity_deserializer.deserialize(entity_json)
		
		if !entity:
			print("[ERROR] Could not deserialize Entity")
		
		# TODO: this could be done at beginning of the loop by checking type key value
		if !entity is LynxObject:
			print("[ERROR] Entity could not be recreated, because it is not an Object")
		
		scene.add_child(entity)
