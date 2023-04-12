extends Node

@onready var add_agent_endpoint_url = "http://127.0.0.1:8555/add_object"

@onready var agent = preload("res://entity/object/agent.tscn")

@onready var scene = get_node("../Scene")
@onready var post_agent_http_request = get_node("PostTickHTTPRequest")

func post_agent(agent):
	if post_agent_http_request.get_http_client_status() != HTTPClient.STATUS_CONNECTING:
		var error = post_agent_http_request.request(post_agent_http_request, [], HTTPClient.METHOD_POST, agent.serialize())
		if error != OK:
			push_error("[ERROR] Could not POST Agent")

func create_agent(code):
	agent.instantiate()
	agent.code = code
	scene.add_child(agent)
	post_agent(agent)
