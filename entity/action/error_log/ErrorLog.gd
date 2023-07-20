extends LynxAction

var _text: String
@onready var _output_console = get_node("/root/Scene/CanvasLayer/UI/AgentCreator/ColorRect/OutputConsole")

func _init():
	self.accepted_attributes = ["text"]

func _execute():
	self._output_console.print(self._text, Color.DARK_RED)
