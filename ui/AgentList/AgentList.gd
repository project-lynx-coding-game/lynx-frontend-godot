extends Control

# Called when the node enters the scene tree for the first time.
var agent_container_prefab = preload("res://ui/AgentList/AgentContainer.tscn")


func clear_agents():
	var agent_list_container: VBoxContainer = get_node("AgentPanel/ScrollContainer/AgentListContainer")
	for child in agent_list_container.get_children():
		child.queue_free()  


func populate(agents: Array):
	self.clear_agents()
	for agent_data in agents:
		add_agent(agent_data)

func add_agent(agent_data : Dictionary):
	var agent_container_instance = agent_container_prefab.instantiate()
	var agent_list_container: VBoxContainer = get_node("AgentPanel/ScrollContainer/AgentListContainer")
	agent_list_container.add_child(agent_container_instance)
	agent_container_instance.initialize(agent_data)

func _on_agents_button_toggled(button_pressed):
	get_node("../ButtonPress").play()
	get_node("AgentPanel").visible = button_pressed
	get_parent().get_agents_requested.emit()
