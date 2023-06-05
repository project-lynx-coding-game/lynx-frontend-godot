extends Camera2D

@export var move_speed = 12.0
@export var border_margin = 200
@export var smoothness = 10
@export var zoom_speed = 0.1
@export var max_zoom = Vector2(10.0, 10.0)
@export var min_zoom = Vector2(1.0, 1.0)
var mouse_exit = false

func _notification(what):
	if what == NOTIFICATION_WM_MOUSE_EXIT:
		mouse_exit = true
	if what == NOTIFICATION_WM_MOUSE_ENTER:
		mouse_exit = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom = zoom / pow(1 + zoom_speed, 1)
			zoom = clamp(zoom, min_zoom, max_zoom)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom = zoom * pow(1 + zoom_speed, 1)
			zoom = clamp(zoom, min_zoom, max_zoom)
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			self._reset_camera_position(get_viewport_rect())

func _process(delta):
	if mouse_exit:
		return
	
	var viewport_rect = get_viewport_rect()
	var camera_pos  = position
		
	var can_move = false
	var x_mouse_position = get_viewport().get_mouse_position().x
	var y_mouse_position = get_viewport().get_mouse_position().y
	
	# LEFT EDGE
	if x_mouse_position < viewport_rect.position.x + border_margin:
		camera_pos.x = lerp(camera_pos.x, camera_pos.x - move_speed, smoothness * delta)
		can_move = true
	
	# RIGHT EDGE
	if x_mouse_position > viewport_rect.position.x + viewport_rect.size.x - border_margin:
		camera_pos.x = lerp(camera_pos.x, camera_pos.x + move_speed, smoothness * delta)
		can_move = true
	
	# TOP EDGE
	if y_mouse_position < viewport_rect.position.y + border_margin:
		camera_pos.y = lerp(camera_pos.y, camera_pos.y - move_speed, smoothness * delta)
		can_move = true
	
	# BOTTOM EDGE
	if y_mouse_position > viewport_rect.position.y + viewport_rect.size.y - border_margin:
		camera_pos.y = lerp(camera_pos.y, camera_pos.y + move_speed, smoothness * delta)
		can_move = true
	
	if can_move:
		position = camera_pos

func _reset_camera_position(viewport_rect):
	position = Vector2(0,  0)
