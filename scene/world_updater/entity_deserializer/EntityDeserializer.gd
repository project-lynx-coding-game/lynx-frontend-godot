extends Node

@onready var entity_mapper = get_node("EntityMapper")
var json = JSON.new()

func deserialize(entity_json: Dictionary):
	if not entity_json.has("type"):
		print("[ERROR] No Entity type when deserializing")
		return null
	
	if not entity_json.has("attributes"):
		print("[ERROR] No Entity attributes when deserializing")
		return null
	
	json.parse(entity_json["attributes"])
	var attributes = json.get_data()
	
	if not attributes.has("name"):
		print("[ERROR] No Entity name attribute when deserializing")
		return null
	
	# map entity name to packed tscn
	var entity = entity_mapper.map_entity_type_to_node(attributes.get("name"))
	
	if not entity:
		print("[ERROR] Deserializing unknown Entity name: " + attributes.get("name"))
		return null
	
	var entity_instance = entity.instantiate()
	entity_instance.populate(attributes)
	entity_instance.post_populate()
	return entity_instance
