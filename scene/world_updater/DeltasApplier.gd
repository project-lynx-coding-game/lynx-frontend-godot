extends Node

@onready var entity_deserializer = get_node("../EntityDeserializer")
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
			get_node("../ActionQueue").add_child(entity) # TODO add action to action queue and execute
