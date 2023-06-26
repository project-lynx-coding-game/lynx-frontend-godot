extends LynxAction

var _serialized_object = String()
var json = JSON.new()

func _init():
	self.accepted_attributes = ["serialized_object"]

func _execute():
	json.parse(self._serialized_object)
	var entity = entity_deserializer.deserialize(json.get_data())
	if !entity:
		push_error("[ERROR] Could not deserialize Entity")
		return
	
	# TODO: this could be done at beginning of the loop by checking type key value
	if !entity is LynxObject:
		push_error("[ERROR] Entity could not be recreated, because it is not an Object")
		return
	
	Globals.WORLD_UPDATER.objects_container.add_child(entity)
	entity._post_populate()
	
	Globals.OBJECTS_IN_CREATION.erase(int(entity._id))
