extends Control

signal create_agent_requested(position: Vector2, code: String)
signal post_populate_map_requested()
signal enable_camera_movement()
signal disable_camera_movement()

@onready var code_editor = get_node("AgentCreator/CodeEditor")
@onready var x_input = get_node("AgentCreator/XInput")
@onready var y_input = get_node("AgentCreator/YInput")
@onready var tooltips = get_node("Tooltips")

func _on_create_agent_button_up():
	create_agent_requested.emit(Vector2(float(x_input.text), float(y_input.text)), code_editor.text)

func _on_populate_button_up():
	post_populate_map_requested.emit()

func _on_mouse_entered():
	self.disable_camera_movement.emit()

func _on_mouse_exited():
	self.enable_camera_movement.emit()
