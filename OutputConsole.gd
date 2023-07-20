extends RichTextLabel


func _ready():
	self.text = ""

func print(text: String, color: Color = Color.WHITE):
	push_color(color)
	append_text("[b]" + text + "[/b]\n")
	pop()
