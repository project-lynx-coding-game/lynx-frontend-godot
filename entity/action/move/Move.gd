extends LynxAction

var _object_id = int()
var _direction = Vector2()

func _init():
	self.accepted_attributes = ["object_id", "direction"]

func _execute():
	var object = get_parent().object
	if object.has_node("AnimatedSprite2D"):
		var vect_anim = {
			Vector2(1,0) : "walk_right",
			Vector2(-1,0) : "walk_left",
			Vector2(0,1) : "walk_down",
			Vector2(0,-1) : "walk_up"
		}
		var animation = ""
		if vect_anim.has(self._direction):
			animation = vect_anim[self._direction]
		else:
			animation = "walk_right"
		object.get_node("AnimatedSprite2D").set_animation(animation)
		object.get_node("AnimatedSprite2D").play()
		object.get_node("AnimatedSprite2D").set_frame(0)
		
	
	await object.move(Vector2i(object._position) + Vector2i(self._direction), Globals.DEFAULT_ACTION_SPEED - 0.1 / Globals.ACTION_SPEED_MULTIPLIER)
	
	if object.has_node("AnimatedSprite2D"):
		object.get_node("AnimatedSprite2D").stop()
