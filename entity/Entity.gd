extends Node2D
class_name LynxEntity

@onready var entity_deserializer = get_node("/root/Scene/WorldUpdater/StateGetter/EntityDeserializer")

var accepted_attributes = []

func set_attribute(attribute, value):
	self.set(attribute, value)
	self._post_populate()

func _populate(attributes_json: Dictionary):
	for accepted_attribute in accepted_attributes:
		if attributes_json.has(accepted_attribute):
			var attribute = "_" + accepted_attribute
			var attribute_value = self.get(attribute)
			if attribute_value is Array:
				var internal_type = attribute_value.get_typed_class_name()
				if internal_type is int or internal_type is float or internal_type is bool or internal_type is String:
					for element in attributes_json.get(accepted_attribute):
						attribute_value.append(element)
				elif internal_type is Vector2:
					for element in attributes_json.get(accepted_attribute):
						var vector2 = Vector2(element.get("x"), element.get("y"))
						attribute_value.append(vector2)
				elif internal_type is LynxEntity:
					for element in attributes_json.get(accepted_attribute):
						attribute_value.append(entity_deserializer.deserialize(element))
				else:
					print("[ERROR] Unknown Array attribute type when populating")
			if attribute_value is int or attribute_value is float or attribute_value is bool or attribute_value is String:
				self.set(attribute, attributes_json.get(accepted_attribute))
			elif attribute_value is Vector2:
				var vector2 = Vector2(attributes_json.get(accepted_attribute)[0], attributes_json.get(accepted_attribute)[1])
				self.set(attribute, vector2)
			elif attribute_value is LynxEntity:
				self.set(attribute, entity_deserializer.deserialize(attributes_json.get(accepted_attribute)))
			else:
				print("[ERROR] Unknown attribute type when populating")

func _post_populate():
	pass
