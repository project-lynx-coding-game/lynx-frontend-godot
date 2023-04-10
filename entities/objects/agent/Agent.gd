extends "res://entities/objects/object/Object.gd"

@export var _code = str()

func _init():
	self.accepted_attributes = ["position", "id", "owner", "code"]

func serialize():
	var serialized = {"type": self.get_name(), "attributes": {}}
	for accepted_attribute in self.accepted_attributes:
		if accepted_attribute == "position":
			serialized["attributes"]["position"]["x"] =  self.position.x / 100
			serialized["attributes"]["position"]["y"] =  self.position.y / 100
		else:
			serialized["attributes"][accepted_attribute] = self.get("_" + accepted_attribute)
	return serialized
