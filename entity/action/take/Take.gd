extends LynxAction

var _object_id = int()
var _position = Vector2()

func _init():
	self.accepted_attributes = ["object_id", "position"]

func _execute():
	var vect_anim = {
		Vector2(1,0) : "take_right",
		Vector2(-1,0) : "take_left",
		Vector2(0,1) : "take_down",
		Vector2(0,-1) : "take_up"
	}
	
	var animation = ""
	var object = get_parent().object
	var direction = self._position - Vector2(object._position)
	if vect_anim.has(direction):
		animation = vect_anim[direction]
	else:
		animation = "take_down"
	object.get_node("AnimatedSprite2D").set_animation(animation)
	object.get_node("AnimatedSprite2D").play()
	object.get_node("AnimatedSprite2D").set_frame(0)
