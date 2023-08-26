extends Control

@onready var agent_id_to_delete: int = -1

func _ready():
	get_node("AgentOptionsPanel").hide()

func on_agent_clicked(agent_id_to_delete):
	self.agent_id_to_delete = agent_id_to_delete
	get_node("AgentOptionsPanel").visible = true
	get_node("AgentOptionsPanel/VBoxContainer/AgentIdLabel").text = "Agent {id}".format({"id": str(agent_id_to_delete)})

func panel_is_visible():
	return get_node("AgentOptionsPanel").visible
	
func hide_panel():
	get_node("AgentOptionsPanel").visible = false
