extends Node

@onready var get_state_http_request = get_node("GetStateHTTPRequest")
@onready var scene_recreator = get_node("SceneRecreator")
@onready var deltas_applier = get_node("DeltasApplier")
@onready var scene_wiper = get_node("SceneWiper")

var json = JSON.new()
var current_tick_hash = -1

# send get state requests every timer timeout (1s)
func _on_get_state_timer_timeout():
	if get_state_http_request.get_http_client_status() != HTTPClient.STATUS_CONNECTING:
		var error = get_state_http_request.request(Globals.SERVER_ADDRESS + "?tick_number=" + str(current_tick_hash))
		if error != OK:
			push_error("An error occurred in the get state HTTP request.")

func _on_get_state_http_request_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		if "scene" in response.keys():
			json.parse(response["scene"])
			scene_wiper.wipe() # wipe the whole scene
			scene_recreator.recreate_scene(json.get_data()) # we have outdated scene, recreate everything
			current_tick_hash = response["tick_number"]
		elif "deltas" in response.keys():
			deltas_applier.apply_deltas(response["deltas"]) # just do deltas
			current_tick_hash = response["tick_number"]
