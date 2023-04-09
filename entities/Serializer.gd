extends Node2D

static func get_serializable_types():
	return {
		"Agent": load("res://entities/agent.tscn"),
		"Move": load("res://entities/move.tscn")
	}

static func serialize(entity):
	var serialized_entity = {"type": entity.get_name(), "attributes": {}}
	for attribute in entity.attributes.keys():
		var value = attribute.value()
		if value is Object and value.has_method("serialize"):
			serialized_entity[attribute] = serialize(value)
		elif value is Array or value is int or value is float or value is String or value is Dictionary or value is bool:
			serialized_entity[attribute] = value
		else:
			serialized_entity[attribute] = var_to_str(value)
	return serialized_entity

static func deserialize(serialized_entity: Dictionary):
	if "type" in serialized_entity:
		if not serialized_entity["type"] in get_serializable_types().keys():
			print("Error deserializing unknown type " + serialized_entity["type"])
			return null
		var entity = get_serializable_types()[serialized_entity["type"]].instantiate()
		for attribute in entity["attributes"].keys():
			if serialized_entity.has(attribute):
				var value = entity["attributes"][attribute]
				if value is Object and value.has_method("serialize"):
					if serialized_entity[attribute].has("type"):
						entity["attributes"]["attribute"] = deserialize(serialized_entity[attribute])
				elif value is Dictionary:
					if value.size() > 0:
						# support for enums
						var dict := serialized_entity[attribute] as Dictionary
						if value.keys()[0] is int:
							# found an enum
							var resultvalue = {}
							for key in dict:
								resultvalue[int(key)] = dict[key]
							entity["attributes"]["attribute"] = resultvalue
					else:
						entity["attributes"]["attribute"] = serialized_entity[attribute]
				elif value is Array or value is float or value is String or value is bool:
					entity["attributes"]["attribute"] = serialized_entity[attribute]
				elif value is int:
					entity["attributes"]["attribute"] = int(serialized_entity[attribute])
				else:
					entity["attributes"]["attribute"] = str_to_var(serialized_entity[attribute])
		entity.construct()
		return entity
