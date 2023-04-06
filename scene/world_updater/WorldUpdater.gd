extends Node

@export var tilemap: TileMap

#@onready var agent_scene = preload("res://objects/agent.tscn")

#@onready var add_object_endpoint_url = "http://0.0.0.0:8555/add_object"

func _ready():
	pass

#func create_agent(code):
#	var new_agent = agent_scene.instantiate()
#	new_agent.code = code
#	add_child(new_agent)
#	var error = http_request.request(add_object_endpoint_url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, code)
#	if error != OK:
#		push_error("An error occurred in the HTTP request.")
