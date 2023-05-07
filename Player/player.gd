extends CharacterBody2D
class_name Player

@export var playerNumber = "1";
#@export var SpriteColor = Color(255, 0, 0, 1);
@export var HP = 1;
@export var texture:Texture2D;

var GRID_SIZE=16
@onready var ray= $RayCast2D
@onready var sprite = get_node("Sprite")

@onready var ShootingPoint = get_node("Sprite/Node2D")

@onready var timer = get_node("Timer")
var canShoot = true;

var bullet = preload("res://Bullet.tscn")

var bullet_speed = 500;
var inputs;
var rotate;

var lastdir = Vector2.RIGHT;


func _ready():
	inputs={
	"Move_Up_Player" + playerNumber :Vector2.UP,
	"Move_Down_Player" + playerNumber:Vector2.DOWN,
	"Move_Left_Player" + playerNumber:Vector2.LEFT,
	"Move_Right_Player" + playerNumber:Vector2.RIGHT,
	}
	rotate = inputs;
	#sprite.modulate = SpriteColor;
	sprite.set_texture(texture);

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			
			move(dir)
	
	if Input.is_action_pressed("Shoot_Player" +playerNumber):
		if(canShoot):
			fire()


func move(dir):
	var vector_pos=inputs[dir] * GRID_SIZE
	lastdir = inputs[dir]
	ray.target_position = vector_pos
	sprite.look_at(sprite.global_position + vector_pos)
	ray.force_raycast_update()
	if !ray.is_colliding():
		position+= vector_pos

func _fixed_process(delta):
	var collision := move_and_collide((Vector2(0,0) * delta))
	if collision != null:
		var body = collision.collider;
		print("Collided with: ", body.name);


func fire():
	canShoot = false
	timer.start()
	var bullet_inst = bullet.instantiate()
	bullet_inst.SetOwner(playerNumber)
	bullet_inst.set_position(ShootingPoint.get_global_position())
	bullet_inst.set_rotation_degrees(ShootingPoint.get_global_rotation_degrees())
	bullet_inst.apply_central_impulse(lastdir * bullet_speed)
	get_tree().get_root().call_deferred("add_child",bullet_inst)


func MineButtlet(pNumber):
	return (playerNumber == pNumber)

func _on_timer_timeout():
	canShoot = true;

func TakingHit():
	HP = HP-1;
	if(HP <= 0):
		Death()
		
func Death():
	get_tree().get_root().get_node("Ingame").get_node("Manager").GameEnd(playerNumber)
	queue_free() 

