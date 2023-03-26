extends Node

@onready var http_request = get_node("HTTPRequest")
@onready var code_endpoint_url = ""

func _on_button_button_up():
	var code = get_node("../CodeEditor").text
	var error = http_request.request(code_endpoint_url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, code)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
