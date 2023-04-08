extends Node2D

@onready var tick_endpoint_url = "http://127.0.0.1:8555/tick"
@export var code = ""

func _process(delta):
	# send tick_endpoint_url POST request
	# var error = http_request.request(tick_endpoint_url, ["Content-Type: application/json"], HTTPClient.METHOD_POST)
	# if error != OK:
	# 	push_error("An error occurred in the HTTP request.")
#	if code != "":
#		print(code)
	pass
