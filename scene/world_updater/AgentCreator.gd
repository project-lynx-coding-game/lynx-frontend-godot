extends Node

@onready var add_agent_endpoint_url = "http://127.0.0.1:8555/add_object"

@onready var Agent = preload("res://entity/object/agent.tscn")

@onready var scene = get_node("/root/Scene")
@onready var post_agent_http_request = get_node("PostAgentHTTPRequest")

func post_agent(new_agent):
	var payload_json = {"serialized_object": new_agent.serialize()}
	var payload_string = JSON.stringify(payload_json)
	var headers = ["Content-Type: application/json"]
	if post_agent_http_request.get_http_client_status() != HTTPClient.STATUS_CONNECTING:
		var error = post_agent_http_request.request(add_agent_endpoint_url, headers, HTTPClient.METHOD_POST, payload_string)
		if error != OK:
			push_error("[ERROR] Could not POST Agent")

func create_agent(code, owner = "", x = 0, y = 0):
	var new_agent = Agent.instantiate()
	var attributes = {"tick": code, "owner": "", "position": {"x": x, "y": y}}
	new_agent.populate(attributes)
	new_agent.post_populate()
	scene.add_child(new_agent)
	post_agent(new_agent)
