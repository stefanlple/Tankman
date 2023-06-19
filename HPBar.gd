extends Node2D

@export var playerNumber = 1
@onready var player = get_tree().get_root().get_node("Ingame/Player2");
@onready var children = get_children()


func _ready():
	if(playerNumber == 1):
		player = get_tree().get_root().get_node("Ingame/Player1");
	if(player!=null):
		updateHP()


func _process(_delta):
	if(player!=null):
		updateHP()


func updateHP():
	var hp = player.getHP()
	for child in children:
		child.modulate = Color(1, 1, 1, 0.1)
	for i in range(hp):
		children[i].modulate = Color(1, 1, 1, 1)
	
