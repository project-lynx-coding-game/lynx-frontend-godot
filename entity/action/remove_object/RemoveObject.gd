extends LynxAction

# TODO: change to relative path
@onready var world_updater = get_node("/root/Scene/WorldUpdater")

var _object_id = int()

func _init():
	self.accepted_attributes = ["object_id"]

func _execute():
	# TODO: check if self would work
	var object_to_remove = world_updater.get_object_by_id(self._object_id)
	
	if object_to_remove:
		self.objects_container.remove_child(object_to_remove)
		object_to_remove.queue_free()
	else:
		push_error("[ERROR] Could not get object to remove with id: " + str(self._object_id))
