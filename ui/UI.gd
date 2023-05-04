extends Control

signal create_agent_requested(position: Vector2, code: String)

@onready var code_editor = get_node("AgentCreator/CodeEditor")
@onready var x_input = get_node("AgentCreator/XInput")
@onready var y_input = get_node("AgentCreator/YInput")

func _on_create_agent_button_up():
	create_agent_requested.emit(Vector2(float(x_input.text), float(y_input.text)), code_editor.text)
