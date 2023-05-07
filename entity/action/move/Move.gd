extends LynxAction

var _object_id = int()
var _direction = Vector2()

func _init():
	self.accepted_attributes = ["object_id", "direction"]

func _execute():
	# TODO make it cleaner its a big hack as for now
	var tween = get_tree().create_tween()
	
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
		
	var _target_position = object._position + self._direction
	var target_position = Vector2(Vector2i(object._position + self._direction) * Globals.TILE_SIZE)
	target_position = target_position.snapped(Globals.TILE_SIZE)
	target_position += Vector2(Globals.TILE_SIZE / 2)
	tween.tween_property(object, "position", target_position, 0.4).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	
	if object.has_node("AnimatedSprite2D"):
		object.get_node("AnimatedSprite2D").stop()
	
	object._position = _target_position
#	object.set_attribute("_position", _target_position) # we want to avoid this, as this was the old way TODO refactor set_attribute()
