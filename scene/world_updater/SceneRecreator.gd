extends Node

@onready var entity_deserializer = get_node("../EntityDeserializer")
@onready var objects_container = get_owner().objects_container
@onready var tilemap: TileMap = get_owner().tilemap

func recreate_scene(scene_json):
	for entity_json in scene_json["entities"]:
		var entity = entity_deserializer.deserialize(entity_json)
		if !entity:
			continue
		
		# TODO: this could be done at beginning of the loop by checking type key value
		if not (entity is LynxObject):
			push_error("[ERROR] Entity could not be recreated, because it is not an Object")
			entity.queue_free()
			continue
		
		objects_container.add_child(entity)
		entity._post_populate()
