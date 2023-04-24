extends LynxAction

var _object_id = int()
var _movement = Vector2()

func _init():
	self.accepted_attributes = ["object_id", "movement"]

func _execute():
	var object = get_parent().objects_container.get_node(str(self._object_id))
	object.set_attribute("_position", object._position + self._movement)
