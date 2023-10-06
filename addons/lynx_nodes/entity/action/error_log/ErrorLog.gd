extends LynxAction

var _text: String
var _user_id: String

@onready var _output_console = get_node("/root/Scene/CanvasLayer/UI/AgentCreator/ColorRect/OutputConsole")

func _init():
	self.accepted_attributes = ["text", "user_id"]

func _execute():
	if _user_id == Globals.USER_ID:
		self._output_console.print(self._text, Color.DARK_RED)
