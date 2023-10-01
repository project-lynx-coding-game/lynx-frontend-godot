@tool
extends LynxAgent

var action_queue: Node
var execute_action_timer: Timer
var speech_bubble: Control
var border: Line2D
var audio_stream_player_2d: AudioStreamPlayer2D

@export var action_speed: float

func _enter_tree():
	_setup_action_queue()
	_setup_execute_action_timer()
	_setup_speech_bubble()
	_setup_audio_stream_player_2d()
