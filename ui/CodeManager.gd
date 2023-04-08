extends Node

func _on_button_button_up():
	var code = get_node("../CodeEditor").text
	get_node("/root/Scene/WorldUpdater/AgentPoster").post_agent(code)
