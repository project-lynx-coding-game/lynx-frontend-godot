extends Node

func _on_button_button_up():
	var code = get_node("/root/Scene/CanvasLayer/UI/AgentCreator/CodeEditor").text
	get_node("/root/Scene/WorldUpdater/AgentCreator").create_agent(code)
