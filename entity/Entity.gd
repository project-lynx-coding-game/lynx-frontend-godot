extends Node2D
class_name LynxEntity

var accepted_attributes = []

func populate(attributes_json: Dictionary):
	for accepted_attribute in accepted_attributes:
		if attributes_json.has(accepted_attribute):
			var attribute = self.get("_" + accepted_attribute)
			if attribute is Array:
				var type = attribute.get_typed_class_name()
				if type is int or type is float or type is bool or type is String:
					for element in attributes_json.get(accepted_attribute):
						attribute.append(element)
				elif type is Vector2:
					for element in attributes_json.get(accepted_attribute):
						var vector2 = Vector2(element.get("x"), element.get("y"))
						attribute.append(vector2)
				elif type.has_method("deserialize"):
					for element in attributes_json.get(accepted_attribute):
						attribute.append(type.deserialize(element))
				else:
					print("[ERROR] Unknown Array attribute type when populating")
			if attribute is int or attribute is float or attribute is bool or attribute is String:
				self.set(attribute, attributes_json.get(accepted_attribute))
			elif attribute is Vector2:
				var vector2 = Vector2(attributes_json.get(accepted_attribute).get("x"), attributes_json.get(accepted_attribute).get("y"))
				self.set(attribute, vector2)
			elif attribute.has_method("deserialize"):
				self.set(attribute, attribute.deserialize(attributes_json.get(accepted_attribute)))
			else:
				print("[ERROR] Unknown attribute type when populating")

func _post_populate():
	pass
