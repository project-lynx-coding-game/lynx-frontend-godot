extends Node

@onready var post_agent_http_request = get_node("DeleteAgentHTTPRequest")
@onready var camera = get_node("/root/Scene/Camera2D")

func delete_agent(agent_id):
	if post_agent_http_request.get_http_client_status() not in Globals.BUSY_HTTP_STATUSES:
		var url = "%sdelete_object/%s/%s" % [Globals.SERVER_ADDRESS,str(Globals.USER_ID), str(agent_id)]
		var result = post_agent_http_request.request(
			url,
			[], 
			HTTPClient.METHOD_DELETE
		)
		if result != OK:
			push_error("[ERROR] Could not DELETE Agent: " + str(result))

func _on_ui_delete_agent_requested(agent_id: int):
	var current_followed_object = camera.object_to_follow
	var object = await Globals.WORLD_UPDATER.objects_container.get_object_by_id(agent_id)
	if object == null:
		return
		
	if current_followed_object and current_followed_object._id == agent_id:
		camera.object_to_follow = null
		
	delete_agent(agent_id)

