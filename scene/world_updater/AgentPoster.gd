extends Node

@onready var add_agent_endpoint_url = "http://127.0.0.1:8555/add_agent"

# create agent, get its id, then send POST HTTP request with id, code, position, owner etc.
