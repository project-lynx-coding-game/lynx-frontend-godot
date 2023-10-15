extends Control

# Called when the node enters the scene tree for the first time.
var agent_container_prefab = preload("res://ui/AgentList/AgentContainer.tscn")


func clear_agents():
	var agent_list_container: VBoxContainer = get_node("AgentPanel/ScrollContainer/AgentListContainer")
	for child in agent_list_container.get_children():
		child.queue_free()  

func handle_agents(agents_response: Dictionary):
	if agents_response == {}:
		return 
		
	self.populate(agents_response["agents"])
	self.add_agent_ratio(agents_response["number_of_agents"], agents_response["agent_max"])
	self.add_agent_cost(agents_response["slot_cost"])
	
func add_agent_ratio(number_of_agent: int, agent_max: int):
	var agent_ratio = "Agent ratio: %s/%s" % [number_of_agent, agent_max]
	get_node("AgentPanel/AgentsRatio").text = agent_ratio

func add_agent_cost(slot_cost: Dictionary):
	var cost_string = "Agent cost: "
	var keys = slot_cost.keys()
	var values = slot_cost.values()
	for i in range(slot_cost.size()):
		cost_string += "%s: %s, " % [keys[i], values[i]]
	
	cost_string = cost_string.trim_suffix(", ")
	get_node("AgentPanel/SlotCost").text = cost_string

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
