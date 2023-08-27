extends Node

@export var tile_setter: Node

@onready var entity_mapper = get_node("EntityMapper")
var json = JSON.new()

func deserialize_action(attributes: Dictionary, type: String):
	var entity = entity_mapper.map_entity_type_to_node(type)
	if not entity:
		push_error("[ERROR] Deserializing unknown action type: " + type)
		return null
	var entity_instance = entity.instantiate()
	entity_instance._populate(attributes)
	return entity_instance

func deserialize_object(attributes: Dictionary):
	if not attributes.has("name"):
		push_error("[ERROR] No Object name attribute when deserializing")
		return null
	# map entity name to packed tscn
	var entity = entity_mapper.map_entity_type_to_node(attributes.get("name"))

	if not entity:
		push_error("[ERROR] Deserializing unknown Object name: " + attributes.get("name"))
		return null

	var entity_instance = entity.instantiate()
	entity_instance._populate(attributes)
	return entity_instance

func deserialize_tile(attributes: Dictionary):
	if not attributes.has("name"):
		push_error("[ERROR] No Tile name attribute when deserializing")
		return null
	if not attributes.has("position") or not attributes.position.has("x") or not attributes.position.has("y"):
		push_error("[ERROR] No Tile position attribute when deserializing")
		return null
	tile_setter.set_tile(attributes.name, Vector2i(attributes.position.get("x"), attributes.position.get("y")))
	return null

func deserialize(entity_json: Dictionary):
	if not entity_json.has("type"):
		push_error("[ERROR] No Entity type when deserializing")
		return null
	
	if not entity_json.has("attributes"):
		push_error("[ERROR] No Entity attributes when deserializing")
		return null
	
	var attributes = entity_json["attributes"]
	
	if entity_json["type"] == "Object":
		if attributes.has("tags") and attributes.tags.has("walkable"):
			return deserialize_tile(attributes)
		return deserialize_object(attributes)
	else:
		return deserialize_action(attributes, entity_json["type"])
