extends CharacterBody2D

const CELL_SIZE = 64
const MAP_SIZE = Vector2(1600, 1600)

var player_velocity = Vector2.ZERO

func _physics_process(delta):
	# Move the player based on user input
	player_velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		player_velocity.x += 1
		print("string here")
	if Input.is_action_pressed("ui_left"):
		player_velocity.x -= 1
		print("string here")
	if Input.is_action_pressed("ui_down"):
		player_velocity.y += 1
		print("string here")
	if Input.is_action_pressed("ui_up"):
		player_velocity.y -= 1
		print("string here")
	player_velocity = player_velocity.normalized() * CELL_SIZE * delta
	var collision = move_and_collide(player_velocity)

	# Prevent the player from moving outside the map
	if collision:
		var pos = position
		var norm = collision.normal
		if norm.x != 0:
			pos.x = round(pos.x / CELL_SIZE) * CELL_SIZE
		if norm.y != 0:
			pos.y = round(pos.y / CELL_SIZE) * CELL_SIZE
		position = pos.clamped(Vector2.ZERO, (MAP_SIZE - Vector2(1, 1)) * CELL_SIZE)
