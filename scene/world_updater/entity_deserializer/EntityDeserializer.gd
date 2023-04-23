extends Node

@export var tile_setter: Node

@onready var entity_mapper = get_node("EntityMapper")
var json = JSON.new()

func deserialize_action(entity_json: Dictionary):
	if not entity_json.has("attributes"):
		print("[ERROR] No Entity attributes when deserializing")
		return null
	
	json.parse(entity_json["attributes"])
	var attributes = json.get_data()
	var entity = entity_mapper.map_entity_type_to_node(entity_json.get("type"))
	if not entity:
		print("[ERROR] Deserializing unknown action type: " + entity_json.get("type"))
		return null
	
	var entity_instance = entity.instantiate()
	entity_instance._populate(attributes)
	return entity_instance

func deserialize_object(entity_json: Dictionary):
	if not entity_json.has("attributes"):
		print("[ERROR] No Entity attributes when deserializing")
		return null
	
	json.parse(entity_json["attributes"])
	var attributes = json.get_data()
	
	if not attributes.has("name"):
		print("[ERROR] No Entity name attribute when deserializing")
		return null
	
	# it is walkable, so we set tilemap
	if attributes.has("walkable") and attributes.walkable:
		tile_setter.set_tile(attributes.name, Vector2i(attributes.position.get("x"), attributes.position.get("y")))
		return null # TODO change the logic so that we can decouple deserialization and instatiation of entities, and we can handle tiles
	
	# map entity name to packed tscn
	var entity = entity_mapper.map_entity_type_to_node(attributes.get("name"))
	
	if not entity:
		print("[ERROR] Deserializing unknown Entity name: " + attributes.get("name"))
		return null
	
	var entity_instance = entity.instantiate()
	entity_instance._populate(attributes)
	return entity_instance

func deserialize(entity_json: Dictionary):
	if not entity_json.has("type"):
		print("[ERROR] No Entity type when deserializing")
		return null
	
	if entity_json["type"] == "Object":
		return deserialize_object(entity_json)
	else:
		return deserialize_action(entity_json)
