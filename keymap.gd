extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_mouse_entered():
	self_modulate = Color(1, 0, 0, 1)



func _on_area_2d_mouse_exited():
	self_modulate = Color(1, 1, 1, 0.3)
