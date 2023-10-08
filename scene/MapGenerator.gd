extends Node

@onready var post_generate_endpoint_url = Globals.SERVER_ADDRESS + "generate_scene"
@onready var post_generate_debug_endpoint_url = Globals.SERVER_ADDRESS + "populate"
@onready var post_generate_http_request = get_node("PostGenerateHTTPRequest")
@onready var state_getter = get_node("../WorldUpdater").state_getter

func post_generate():
	if post_generate_http_request.get_http_client_status() not in Globals.BUSY_HTTP_STATUSES:
		var result = post_generate_http_request.request(post_generate_endpoint_url, [], HTTPClient.METHOD_POST)
		if result != OK:
			push_error("[ERROR] Could not POST generate: " + str(result))
			return
		self.state_getter.current_tick_number = -1

func post_generate_debug():
	if post_generate_http_request.get_http_client_status() not in Globals.BUSY_HTTP_STATUSES:
		var result = post_generate_http_request.request(post_generate_debug_endpoint_url, [], HTTPClient.METHOD_POST)
		if result != OK:
			push_error("[ERROR] Could not POST debug generate: " + str(result))
			return
		self.state_getter.current_tick_number = -1

func _on_ui_post_generate_requested():
	self.post_generate()
	
func _on_ui_post_generate_debug_requested():
	self.post_generate_debug()
