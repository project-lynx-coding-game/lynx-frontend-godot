extends Camera2D

@export var move_speed = 12.0
@export var border_margin = 20
@export var smoothness = 10
@export var zoom_speed = 0.1
@export var max_zoom = Vector2(10.0, 10.0)
@export var min_zoom = Vector2(1.0, 1.0)
var is_mouse_outside_screen = false
var is_mouse_on_gui = false
var target_position: Vector2 = Vector2()
var is_moving_to_target : bool = false
var object_to_follow: Node2D = null

func move_to_position(target: Vector2):
	target_position = target
	is_moving_to_target = true

func _notification(what):
	if what == NOTIFICATION_WM_MOUSE_EXIT:
		is_mouse_outside_screen = true
	if what == NOTIFICATION_WM_MOUSE_ENTER:
		is_mouse_outside_screen = false

func _input(event):
	if event is InputEventMouseButton and not is_mouse_on_gui:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom = zoom / pow(1 + zoom_speed, 1)
			zoom = clamp(zoom, min_zoom, max_zoom)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom = zoom * pow(1 + zoom_speed, 1)
			zoom = clamp(zoom, min_zoom, max_zoom)
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			self._reset_camera_position(get_viewport_rect())

func _process(delta):
	follow_object(delta)
	handle_target_movement(delta)
	move_camera_at_screen_edge(delta)

func follow_object(delta):
	if self.object_to_follow:
		position = position.lerp(object_to_follow.global_position, smoothness * delta)

func move_camera_at_screen_edge(delta: float):		
	if is_mouse_outside_screen or self.is_mouse_on_gui:
		return
	
	var viewport_rect = get_viewport_rect()
	var camera_pos  = position
		
	var can_move = false
	var mouse_x = get_viewport().get_mouse_position().x
	var mouse_y = get_viewport().get_mouse_position().y
	
	var left_screen_edge = viewport_rect.position.x + border_margin
	var right_screen_edge = viewport_rect.position.x + viewport_rect.size.x - border_margin
	var top_screen_edge = viewport_rect.position.y + border_margin
	var bottom_screen_edge = viewport_rect.position.y + viewport_rect.size.y - border_margin
	
	if mouse_x < left_screen_edge:
		camera_pos.x = lerp(camera_pos.x, camera_pos.x - move_speed, smoothness * delta)
		can_move = true
	
	if mouse_x > right_screen_edge:
		camera_pos.x = lerp(camera_pos.x, camera_pos.x + move_speed, smoothness * delta)
		can_move = true
	
	if mouse_y < top_screen_edge:
		camera_pos.y = lerp(camera_pos.y, camera_pos.y - move_speed, smoothness * delta)
		can_move = true
	
	if mouse_y > bottom_screen_edge:
		camera_pos.y = lerp(camera_pos.y, camera_pos.y + move_speed, smoothness * delta)
		can_move = true
	
	if can_move:
		position = camera_pos

func handle_target_movement(delta: float):
	if is_moving_to_target:
		position = position.lerp(target_position, smoothness * delta)
		is_moving_to_target = position.distance_to(target_position) >= 1.0

func _reset_camera_position(viewport_rect):
	position = Vector2(0,  0)

func _on_ui_disable_camera_movement():
	self.is_mouse_on_gui = true

func _on_ui_enable_camera_movement():
	self.is_mouse_on_gui = false
