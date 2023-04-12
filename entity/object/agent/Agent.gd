extends LynxObject

var _code = String()

func _init():
	self.accepted_attributes = ["position", "id", "owner", "code"]

func serialize():
	var serialized = {"type": "Object", "attributes": {"position": {}}}
	serialized["attributes"]["name"] = self.get_name()
	for accepted_attribute in self.accepted_attributes:
		if accepted_attribute == "position":
			serialized["attributes"]["position"]["x"] =  self.position.x
			serialized["attributes"]["position"]["y"] =  self.position.y
		else:
			serialized["attributes"][accepted_attribute] = self.get("_" + accepted_attribute)
	return serialized
