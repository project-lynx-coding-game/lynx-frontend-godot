@tool
extends EditorPlugin

func _enter_tree():
	var lynx_logo = preload("res://assets/Lynx/lynx-logo-small.png")
	add_custom_type("LynxObjectNode", "Node2D", preload("res://addons/lynx_nodes/nodes/LynxObjectNode.gd"), lynx_logo)
	add_custom_type("LynxPlayerObjectNode", "Node2D", preload("res://addons/lynx_nodes/nodes/LynxPlayerObjectNode.gd"), lynx_logo)
	add_custom_type("LynxAgentNode", "Node2D", preload("res://addons/lynx_nodes/nodes/LynxAgentNode.gd"), lynx_logo)

func _exit_tree():
	remove_custom_type("LynxObjectNode")
	remove_custom_type("LynxPlayerObjectNode")
	remove_custom_type("LynxAgentNode")
