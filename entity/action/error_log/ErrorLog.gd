extends LynxAction

var _text: String
signal append_message_to_console(message: String)

func _init():
	self.accepted_attributes = ["text"]

func _execute():
	get_parent().get_parent().print_tree()
	self.append_message_to_console.emit(self._text)
