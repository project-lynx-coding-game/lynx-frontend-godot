extends Node

@onready var Agent = preload("res://entity/object/agent.tscn")

@onready var objects_container = get_node("../ObjectsContainer")
@onready var post_agent_http_request = get_node("PostAgentHTTPRequest")

func post_agent(new_agent):
	var payload_json = {"serialized_object": JSON.stringify(new_agent.serialize())}
	var payload_string = JSON.stringify(payload_json)
	var headers = ["Content-Type: application/json"]
	if post_agent_http_request.get_http_client_status() != HTTPClient.STATUS_CONNECTING:
		var error = post_agent_http_request.request(Globals.SERVER_ADDRESS + "add_object", headers, HTTPClient.METHOD_POST, payload_string)
		if error != OK:
			push_error("[ERROR] Could not POST Agent")

func create_agent(_code, _position = Vector2(0, 0), _id = randi(), _owner = ""):
	var new_agent = Agent.instantiate()
	new_agent.init(_position, _id, _owner, _code)
	objects_container.add_child(new_agent) # should be handled by deltas but is not TODO (also we dont check if there's something on that position, deltas would solve that)
	post_agent(new_agent)
	new_agent._post_populate()
#	new_agent.queue_free()

func _on_ui_create_agent_requested(position, code):
	create_agent(code, position)

