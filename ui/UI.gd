extends Control

signal create_agent_requested(position: Vector2, code: String)
signal post_populate_map_requested()
signal enable_camera_movement()
signal disable_camera_movement()
signal delete_agent_requested(agent_id: int)
signal get_ranking_requested()

@onready var code_editor = get_node("AgentCreator/CodeEditor")
@onready var x_input = get_node("AgentCreator/XInput")
@onready var y_input = get_node("AgentCreator/YInput")
@onready var tooltips = get_node("Tooltips")
@onready var agent_options = get_node("AgentOptions")
@onready var audio_effect = get_node("ButtonPress")

func _on_create_agent_button_up():
	audio_effect.play()
	create_agent_requested.emit(Vector2(float(x_input.text), float(y_input.text)), code_editor.text)

func _on_populate_button_up():
	audio_effect.play()
	post_populate_map_requested.emit()

func _on_mouse_entered():
	self.disable_camera_movement.emit()

func _on_mouse_exited():
	self.enable_camera_movement.emit()
	
func _on_delete_agent_button_up():
	audio_effect.play()
	var id_of_agent_to_delete = int(self.agent_options.id_of_agent_to_delete)
	self.delete_agent_requested.emit(id_of_agent_to_delete)
	self.agent_options.hide_panel()

func _on_ranking_button_button_up():
	audio_effect.play()

func _on_settings_button_button_up():
	audio_effect.play()

func _on_agent_creator_toggle_button_up():
	audio_effect.play() 
