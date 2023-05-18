extends LynxAction

# TODO: change to relative path
@onready var world_updater = get_node("/root/Scene/WorldUpdater")

var _object_id = int()

func _init():
	self.accepted_attributes = ["object_id"]

func _execute():
	world_updater.remove_object_by_id(self._object_id)
