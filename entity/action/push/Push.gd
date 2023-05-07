extends LynxAction

var _object_id = int()
var _direction = Vector2()
var _pushed_object_ids: Array[int] = []

func _init():
	self.accepted_attributes = ["object_id", "direction", "pushed_object_ids"]
	
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
	
	# TODO: change to relative paths
	var objects_container = get_node("/root/Scene/WorldUpdater").objects_container
	var entity_mapper = get_node("/root/Scene/WorldUpdater/StateGetter/EntityDeserializer/EntityMapper")
	
	for pushed_object_id in _pushed_object_ids:
		var move = entity_mapper.map_entity_type_to_node("Move").instantiate()
		move._object_id = pushed_object_id
		move._direction = self._direction
		
		var pushed_object = objects_container.get_node(str(pushed_object_id))
		pushed_object.get_node("ActionQueue").add_child(move)
