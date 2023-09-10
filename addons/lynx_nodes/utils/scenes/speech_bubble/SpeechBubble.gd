extends Control

func _on_visibility_timer_timeout():
	self.visible= false

func show_text(text: String):
	visible = true
	get_node("RichTextLabel").text = text
	get_node("VisibilityTimer").start(1)

