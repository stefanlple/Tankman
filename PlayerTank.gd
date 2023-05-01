extends CharacterBody2D


const SPEED = 444
var bullet = preload("res://BulletTank.tscn")
var bullet_speed = 4500;

var rotspeed = 5;
@export var torque = 200
@export var playerNumber = "1"
var ControlMap = [[],[]]
@onready var timer = get_node("Timer")
@onready var Shootingpoint = get_node("Turret/ShootingPoint")
var canShoot = true;


func _physics_process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("move_up_player" +playerNumber):
		velocity = Vector2(SPEED,0).rotated(rotation)
	if Input.is_action_pressed("move_down_player" +playerNumber): 
		velocity = Vector2(-SPEED/2,0).rotated(rotation)
	var rotation_direction = 0
	if Input.is_action_pressed("roatright_player" +playerNumber):
		rotation_direction += 1
	if Input.is_action_pressed("roatleft_player" +playerNumber):
		rotation_direction -= 1
	rotation += rotspeed*rotation_direction * delta
	if Input.is_action_pressed("Shooting_player" +playerNumber):
		if(canShoot):
			fire()
	move_and_slide()


func fire():
	canShoot = false
	timer.start()
	var bullet_inst = bullet.instantiate()
	bullet_inst.set_position(get_position())
	bullet_inst.set_rotation_degrees(get_rotation_degrees())
	bullet_inst.apply_central_impulse(Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_inst)


func _on_timer_timeout():
	canShoot = true;


func _on_ready():
	pass # Replace with function body.
