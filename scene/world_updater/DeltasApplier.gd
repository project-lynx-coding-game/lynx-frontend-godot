extends Node

@onready var tilemap = get_parent().get_parent().tilemap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func apply_deltas(deltas_data):
	# each object has its ID, we put in in node name
	# then we can query each node by id and do stuff (actions)
	pass
