extends Node

@onready var entity_deserializer = get_node("../EntityDeserializer")

@onready var tilemap = get_owner().tilemap

func apply_deltas(deltas_json):
	for delta_json in deltas_json:
		var entity = entity_deserializer.deserialize(delta_json)
		
		if !entity:
			print("[ERROR] Could not deserialize Entity")
			
# 		TODO: this could be done at beginning of the loop by checking type key value
#		if !entity is LynxAction:
#			print("[ERROR] Entity could not be recreated, because it is not an Action")

#		TODO: apply deserialized action
		
