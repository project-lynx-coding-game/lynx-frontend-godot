extends LynxAction

var _object_id = int()
var _text = String()

func _init():
	self.accepted_attributes = ["object_id", "text"]
	
func _execute():
	var object = get_parent().object
	if object.has_node("SpeechBubble"):
		var speech_bubble = object.get_node("SpeechBubble")
		
		# show speech bubble with the text inside
		speech_bubble.visible = true
		speech_bubble.get_node("RichTextLabel").text = str(self._text)
		
		# count down to when it is stopped being shown
		speech_bubble.get_node("VisibilityTimer").start(1)
