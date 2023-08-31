extends Control

@onready var id_of_agent_to_delete: int = -1


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var tooltips = get_owner().tooltips
		var objects_on_tile =  Globals.WORLD_UPDATER.objects_container.get_objects_by_position(tooltips.tile_position)
		var agent = objects_on_tile.filter(func(obj): return obj["_type"] == "Agent")
		if agent.size() > 0:
			# Get the first agent object (assuming there's only one)
			agent = agent[0]
			self.show_panel(agent._id)
		elif self.panel_is_visible():
			# If no agent is found and the panel is currently visible we hide the panel
			self.hide_panel()
		
func _ready():
	get_node("AgentOptionsPanel").hide()

func show_panel(id_of_agent_to_delete):
	self.id_of_agent_to_delete = id_of_agent_to_delete
	get_node("AgentOptionsPanel").visible = true
	get_node("AgentOptionsPanel/VBoxContainer/AgentIdLabel").text = "Agent {id}".format({"id": str(id_of_agent_to_delete)})

func panel_is_visible():
	return get_node("AgentOptionsPanel").visible
	
func hide_panel():
	get_node("AgentOptionsPanel").visible = false
