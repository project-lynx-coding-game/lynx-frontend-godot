extends Control

func _ready():
	self.hide_agent_creator()

func set_visibility(is_visible: bool):
	self.get_node("CreateAgent").visible = is_visible
	self.get_node("XInput").visible = is_visible
	self.get_node("YInput").visible = is_visible
	self.get_node("CodeEditor").visible = is_visible
	self.get_node("Generate").visible = is_visible
	self.get_node("GenerateDebug").visible = is_visible
	self.get_node("ColorRect").visible = is_visible

func hide_agent_creator():
	get_node("../AgentCreatorToggle").set_pressed(false)
	self.get_node("CreateAgent").hide()
	self.get_node("XInput").hide()
	self.get_node("YInput").hide()
	self.get_node("CodeEditor").hide()
	self.get_node("Generate").hide()
	self.get_node("GenerateDebug").hide()
	self.get_node("ColorRect").hide()


func _on_agent_creator_toggle_toggled(button_pressed):
	self.set_visibility(button_pressed)
