@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("LynxObjectNode", "Node2D", preload("res://addons/lynx_node/lynx_object_node/lynx_object_node.gd"), preload("res://assets/NinjaAdventure/Items/Potion/LifePot.png"))
	add_custom_type("LynxAgentNode", "Node2D", preload("res://addons/lynx_node/lynx_agent_node/lynx_agent_node.gd"), preload("res://assets/NinjaAdventure/Actor/Characters/Villager/SeparateAnim/Special1.png"))

func _exit_tree():
	remove_custom_type("LynxObjectNode")
	remove_custom_type("LynxAgentNode")
