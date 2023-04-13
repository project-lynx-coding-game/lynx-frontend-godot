extends Node

@onready var code_editor = get_node("../AgentCreator/CodeEditor")
@onready var scene = get_node("/root/Scene/WorldUpdater/AgentCreator")

func _on_button_button_up():
	var code = code_editor.text
	scene.create_agent(code)
