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
			if attribute_value is int or attribute_value is float or attribute_value is bool or attribute_value is String:
				self.set(attribute, attributes_json.get(accepted_attribute))
			elif attribute_value is Vector2:
				var vector2 = Vector2(attributes_json.get(accepted_attribute).get("x"), attributes_json.get(accepted_attribute).get("y"))
				self.set(attribute, vector2)
			elif attribute_value is LynxEntity:
				self.set(attribute, entity_deserializer.deserialize(attributes_json.get(accepted_attribute)))
			elif attribute_value is Array[int]:
				for element in attributes_json.get(accepted_attribute):
					attribute_value.append(int(element))
			elif attribute_value is Array[float]:
				for element in attributes_json.get(accepted_attribute):
					attribute_value.append(float(element))
			elif attribute_value is Array[bool]:
				for element in attributes_json.get(accepted_attribute):
					attribute_value.append(bool(element))
			elif attribute_value is Array[String]:
				for element in attributes_json.get(accepted_attribute):
					attribute_value.append(String(element))
			elif attribute_value is Array[Vector2]:
				for element in attributes_json.get(accepted_attribute):
					var vector2 = Vector2(element.get("x"), element.get("y"))
					attribute_value.append(vector2)
			elif attribute_value is Array[LynxEntity]:
				for element in attributes_json.get(accepted_attribute):
					attribute_value.append(entity_deserializer.deserialize(element))
			else:
				print("[ERROR] Unknown attribute type when populating")

func _post_populate():
	pass
