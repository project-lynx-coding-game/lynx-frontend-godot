extends Control

@onready var username_text_edit: TextEdit = get_node("Panel/VBoxContainer/UsernameTextEdit")
@onready var popup_error: PopupPanel = get_node("Panel/PopupError")

func _format_username(username: String) -> String:
	# Remove all white signs from username from the begining and the end of the string
	username = username.strip_edges(true, true)
	# Remove all spaces from username
	username = username.replace(" ", "")
	return username

func _on_login_button_button_up():
	var username = _format_username(username_text_edit.text)
	if username == "":
		popup_error.popup_centered()
		return
		
	Globals.USER_ID = username
	Globals.USER_IS_LOGGED_IN = true
	self.visible = false
