extends Control

@onready var tile_data_container: VBoxContainer = get_node("TileData")
@onready var tile_position_label: Label = tile_data_container.get_node("Position")
@onready var tile_type_label: Label = tile_data_container.get_node("Type")
@onready var tile_objects_container: VBoxContainer = tile_data_container.get_node("Objects")

@onready var tile_position: Vector2i = Vector2i.ZERO
@onready var tile_type: String = ""
@onready var tile_objects: Dictionary = {}

func _set_tile_data_container_position():
	var mouse_position = get_global_mouse_position()
	var visibility_offset = Vector2(15, -5)
	tile_data_container.set_position(mouse_position + visibility_offset)

func _set_tile_position_label_text():
	tile_position_label.text = "Position: " + str(tile_position)
	
func _set_tile_type_label_text():
	tile_type_label.text = tile_type
	
func _wipe_tile_objects_container():
	for tile_object in tile_objects_container.get_children():
		tile_objects_container.remove_child(tile_object)
		tile_object.queue_free()
		
func _create_tile_object_label(tile_object):
	var tile_object_label = Label.new()
	tile_objects_container.add_child(tile_object_label)
	return tile_object_label
	
func _set_tile_object_label_text(tile_object, tile_object_label):
	var object_count = str(tile_objects[tile_object])
	tile_object_label.text += tile_object
	if object_count == "1":
		tile_object_label.text += " x" + object_count
	
func _add_tile_objects_to_tile_objects_container():
	_wipe_tile_objects_container()
	for tile_object in tile_objects.keys():
		var tile_object_label = _create_tile_object_label(tile_object)
		_set_tile_object_label_text(tile_object, tile_object_label)

func _process(delta):
	_set_tile_data_container_position()
	_set_tile_position_label_text()
	_set_tile_type_label_text()
	_add_tile_objects_to_tile_objects_container()
