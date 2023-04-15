extends LynxEntity
class_name LynxObject

var tile_size: Vector2i

var _position = Vector2()
var _id = int()
var _owner = ""

func _init():
	self.accepted_attributes = ["position", "id", "owner"]

func _post_populate():
	# all objects are identified by their unique id
	self.set_name(str(self._id))
	self.position = self._position
	self.position = self.position.snapped(tile_size)
	self.position += Vector2(tile_size / 2)
