extends LynxAction

var _object_id = int()

func _init():
	self.accepted_attributes = ["object_id"]

func _execute():
	Globals.WORLD_UPDATER.remove_object_by_id(self._object_id)
