extends Node2D

var accepted_attributes = []

# update when a new entity is added
static func get_available_entity_types():
	return {
		"Agent": load("res://entities/agent.tscn"),
		"Move": load("res://entities/move.tscn")
	}

# WIP
func populate(attributes_json: Dictionary):
	for accepted_attribute in self.get(accepted_attributes):
		if attributes_json.has(accepted_attribute):
			var attribute = self.get("_" + accepted_attribute)
			if attribute is Array:
				var type = attribute.get_typed_class_name()
				if type is int or type is float or type is bool or type is String or type is Vector2:
					for element in attributes_json.get(accepted_attribute):
						attribute.append(element)
				elif type.has_method("deserialize"):
					for element in attributes_json.get(accepted_attribute):
						attribute.append(type.deserialize(element))
				else:
					print("[ERROR] Unknown Array attribute type when populating")
			if attribute is int or attribute is float or attribute is bool or attribute is String or attribute is Vector2:
				self.set(attribute, attributes_json.get(accepted_attribute))
			elif attribute.has_method("deserialize"):
				self.set(attribute, attribute.deserialize(attributes_json.get(accepted_attribute)))
			else:
				print("[ERROR] Unknown attribute type when populating")

func post_populate():
	pass

static func deserialize(entity_json: Dictionary):
	if not entity_json.has("type"):
		print("[ERROR] No Entity type when deserializing")
		return null
	
	if not entity_json.has("attributes"):
		print("[ERROR] No Entity attributes when deserializing")
		return null
	
	var available_entity_types = get_available_entity_types()
	var entity_type = entity_json.get("type")
	if not available_entity_types.has(entity_type):
		print("[ERROR] Deserializing unknown Entity type: " + entity_type)
		return null
	
	var entity = available_entity_types[entity_type].instantiate()
	entity.populate(entity_json.get("attributes"))
	entity.post_populate()
	return entity
