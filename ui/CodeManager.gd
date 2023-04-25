extends Node

@onready var code_editor = get_node("../AgentCreator/CodeEditor")
@onready var x_input = get_node("../AgentCreator/XInput")
@onready var y_input = get_node("../AgentCreator/YInput")
@onready var agent_creator = get_node("/root/Scene/WorldUpdater/AgentCreator")

func _on_button_button_up():
	var code = code_editor.text
	var position = Vector2(float(x_input.text), float(y_input.text))
	agent_creator.create_agent(code, position)
