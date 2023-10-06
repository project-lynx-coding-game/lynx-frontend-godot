extends Control

func _ready():
	get_node("SettingsPanel").hide()

func _on_settings_button_toggled(button_pressed):
	get_node("SettingsPanel").visible = button_pressed
	get_node("SettingsPanel/VBoxContainer/AddressTextEdit").text = Globals.SERVER_ADDRESS

func _on_save_button_button_up():
	Globals.SERVER_ADDRESS = get_node("SettingsPanel/VBoxContainer/AddressTextEdit").text
	get_node("SettingsButton").button_pressed = false
