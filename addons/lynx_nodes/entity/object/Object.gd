extends LynxEntity
class_name LynxObject

var _position = Vector2()
var _id = int()
var _owner = ""

@onready var animated_sprite = get_node("AnimatedSprite2D")

func _init():
	self.accepted_attributes = ["position", "id", "owner"]

func _post_populate():
	self.set_name(str(self._id))
	self.position = Vector2i(self._position) * Globals.TILE_SIZE
	self.position = self.position.snapped(Globals.TILE_SIZE)
	self.position += Vector2(Globals.TILE_SIZE / 2)

func start_animation(animation_name: String):
	animated_sprite.play(animation_name)
	
func end_animation():
	animated_sprite.frame = 0
	animated_sprite.stop()

# accepts position in tile coordinates
func move(_target_position: Vector2i, duration: float):
	var tween = get_tree().create_tween()
	
	var target_position = Vector2(_target_position * Globals.TILE_SIZE)
	target_position = target_position.snapped(Globals.TILE_SIZE)
	target_position += Vector2(Globals.TILE_SIZE / 2)
	
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_LINEAR)
	
	await tween.finished
	
	self._position = _target_position
	
func _setup_action_queue():
	var ActionQueue = load('res://addons/lynx_nodes/utils/scenes/action_queue.tscn')
	self.action_queue = ActionQueue.instantiate()
	self.add_child(self.action_queue)
	
func _setup_execute_action_timer():
	var ExecuteActionTimer = load('res://addons/lynx_nodes/utils/scenes/execute_action_timer.tscn')
	self.execute_action_timer = ExecuteActionTimer.instantiate()
	self.action_speed = self.execute_action_timer.wait_time
	self.add_child(self.execute_action_timer)
	
	self.execute_action_timer.connect("timeout", self.action_queue._on_execute_action_timer_timeout)
	self.execute_action_timer.start()
	
func _setup_speech_bubble():
	var SpeechBubble = load('res://addons/lynx_nodes/utils/scenes/speech_bubble.tscn')
	self.speech_bubble = SpeechBubble.instantiate()
	self.speech_bubble.visible = false
	self.add_child(self.speech_bubble)
	
func _get_configuration_warnings() -> PackedStringArray:
	for child in get_children():
		if child is AnimatedSprite2D:
			return []
	
	return ["Add AnimatedSprite2D as a child."]
