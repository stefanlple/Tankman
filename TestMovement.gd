extends CharacterBody2D


const speed = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


const actor_class = preload("res://Player/player.gd")

func _fixed_process(delta):
	direction = Vector2(1,0)
	var velocity = direction * speed * delta
	move(velocity)

	if is_colliding():
		var collider = get_collider()
		if (collider extends actor_class):
			print("Hello")
			collider.damage()
			explode_actor()
		else:
			explode_wall()

		queue_free()
