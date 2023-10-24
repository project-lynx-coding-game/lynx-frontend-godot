extends Node

@onready var post_buy_slot_http_request = get_node("PostBuySlotHTTPRequest")
@onready var agents = get_node("/root/Scene/CanvasLayer/UI/Agents")
var json = JSON.new()

func buy_slot():
	if self.post_buy_slot_http_request.get_http_client_status() not in Globals.BUSY_HTTP_STATUSES:
		var url = "%sbuy-slot/%s" % [Globals.SERVER_ADDRESS, str(Globals.USER_ID)]
		var result = self.post_buy_slot_http_request.request(
			url,
			[],
			HTTPClient.METHOD_POST
		)
		if result != OK:
			push_error("[ERROR] Could not GET Agents: %s" % [result])


func _on_post_buy_slot_http_request_request_completed(result, response_code, headers, body):
	if response_code == 200:
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		if response is Dictionary and response.has("message"):		
			self.agents.show_communication(response["message"])

func _on_ui_buy_slot_requested():
	self.buy_slot()
