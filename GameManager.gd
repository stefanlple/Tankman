extends Node

@onready var endtext = get_node("EndText")
@onready var endtextback =get_node("BackGroundText")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if Input.is_action_pressed("ReloadGame"):
		Reload()
	
func GameEnd(Loser):
	var Winner = "0"
	
	if (Loser == "1"):
		Winner= "2"
	else:
		Winner= "1"
	endtext.visible = true;
	endtextback.visible = true;
	endtext.set_text("Player " + Winner + " wins")

func Reload():
	get_tree().reload_current_scene()

