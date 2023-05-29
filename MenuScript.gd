extends Node2D

var roundC = 3

@onready var GameManger = get_node("/root/GameManger");

func _on_button_pressed():
	get_tree().change_scene_to_file("res://ingame.tscn")


func _on_option_button_item_selected(index):
	GameManger.SetRound(1 + 2*index)



func _on_check_box_toggled(button_pressed):
	GameManger.SetBombMode(button_pressed)
