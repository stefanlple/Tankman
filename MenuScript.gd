extends Node2D

var roundC = 3

@onready var GameManger = get_node("/root/GameManger");

@onready var Hintpopup = get_node("HinttoShow")
@onready var Hintpopup2 = get_node("HinttoShow2") # Das aus irgenteinen Grund grupping mit den Label nicht klappt ohne das der text Weg ist

func _on_button_pressed():
	get_tree().change_scene_to_file("res://ingame.tscn")


func _on_option_button_item_selected(index):
	GameManger.SetRound(1 + 2*index)



func _on_check_box_toggled(button_pressed):
	GameManger.SetBombMode(button_pressed)




func _on_h_box_container_mouse_entered():
	Hintpopup.visible = true
	Hintpopup2.visible = true


func _on_h_box_container_mouse_exited():
	Hintpopup.visible = false
	Hintpopup2.visible = false
