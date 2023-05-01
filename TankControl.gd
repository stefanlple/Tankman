extends RigidBody2D


# Called when the node enters the scene tree for the first time.
var thrust = Vector2(0, -250)
@export var torque = 200
@export var playerOne = true;
var ControlMap = [[],[]]

func _integrate_forces(state):
	if Input.is_action_pressed("move_up_player1"):
		state.apply_central_force(thrust.rotated(rotation))
	else:
		linear_velocity = Vector2(0,0)
	if Input.is_action_pressed("move_down_player1"):
		state.apply_central_force(-thrust.rotated(rotation))
	else:
		linear_velocity = Vector2(0,0)
	var rotation_direction = 0
	if Input.is_action_pressed("roatright_player1"):
		rotation_direction += 1
	if Input.is_action_pressed("roatleft_layer1"):
		rotation_direction -= 1
	state.apply_torque(rotation_direction*torque)
