extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Timer").start()
	get_node("AnimatedSprite2D").play("Hit")
	print(get_global_position())
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	print("And bye")
	queue_free()
