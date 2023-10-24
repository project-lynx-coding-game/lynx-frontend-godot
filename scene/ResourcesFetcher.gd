extends Node

@onready var get_resources_http_request = get_node("GetResourcesHTTPRequest")
@onready var resources_panel = get_node("/root/Scene/CanvasLayer/UI/ResourcesPanel")
var json = JSON.new()

func _ready():
	self.get_resources()

func get_resources():
	if get_resources_http_request.get_http_client_status() not in Globals.BUSY_HTTP_STATUSES:
		var url = "%splayer-resources/%s" % [Globals.SERVER_ADDRESS, str(Globals.USER_ID)]
		var result = self.get_resources_http_request.request(
			url,
			[],
			HTTPClient.METHOD_GET
		)
		if result != OK:
			push_error("[ERROR] Could not GET Resources: %s" % [result])

func _on_get_resources_http_request_request_completed(result, response_code, headers, body):
	if response_code == 200:
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		self.resources_panel.update_resources(response)
