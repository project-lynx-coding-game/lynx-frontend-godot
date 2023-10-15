extends Control

@onready var id_of_agent: int = -1
@onready var camera = get_node("/root/Scene/Camera2D")

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var tooltips = get_owner().tooltips
		var objects_on_tile =  Globals.WORLD_UPDATER.objects_container.get_objects_by_position(tooltips.tile_position)
		var agent = objects_on_tile.filter(func(obj): return obj["_type"] == "Agent" and obj["_owner"] == Globals.USER_ID)
		if agent.size() > 0:
			# Get the first agent object (assuming there's only one)
			agent = agent[0]
			self.show_panel(agent._id)
		elif self.panel_is_visible():
			# If no agent is found and the panel is currently visible we hide the panel
			self.hide_panel()

func _ready():
	get_node("AgentPanel").hide()

func show_panel(id_of_agent):
	self.id_of_agent = id_of_agent
	get_parent().get_agent_requested.emit(id_of_agent)

func display(agent: Dictionary):
	get_node("AgentPanel").visible = true
	get_node("AgentPanel/AgentId/AgentIdLabel").text = "Agent {id}".format({"id": str(id_of_agent)})
	get_node("AgentPanel/AgentCode").text = agent["tick"]
	self.set_inventory_text(agent["inventory"])
	self.set_agent_performance(agent["historical_inventory"], agent["lifetime"])
	self.set_agent_information(agent)

func set_agent_performance(hsistorical_inventory: Dictionary, lifetime_seconds: float):
	var inventory_lines = []
	for item in hsistorical_inventory.keys():
		var quantity = hsistorical_inventory[item]
		var items_per_minute = (quantity / lifetime_seconds) * 60.0
		inventory_lines.append("{item}: {quantity} ({items_per_minute} / min)".format({
			"item": item,
			"quantity": str(quantity),
			"items_per_minute": str(items_per_minute)
		}))

	var inventory_text = "\n".join(inventory_lines)
	get_node("AgentPanel/AgentPerformance/Text").text = inventory_text

func set_agent_information(agent_data):
	var time_creation = agent_data["time_creation"]
	var time_death = agent_data["time_death"] if agent_data["time_death"] else "N/A"
	var lifetime = str(agent_data["lifetime"]) + "s"
	get_node("AgentPanel/AgentInformation").text = "Creation Time: %s\nDeath Time: %s\nLifetime: %s" % [time_creation, time_death, lifetime]

func set_inventory_text(inventory: Dictionary):
	var inventory_lines = []
	for item in inventory.keys():
		var quantity = inventory[item]
		inventory_lines.append("{item}: {quantity}".format({
			"item": item,
			"quantity": str(quantity),
		}))

	var inventory_text = "\n".join(inventory_lines)
	get_node("AgentPanel/AgentInventory/Text").text = inventory_text

func panel_is_visible():
	return get_node("AgentPanel").visible

func hide_panel():
	get_node("AgentPanel").visible = false

func _on_follow_button_pressed():
	var object_to_follow =  await Globals.WORLD_UPDATER.objects_container.get_object_by_id(self.id_of_agent)
	if object_to_follow:
		self.camera.object_to_follow = object_to_follow
		self.hide_panel()

func _on_unfollow_button_pressed():
	self.camera.object_to_follow = null
	self.hide_panel()
