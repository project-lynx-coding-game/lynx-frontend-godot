extends Control

@onready var ranking_list: ItemList = get_node("RankingPanel/RankingList")

func _ready():
	get_node("RankingPanel").hide()
	
func populate_ranking(ranking: Array):
	self.ranking_list.clear()
	for player_rank in ranking:
		var player_name = player_rank[0]
		var player_score = str(player_rank[1])
		self.ranking_list.add_item(player_name + ": " + player_score)
	

func _on_ranking_button_toggled(button_pressed):
	get_node("RankingPanel").visible = button_pressed
	var response = get_parent().get_ranking_requested.emit()
