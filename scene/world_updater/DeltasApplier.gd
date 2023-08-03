extends Node

@onready var objects_container = get_owner().objects_container
@onready var entity_deserializer = get_node("../EntityDeserializer")
@onready var global_action_queue = get_owner().get_node("GlobalActionQueue/Queue")
var json = JSON.new()

func _handle_create_object(entity):
	json.parse(entity._serialized_object)
	var object_in_creation = json.get_data()
	Globals.OBJECTS_IN_CREATION.append(int(object_in_creation["attributes"]["id"]))

func _handle_global_action(entity):
	if entity.get_name() == "CreateObject":
		_handle_create_object(entity)
	self.global_action_queue.add_child(entity)

func _handle_object_action(entity):
	var object = await objects_container.get_object_by_id(entity._object_id)
	if object:
		object.action_queue.add_child(entity)
	else:
		push_error("[ERROR] Could not get object to have applied action on with id: " + str(entity._object_id))

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
				_handle_global_action(entity)
				continue
			_handle_object_action(entity)
