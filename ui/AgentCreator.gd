extends Control

func _ready():
	self.get_node("CreateAgent").hide()
	self.get_node("XInput").hide()
	self.get_node("YInput").hide()
	self.get_node("CodeEditor").hide()
	self.get_node("Populate").hide()
	self.get_node("ColorRect").hide()

func _on_agent_creator_toggle_toggled(button_pressed):
	self.get_node("CreateAgent").visible = button_pressed
	self.get_node("XInput").visible = button_pressed
	self.get_node("YInput").visible = button_pressed
	self.get_node("CodeEditor").visible = button_pressed
	self.get_node("Populate").visible = button_pressed
	self.get_node("ColorRect").visible = button_pressed


func _on_agent_creator_toggle_button_down():
		get_node("../button_audio_effect").play()
