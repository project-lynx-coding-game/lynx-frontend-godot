extends Node

@onready var get_state_http_request = get_node("GetStateHTTPRequest")
@onready var scene_recreator = get_node("SceneRecreator")
@onready var deltas_applier = get_node("DeltasApplier")
@onready var scene_wiper = get_node("SceneWiper")

var json = JSON.new()
var current_tick_number: int = -1
const ACCEPTABLE_DELAY : float = 0.01
var delays: Array = []
var last_delay: float = 0.0

func _calculate_average_delay_time():
	var sum := 0.0
	if delays.size() == 0:
		return 0.0
	return delays.reduce(func(accum, number): return accum + number) / delays.size()

func _normalize_second(lower_time, higher_time):
	var difference_in_ms = float(int(higher_time - lower_time) % 1000) / 1000
	var difference_in_ms_normalized = difference_in_ms
	if difference_in_ms_normalized >= Config.THRESHHOLD_of_SECOND_ROUNDING:
		difference_in_ms_normalized = difference_in_ms - Config.DEFAULT_GET_STATE_WAIT_TIME
	return difference_in_ms_normalized

func _speed_up_actions():
	for object in Globals.WORLD_UPDATER.objects_container.get_children():
		object.get_node("ExecuteActionTimer").wait_time = Globals.DEFAULT_ACTION_SPEED / Globals.ACTION_SPEED_MULTIPLIER
		object.get_node("AnimatedSprite2D").speed_scale = Globals.ACTION_SPEED_MULTIPLIER

func _handle_lag(old_tick_number, new_tick_number):
	var old_action_speed_multiplier = Globals.ACTION_SPEED_MULTIPLIER
	Globals.ACTION_SPEED_MULTIPLIER = 1 if new_tick_number <= old_tick_number else new_tick_number - old_tick_number
	
	if old_action_speed_multiplier != Globals.ACTION_SPEED_MULTIPLIER:
		_speed_up_actions()
		
func _update_state(response):
	if "scene" in response.keys():
		json.parse(response["scene"])
		scene_wiper.wipe()
		scene_recreator.recreate_scene(json.get_data())
	elif "deltas" in response.keys():
		if delays.size() == Config.DELAYS_LIST_SIZE:
			delays.pop_front()
		var difference_in_ms_normalized = _normalize_second(response["send_time_ms"], Time.get_unix_time_from_system() * 1000)
		delays.push_back(difference_in_ms_normalized + last_delay)
		last_delay = _calculate_average_delay_time()
		deltas_applier.apply_deltas(response["deltas"])
	_handle_lag(current_tick_number, response["tick_number"])
	
	current_tick_number = response["tick_number"]

func _on_get_state_http_request_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		_update_state(response)
		
		


# send get state requests every timer timeout (1s)
func _on_get_state_timer_timeout():
	if get_state_http_request.get_http_client_status() not in Globals.BUSY_HTTP_STATUSES:
		var result = get_state_http_request.request(Globals.SERVER_ADDRESS + "?tick_number=" + str(current_tick_number))
		if result != OK:
			push_error("[ERROR] Could not GET state: " + str(result))
		
		var delay_time_normalized = _normalize_second(0, Time.get_unix_time_from_system() * 1000)
		if current_tick_number % Config.TICKS_WITHOUT_SYNCHRONIZATION == 0:
			get_node("GetStateTimer").wait_time = Config.DEFAULT_GET_STATE_WAIT_TIME - delay_time_normalized - _calculate_average_delay_time()
		else:
			get_node("GetStateTimer").wait_time = Config.DEFAULT_GET_STATE_WAIT_TIME 
