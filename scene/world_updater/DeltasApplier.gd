extends Node

@onready var entity_deserializer = get_node("../EntityDeserializer")

func apply_deltas(deltas_json):
	for delta_json in deltas_json:
		var entity = entity_deserializer.deserialize(delta_json)
		
		if !entity:
			print("[ERROR] Could not deserialize Entity")
		
		if entity is LynxAction:
			get_node("../ActionQueue").add_child(entity)
