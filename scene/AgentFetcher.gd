extends Node

@onready var get_agent_http_request = get_node("GetAgentHTTPRequest")
@onready var agent_panel = get_node("/root/Scene/CanvasLayer/UI/AgentPanel")
var json = JSON.new()

func get_agent(agent_id: String):
	if self.get_agent_http_request.get_http_client_status() not in Globals.BUSY_HTTP_STATUSES:
		var url = "%splayer-agents/%s/%s" % [Globals.SERVER_ADDRESS, str(Globals.USER_ID), agent_id]
		var result = self.get_agent_http_request.request(
			url,
			[],
			HTTPClient.METHOD_GET
		)
		if result != OK:
			push_error("[ERROR] Could not GET Agent: %s" % [result])


func _on_get_agent_http_request_request_completed(result, response_code, headers, body):
	if response_code == 200:
		json.parse(body.get_string_from_utf8())
		var agent = json.get_data()
		self.agent_panel.display(agent)
		return 


func _on_ui_get_agent_requested(agent_id: int):
	self.get_agent(str(agent_id))
