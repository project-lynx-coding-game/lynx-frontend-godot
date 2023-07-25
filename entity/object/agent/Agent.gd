extends LynxObject

var _tick = String()

func init(_position, _id, _owner, _tick):
	self._position = _position
	self._id = _id
	self._owner = _owner
	self._tick = _tick

# TODO: move to Entity
func serialize():
	# TODO: generate attributes json automatically, use logic similar to populate
	var attributes_json = {
		"type": "Object",
		"attributes": {
			"id": self._id,
			"name": "Agent",
			"position": {
				"x": int(self._position.x),
				"y": int(self._position.y)
			},
			"owner": self._owner,
			"tick": self._tick
		}
	}
	return attributes_json
