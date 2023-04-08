extends Node

@export var get_state_endpoint_url = "http://0.0.0.0:8555/"

@onready var get_state_http_request = get_node("GetStateHTTPRequest")
@onready var scene_recreator = get_node("SceneRecreator")
@onready var deltas_applier = get_node("DeltasApplier")

var json = JSON.new()
var current_tick_hash = -1

# send get state requests every timer timeout (1s)
func _on_get_state_timer_timeout():
	if get_state_http_request.get_http_client_status() != HTTPClient.STATUS_CONNECTING:
		var error = get_state_http_request.request(get_state_endpoint_url + "?tick_number=" + str(current_tick_hash))
		if error != OK:
			push_error("An error occurred in the get state HTTP request.")

func _on_get_state_http_request_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		if response.scene:
			scene_recreator.recreate_scene(response.scene) # we have outdated scene, recreate everything
		else:
			deltas_applier.apply_deltas(response.deltas) # just do deltas
		current_tick_hash = response.tick_number
