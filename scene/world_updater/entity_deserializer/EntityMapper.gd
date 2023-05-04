extends Node

# update when a new entity is added
var available_entity_types = {
	"Agent": load("res://entity/object/agent.tscn"),
	"Log": load("res://entity/object/log.tscn"),
	"Move" : load("res://entity/action/move.tscn"),
	"Push" : load("res://entity/action/push.tscn"),
	"MessageLog" : load("res://entity/action/message_log.tscn")
	}

func map_entity_type_to_node(entity_type):
	if not available_entity_types.has(entity_type):
		return null
	return available_entity_types[entity_type]