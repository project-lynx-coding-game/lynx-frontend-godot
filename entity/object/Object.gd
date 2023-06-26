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

# accepts position in tile coordinates 
func move(_target_position: Vector2i, duration: float):
	var tween = get_tree().create_tween()
	
	var target_position = Vector2(_target_position * Globals.TILE_SIZE)
	target_position = target_position.snapped(Globals.TILE_SIZE)
	target_position += Vector2(Globals.TILE_SIZE / 2)
	
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_LINEAR)
	
	await tween.finished
	
	self._position = _target_position
