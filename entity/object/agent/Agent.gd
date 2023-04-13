extends LynxObject

var _tick = String()

# payload string used specifically for POST requests to scene-host
func to_payload_string(dict: Dictionary):
	for key in dict.keys():
		var value = dict.get(key)
		if value is Dictionary:
			dict[key] = JSON.stringify(value)
	return JSON.stringify(dict)

# TODO: move to Entity
func serialize():
	# TODO: generate attributes json automatically, use logic similar to populate
	var attributes_json = {
		"type": "Object",
		"attributes": {
			"id" = self._id,
			"position" = {
				"x": self._position.x,
				"y": self._position.y
			},
			"owner" = self._owner,
			"tick" = self._tick
		}
	}
	return to_payload_string(attributes_json)
