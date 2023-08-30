extends LynxAction

var _text: String
var _user_id: String

@onready var _output_console = get_node("/root/Scene/CanvasLayer/UI/AgentCreator/ColorRect/OutputConsole")
@onready var _audio_effect = load("res://assets/Music/error_message.wav")

func _init():
	self.accepted_attributes = ["text", "user_id"]

func _execute():
	if _user_id == Globals.USER_ID:
		self._output_console.print(self._text, Color.DARK_RED)
		self.play_audio_global_effect(self._audio_effect)
