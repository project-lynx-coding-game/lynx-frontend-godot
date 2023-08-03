extends LynxAction

var _object_id = int()
var _text = String()

func _init():
	self.accepted_attributes = ["object_id", "text"]
	
func _execute():
	var object = get_parent().object
	if object.speech_bubble:
		# show speech bubble with the text inside
		object.speech_bubble.visible = true
		object.speech_bubble.get_node("RichTextLabel").text = str(self._text)
		
		# count down to when it is stopped being shown
		object.speech_bubble.get_node("VisibilityTimer").start(1)
