extends Control

func _ready():
	get_node("RankingPanel").hide()

func _on_ranking_button_toggled(button_pressed):
	get_node("RankingPanel").visible = button_pressed
