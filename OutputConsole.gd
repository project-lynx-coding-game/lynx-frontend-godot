extends RichTextLabel


func _ready():
	self.text = ""

func print(text: String, color: Color = Color(1, 1, 1)):
	push_color(color)
	append_text("[b]" + text + "[/b]\n")
	pop()
