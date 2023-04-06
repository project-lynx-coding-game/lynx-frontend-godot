extends Node

@export var post_tick_endpoint_url = "http://0.0.0.0:8555/tick"

@onready var post_tick_http_request = get_node("PostTickHTTPRequest")

var json = JSON.new()

# send post tick requests every timer timeout (1s)
func _on_post_tick_timer_timeout():
	var error = post_tick_http_request.request(post_tick_endpoint_url, [], HTTPClient.METHOD_POST)
	if error != OK:
		push_error("An error occurred in the post tick HTTP request.")

func _on_post_tick_http_request_request_completed(result, response_code, headers, body):
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# TODO do we do something with this scene???
