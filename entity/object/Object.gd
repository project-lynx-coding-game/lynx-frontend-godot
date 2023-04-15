extends LynxEntity
class_name LynxObject

var _position = Vector2()
var _id = int()
var _owner = ""

func _init():
	self.accepted_attributes = ["position", "id", "owner"]

func _post_populate():
	# all objects are identified by their unique id
	self.set_name(str(self._id))
	# TODO: set position on a tilemap using _position
