extends ProgressBar


@export var playerNumber = 1
@onready var player = get_tree().get_root().get_node("Ingame/Player1");


func _ready():	
	print(player)	
	if(playerNumber == 1):
		player = get_tree().get_root().get_node("Ingame/Player2");
	if(player!=null):
		set_max(player.getBuffTimer())


func _process(_delta):
	if(player!=null && player.buffActive):
		print(player.getBuffTimer())
		set_value(player.getBuffTimer())
