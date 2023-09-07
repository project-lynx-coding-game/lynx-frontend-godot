@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("LynxObjectNode", "Node2D", preload("res://addons/lynx_nodes/nodes/LynxObjectNode.gd"), preload("res://assets/NinjaAdventure/Items/Potion/LifePot.png"))
	add_custom_type("LynxPlayerObjectNode", "Node2D", preload("res://addons/lynx_nodes/nodes/LynxPlayerObjectNode.gd"), preload("res://assets/NinjaAdventure/Items/Potion/WaterPot.png"))
	add_custom_type("LynxAgentNode", "Node2D", preload("res://addons/lynx_nodes/nodes/LynxAgentNode.gd"), preload("res://assets/NinjaAdventure/Actor/Characters/Villager/SeparateAnim/Special1.png"))

func _exit_tree():
	remove_custom_type("LynxObjectNode")
	remove_custom_type("LynxPlayerObjectNode")
	remove_custom_type("LynxAgentNode")
