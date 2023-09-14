extends Node


@onready var get_ranking_http_request = get_node("GetRankingHTTPRequest")
@onready var ranking = get_node("/root/Scene/CanvasLayer/UI/Ranking")
var json = JSON.new()

func get_ranking():
	if get_ranking_http_request.get_http_client_status() not in Globals.BUSY_HTTP_STATUSES:
		var url = Globals.SERVER_ADDRESS + "get_ranking"
		var result = get_ranking_http_request.request(
			url,
			[], 
			HTTPClient.METHOD_GET
		)
		if result != OK:
			push_error("[ERROR] Could not DELETE Agent: " + str(result))

func _on_get_ranking_http_request_request_completed(result, response_code, headers, body):
	var ranking = []
	if response_code == 200:
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		ranking = response["ranking"]
	
	self.ranking.populate_ranking(ranking)	

func _on_ui_get_ranking_requested():
	self.get_ranking()
