extends Camera2D

@export var move_speed = 12.0
@export var border_margin = 10
@export var smoothness = 10
@export var zoom_speed = 0.1
@export var max_zoom = Vector2(10.0, 10.0)
@export var min_zoom = Vector2(1.0, 1.0)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom = zoom / pow(1 + zoom_speed, 1)
			zoom = clamp(zoom, min_zoom, max_zoom)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom = zoom * pow(1 + zoom_speed, 1)
			zoom = clamp(zoom, min_zoom, max_zoom)

func _process(delta):
	var viewport_rect = get_viewport_rect()
	var camera_pos  = position
	var moved = false
	
	# LEFT EDGE
	if get_viewport().get_mouse_position().x < viewport_rect.position.x + border_margin:
		camera_pos.x = lerp(camera_pos.x, camera_pos.x - move_speed, smoothness * delta)
		moved = true
	
	# RIGHT EDGE
	if get_viewport().get_mouse_position().x > viewport_rect.position.x + viewport_rect.size.x - border_margin:
		camera_pos.x = lerp(camera_pos.x, camera_pos.x + move_speed, smoothness * delta)
		moved = true
	
	# TOP EDGE
	if get_viewport().get_mouse_position().y < viewport_rect.position.y + border_margin:
		camera_pos.y = lerp(camera_pos.y, camera_pos.y - move_speed, smoothness * delta)
		moved = true
	
	# BOTTOM EDGE
	if get_viewport().get_mouse_position().y > viewport_rect.position.y + viewport_rect.size.y - border_margin:
		camera_pos.y = lerp(camera_pos.y, camera_pos.y + move_speed, smoothness * delta)
		moved = true
	
	if moved:
		position = camera_pos
