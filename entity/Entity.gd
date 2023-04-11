extends Node2D
class_name LynxEntity

var accepted_attributes = []

# WIP
func populate(attributes_json: Dictionary):
	for accepted_attribute in accepted_attributes:
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
				self.set(accepted_attribute, attributes_json.get(accepted_attribute))
			elif attribute.has_method("deserialize"):
				self.set(accepted_attribute, attribute.deserialize(attributes_json.get(accepted_attribute)))
			else:
				print("[ERROR] Unknown attribute type when populating")

func _post_populate():
	pass
