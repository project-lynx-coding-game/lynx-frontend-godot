extends LynxAction

var _object_id = int()
var _direction = Vector2()

func _init():
	self.accepted_attributes = ["object_id", "direction"]
	
func _execute():
	# TODO refactor when `Move` is refactored
	var tween = get_tree().create_tween()
	
	var agent = get_parent().agent
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
	agent.get_node("AnimatedSprite2D").set_animation(animation)
	agent.get_node("AnimatedSprite2D").play()
	agent.get_node("AnimatedSprite2D").set_frame(0)
	
	# TODO: get pushable objects at self._position + self._direction from objects_container and move them using `Move`
