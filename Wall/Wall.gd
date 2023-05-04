extends StaticBody2D
class_name Wall


@export var indestructible = true;
var hp = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func GetHit():
	if (!indestructible):
		hp = hp -1
		if (hp <= 0):
			queue_free() 
	
