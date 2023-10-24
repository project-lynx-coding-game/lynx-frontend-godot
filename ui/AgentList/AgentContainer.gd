extends VBoxContainer

@onready var agent_row: HBoxContainer = get_node("AgentRow")
@onready var agent_id_label: Label = get_node("AgentRow/AgentID")
@onready var agent_status = get_node("AgentRow/AgentStatus")
@onready var set_camera_on_agent_button = get_node("AgentRow/SetCameraButton")
@onready var delete_agent_button = get_node("AgentRow/DeleteAgentButton")
@onready var remove_from_list_button = get_node("AgentRow/RemoveFromListButton")
@onready var agent_info_container = get_node("AgentInfoContainer")
@onready var agent_information_label = get_node("AgentInfoContainer/AgentInformation")
@onready var ui = get_node("/root/Scene/CanvasLayer/UI") 
@onready var camera = get_node("/root/Scene/Camera2D")
@onready var delete_agent_from_list_http_request = get_node("AgentRow/DeleteAgentFromListHTTPRequest")

var agent_data: Dictionary = Dictionary()

func _process(delta):
	if agent_data["is_alive"]:
		return
	
	self.remove_from_list_button.visible = true
	self.set_camera_on_agent_button.visible = false
	self.delete_agent_button.visible = false
		
func initialize(data: Dictionary):
	agent_data = data
	agent_info_container.visible = false
	update_agent_labels()

func update_agent_labels():
	agent_id_label.text = str(agent_data["id"])
	agent_status.text = "Alive" if agent_data["is_alive"] else "Dead"
	self.set_agent_information_label()
	
func set_agent_information_label():
	var time_creation = agent_data["time_creation"]
	var time_death = agent_data["time_death"] if agent_data["time_death"] else "N/A"
	var lifetime = str(agent_data["lifetime"]) + "s"
	agent_information_label.text = "Creation Time: %s\nDeath Time: %s\nLifetime: %s" % [time_creation, time_death, lifetime]

func _on_delete_agent_button_pressed():
	ui.delete_agent_requested.emit(agent_data["id"])
	ui.get_agents_requested.emit()

func _on_show_details_pressed():
	agent_info_container.visible = !agent_info_container.visible

func _on_set_camera_button_pressed():
	var object = await Globals.WORLD_UPDATER.objects_container.get_object_by_id(agent_data["id"])
	if object == null:
		return
		
	camera.move_to_position(object.position)

func _on_remove_from_list_button_pressed():
	if delete_agent_from_list_http_request.get_http_client_status() not in Globals.BUSY_HTTP_STATUSES:
		var url = "%splayer-agents/%s/%s" % [Globals.SERVER_ADDRESS,str(Globals.USER_ID), str(agent_data["id"])]
		var result = delete_agent_from_list_http_request.request(
			url,
			[], 
			HTTPClient.METHOD_DELETE
		)
		if result != OK:
			push_error("[ERROR] Failed to send DELETE request")
			return 
			
		ui.get_agents_requested.emit()
