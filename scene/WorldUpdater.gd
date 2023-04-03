extends Node

@onready var code_endpoint_url = "http://0.0.0.0:8555/"
@onready var http_request = get_node("HTTPRequest")
var current_tick_hash = -1
var json = JSON.new()

func _ready():
	http_request.request_completed.connect(self._http_request_completed)

func _process(delta):
	var error = http_request.request(code_endpoint_url + "?tick_number=" + str(current_tick_hash))
	if error != OK:
		push_error("An error occurred in the update HTTP request.")

func _http_request_completed(result, response_code, headers, body):
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	if response.scene:
		# we have outdated scene, recreate everything
		
		# first we get tiles and do pass through them, setting them on respective positions on tilemap using set_cell()
		# second we iterate through all entities and objects and match them to respective nodes (packed into .tscn), then we instantiate them on correct positions
		# camera should be attached to player, so it gets correct position automatically
		pass
	else:
		# just do deltas, each object has its ID, we put in in node name
		# then we can query each node by id and do stuff (actions)
		pass
