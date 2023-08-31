extends Node

@onready var post_agent_http_request = get_node("DeleteAgentHTTPRequest")

func delete_agent(agent_id):
	if post_agent_http_request.get_http_client_status() not in Globals.BUSY_HTTP_STATUSES:
		var url = "%sdelete_object?object_id=%s" % [Globals.SERVER_ADDRESS, str(agent_id)]
		var result = post_agent_http_request.request(
			url,
			[], 
			HTTPClient.METHOD_DELETE
		)
		if result != OK:
			push_error("[ERROR] Could not DELETE Agent: " + str(result))

func _on_ui_delete_agent_requested(agent_id: int):
	delete_agent(agent_id)

