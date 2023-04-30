extends RigidBody2D


# Called when the node enters the scene tree for the first time.
var thrust = Vector2(0, -250)
var torque = 20000

func _integrate_forces(state):
	if Input.is_action_pressed("ui_up"):
		state.apply_force(thrust.rotated(rotation))
	else:
		linear_velocity = Vector2(0,0)
	if Input.is_action_pressed("ui_down"):
		state.apply_force(-thrust.rotated(rotation))
	else:
		linear_velocity = Vector2(0,0)
	var rotation_direction = 0
	if Input.is_action_pressed("ui_right"):
		rotation_direction += 1
	if Input.is_action_pressed("ui_left"):
		rotation_direction -= 1
	state.apply_torque(rotation_direction * torque)
