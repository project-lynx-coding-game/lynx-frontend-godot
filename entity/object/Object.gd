extends LynxEntity
class_name LynxObject

var _position = Vector2()
var _id = int()
var _owner = ""


func _init():
	self.accepted_attributes = ["position", "id", "owner"]

func _post_populate():
	self.set_name(str(self._id))
	self.position = Vector2i(self._position) * Globals.TILE_SIZE
	self.position = self.position.snapped(Globals.TILE_SIZE)
	self.position += Vector2(Globals.TILE_SIZE / 2)
