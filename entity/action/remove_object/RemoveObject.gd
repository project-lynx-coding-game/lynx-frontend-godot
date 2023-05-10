extends LynxAction

var _object_id = int()
@onready var objects_container = get_parent().get_parent().get_parent()
func _init():
	self.accepted_attributes = ["object_id"]

func _execute():
	var object_to_remove = self.objects_container.get_node(str(self._object_id))
	self.objects_container.remove_child(object_to_remove)
	object_to_remove.queue_free()
