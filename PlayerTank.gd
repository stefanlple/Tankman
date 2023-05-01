extends CharacterBody2D


const SPEED = 444
var bullet = preload("res://BulletTank.tscn")
var bullet_speed = 200;

var rotspeed = 5;
@export var torque = 200
@export var playerOne = true
var ControlMap = [[],[]]
@onready var timer = get_node("Timer")
@onready var Shootingpoint = get_node("Turret/ShootingPoint")
var canShoot = true;


func _physics_process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("move_up_player1"):
		velocity = Vector2(SPEED,0).rotated(rotation)
	if Input.is_action_pressed("move_down_player1"): 
		velocity = Vector2(-SPEED/2,0).rotated(rotation)
	var rotation_direction = 0
	if Input.is_action_pressed("roatright_player1"):
		rotation_direction += 1
	if Input.is_action_pressed("roatleft_layer1"):
		rotation_direction -= 1
	rotation += rotspeed*rotation_direction * delta
	if Input.is_action_pressed("Shooting_player1"):
		if(canShoot):
			fire()
	move_and_slide()


func fire():
	canShoot = false
	timer.start()
	var bullet_inst = bullet.instantiate()
	bullet_inst.set_position(Shootingpoint.get_position())
	bullet_inst.set_rotation_degrees(get_rotation_degrees())
	bullet_inst.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_inst)


func _on_timer_timeout():
	canShoot = true;
