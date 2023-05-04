extends Node

@onready var entity_deserializer = get_node("../EntityDeserializer")
@onready var objects_container = get_owner().objects_container
var json = JSON.new()

func apply_deltas(deltas_json):
	json.parse(deltas_json)
	var deltas = json.get_data()
	for delta_json in deltas:
		json.parse(delta_json)
		var delta = json.get_data()
		var entity = entity_deserializer.deserialize(delta)
		if !entity:
			print("[ERROR] Could not deserialize Entity")
		if entity is LynxAction:
			var object = objects_container.get_node(str(entity._object_id))
			object.get_node("ActionQueue").add_child(entity)