extends Node

@onready var post_tick_endpoint_url = "http://127.0.0.1:8555/tick"

@onready var post_tick_http_request = get_node("PostTickHTTPRequest")

var json = JSON.new()

# send post tick requests every timer timeout (1s)
func _on_post_tick_timer_timeout():
	if post_tick_http_request.get_http_client_status() != HTTPClient.STATUS_CONNECTING:
		var error = post_tick_http_request.request(post_tick_endpoint_url, [], HTTPClient.METHOD_POST)
		if error != OK:
			push_error("[ERROR] Could not POST tick")