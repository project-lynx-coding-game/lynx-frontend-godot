extends Node

@onready var entity_deserializer = get_node("../EntityDeserializer")
# TODO: change to relative path
@onready var global_action_queue = get_node("/root/Scene/WorldUpdater/GlobalActionQueue/Queue")
var json = JSON.new()


func apply_deltas(deltas_json):
	json.parse(deltas_json)
	var deltas = json.get_data()
	for delta_json in deltas:
		json.parse(delta_json)
		var delta = json.get_data()
		var entity = entity_deserializer.deserialize(delta)
		if !entity:
			push_error("[ERROR] Could not deserialize Entity")
		if entity is LynxAction:
			if not "_object_id" in entity:
				self.global_action_queue.add_child(entity)
				continue
			
			var object = Globals.WORLD_UPDATER.objects_container.get_object_by_id(entity._object_id)
			
			if object:
				object.get_node("ActionQueue").add_child(entity)
			else:
				push_error("[ERROR] Could not get object to have applied action on with id: " + str(entity._object_id))	
