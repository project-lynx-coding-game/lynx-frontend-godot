extends LynxAction

var _object_id = int()
var _direction = Vector2()

func _init():
	self.accepted_attributes = ["object_id", "direction"]
	
func _execute():
	var object = get_parent().object
	if object.has_node("AnimatedSprite2D"):
		var vect_anim = {
			Vector2(1,0) : "push_right",
			Vector2(-1,0) : "push_left",
			Vector2(0,1) : "push_down",
			Vector2(0,-1) : "push_up"
		}
		var animation = ""
		if vect_anim.has(self._direction):
			animation = vect_anim[self._direction]
		else:
			animation = "push_right"
		object.get_node("AnimatedSprite2D").set_animation(animation)
		object.get_node("AnimatedSprite2D").play()
		# TODO: animation should play for 0.5 seconds, now it plays for 0 seconds
		object.get_node("AnimatedSprite2D").stop()
