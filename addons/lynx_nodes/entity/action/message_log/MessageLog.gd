extends LynxAction

var _object_id = int()
var _text = String()

func _init():
	self.accepted_attributes = ["object_id", "text"]
	
func _execute():
	var object = get_parent().object
	var speech_bubble = object.speech_bubble
	
	speech_bubble.show_text(_text)
