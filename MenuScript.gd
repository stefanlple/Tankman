extends Node2D

var roundC = 3

func _on_button_pressed():
	get_tree().change_scene_to_file("res://ingame.tscn")


func _on_option_button_item_selected(index):
	get_node("/root/GameManger").SetRound(1 + 2*index)

