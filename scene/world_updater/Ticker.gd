extends Node

@export var post_tick_endpoint_url = "http://0.0.0.0:8555/tick"

@onready var post_tick_http_request = get_node("PostTickHTTPRequest")

var json = JSON.new()
var is_processing_request = false

# send post tick requests every timer timeout (1s)
func _on_post_tick_timer_timeout():
	if not is_processing_request:
		var error = post_tick_http_request.request(post_tick_endpoint_url, [], HTTPClient.METHOD_POST)
		if error != OK and error != ERR_BUSY:
			push_error("An error occurred in the post tick HTTP request.")
	is_processing_request = true

func _on_post_tick_http_request_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		# TODO do we do something with this scene???
	is_processing_request = false
