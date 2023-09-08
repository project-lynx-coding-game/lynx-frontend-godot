extends Node

# update when a new entities is added
var available_entity_types = {
	"Tree" : load("res://entities/objects/tree.tscn"),
	"Wood": load("res://entities/objects/wood.tscn"),
	"Rock" : load("res://entities/objects/rock.tscn"),
	"Stone" : load("res://entities/objects/stone.tscn"),
	"Agent": load("res://entities/objects/player_objects/agents/agent.tscn"),
	"DropArea" : load("res://entities/objects/player_objects/drop_area.tscn"),
	"Move" : load("res://entities/actions/move.tscn"),
	"Push" : load("res://entities/actions/push.tscn"),
	"Chop" : load("res://entities/actions/chop.tscn"),
	"Mine" : load("res://entities/actions/mine.tscn"),
	"CreateObject": load("res://entities/actions/create_object.tscn"),
	"RemoveObject" : load("res://entities/actions/remove_object.tscn"),
	"MessageLog" : load("res://entities/actions/message_log.tscn"),
	"ErrorLog": load("res://entities/actions/error_log.tscn"),
	"Print": load("res://entities/actions/print.tscn"),
	"Take": load("res://entities/actions/take.tscn"),
}

func map_entity_type_to_node(entity_type):
	if not available_entity_types.has(entity_type):
		return null
	return available_entity_types[entity_type]
