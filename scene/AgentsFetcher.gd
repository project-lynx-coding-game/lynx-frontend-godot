extends Node

@onready var get_agents_http_request = get_node("GetAgentsHTPPRequest")
@onready var agents = get_node("/root/Scene/CanvasLayer/UI/Agents")
var json = JSON.new()

func get_agents():
	if self.get_agents_http_request.get_http_client_status() not in Globals.BUSY_HTTP_STATUSES:
		var url = "%splayer-agents/%s" % [Globals.SERVER_ADDRESS, str(Globals.USER_ID)]
		var result = self.get_agents_http_request.request(
			url,
			[],
			HTTPClient.METHOD_GET
		)
		if result != OK:
			push_error("[ERROR] Could not GET Agents: %s" % [result])

func _on_get_agents_htpp_request_request_completed(result, response_code, headers, body):
	if response_code == 200:
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		print(response)
		self.agents.handle_agents(response)

func _on_ui_get_agents_requested():
	self.get_agents()
