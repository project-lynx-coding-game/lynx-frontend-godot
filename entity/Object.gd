extends LynxEntity
class_name LynxObject

var _position = Vector2()
var _id = int()
var _owner = ""

func _init():
	self.accepted_attributes = ["position", "id", "owner"]

func post_populate():
	self.position = self._position
