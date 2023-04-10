extends Node2D

var accepted_attributes = []

# update when a new entity is added
static func get_entity_types():
	return {
		"Agent": load("res://entities/agent.tscn"),
		"Move": load("res://entities/move.tscn")
	}

# WIP
func populate(attributes_json):
	for accepted_attribute in self.accepted_attributes:
		if attributes_json.has(accepted_attribute):
			var value = self.get("_" + accepted_attribute)
			if value is Object and value.has_method("deserialize"):
				var deserialized_value = deserialize(attributes_json[accepted_attribute])
				if deserialized_value != null:
					self.set("_" + accepted_attribute, deserialized_value)
			elif value is Dictionary:
				if value.size() > 0:
					# support for enums
					var dict := attributes_json[accepted_attribute] as Dictionary
					if value.keys()[0] is int:
						# found an enum
						var resultvalue = {}
						for key in dict:
							resultvalue[int(key)] = dict[key]
						self.set("_" + accepted_attribute, resultvalue)
				else:
					self.set("_" + accepted_attribute, attributes_json[accepted_attribute])
			elif value is Array or value is float or value is String or value is bool:
				self.set("_" + accepted_attribute, attributes_json[accepted_attribute])
			elif value is int:
				self.set("_" + accepted_attribute, int(attributes_json[accepted_attribute]))
			else:
				self.set("_" + accepted_attribute, str_to_var(attributes_json[accepted_attribute]))

func post_populate():
	pass

static func deserialize(attributes_json: Dictionary):
	if "type" in attributes_json:
		var entity_types = get_entity_types()
		if not attributes_json["type"] in entity_types.keys():
			print("Error deserializing unknown type " + attributes_json["type"])
			return null
		var entity = entity_types[attributes_json["type"]].instantiate()
		entity.populate(attributes_json["attributes"])
		entity.post_populate()
		return entity
