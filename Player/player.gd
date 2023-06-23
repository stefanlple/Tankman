extends CharacterBody2D
class_name Player

@export var playerNumber = "1"
#@export var SpriteColor = Color(255, 0, 0, 1);
@export var HP = 1
var invs = false;
@export var texture: Texture2D

# Bomb Variables 
@export var BombCount = 2
@export var BombMAX = 2
var BombregTime = 5;
@export var BombregTimeMax = 5;
var BombModeT = true;

# Bulff Variables
@export var fireRate = 0.5
@export var buffFireRate = 0.1
@export var normalMoveSpeed = 75
@export var buffMoveSpeed = 200


@onready var ray = $RayCast2D
@onready var sprite = get_node("Sprite")
@onready var ShootingPoint = get_node("Sprite/Node2D")
@onready var fireRateTimer = get_node("FireRateTimer")
@onready var invTimer = get_node("InvisableFrames")

@onready var timerBomb = get_node("BombPlacementTimer")
@onready var timerBuff = get_node("BuffTimer")
@onready var MoveSpeed = normalMoveSpeed

@onready var SoundPlayer = get_node("Shoot-Sound")
@onready var PowerUpSound = get_node("PowerUpSound")
# @onready var HitSound = get_node("Hit")

@onready var aniIn = get_node("AnimationPlayer")

@onready var playerString = "UI/Player1UI" if (playerNumber == "1") else "UI2/Player2UI"

@onready var buffBar = get_node("/root/Ingame/" + playerString + "/BuffUI/BuffBar")
@onready var speedBuff = get_node("/root/Ingame/" + playerString + "/BuffUI/SpeedBuff")
@onready var bulletBuff = get_node("/root/Ingame/" + playerString + "/BuffUI/BulletBuff")
@onready var bombBuff = get_node("/root/Ingame/" + playerString + "/BuffUI/BombBuff")

var canShoot = true
var canBomb = true
var bullet = preload("res://Bullet.tscn")
var bomb = preload("res://Bomb.tscn")
var bullet_speed = 640
var inputs
var rotate
var lastdir = Vector2.RIGHT
var GRID_SIZE = 16
var buffActive = false


func _ready():
	inputs = {
		"Move_Up_Player" + playerNumber: Vector2.UP,
		"Move_Down_Player" + playerNumber: Vector2.DOWN,
		"Move_Left_Player" + playerNumber: Vector2.LEFT,
		"Move_Right_Player" + playerNumber: Vector2.RIGHT,
	}
	rotate = inputs
	#sprite.modulate = SpriteColor;
	sprite.set_texture(texture)
	fireRateTimer.set_wait_time( fireRate )
	BombregTime = BombregTimeMax;
	BombModeT = get_node("/root/GameManger").GetBombMode();
	deactivateAllBuffIcons()


func _unhandled_input(event):
	#for dir in inputs.keys():
	#if event.is_action_pressed(dir):
	#move(dir)

	if Input.is_action_pressed("Shoot_Player" + playerNumber):  # PlaceBomb_Player1
		if canShoot:
			fire()

	if Input.is_action_pressed("PlaceBomb_Player" + playerNumber):  # PlaceBomb_Player1
		if !Input.is_action_pressed("Shoot_Player" + playerNumber):
			if BombCount > 0 && canBomb:
				BombCount = BombCount - 1
				BombPlace()


func BombPlace():
	var bomb_inst = bomb.instantiate()
	bomb_inst.set_position(get_global_position())
	bomb_inst.Set_trigger_OnTime(BombModeT)
	bomb_inst.SetBombOwner(playerNumber)
	BlockBombplacement()
	get_tree().get_root().call_deferred("add_child", bomb_inst)


func move(dir):
	var vector_pos = inputs[dir] * GRID_SIZE
	lastdir = inputs[dir]
	ray.target_position = vector_pos
	sprite.look_at(sprite.global_position + vector_pos)
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += vector_pos


func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)

func _process(delta):
	if(buffActive):
		buffBar.set_value(timerBuff.get_time_left())
	if(BombCount < BombMAX):
		BombregTime -= delta;
	if(BombregTime < 0):
		GetBombBack()
	

func GetBombBack():
	if(BombCount != BombMAX):
		BombCount +=1 ;
		BombregTime = BombregTimeMax;

func GetBomRegTime():
	return BombregTime;
	
func GetBombCount():
	return BombCount;
	
func SetBombReg(newTime):
	BombregTimeMax = newTime
	if (BombregTime > BombregTimeMax):
		BombregTime = BombregTimeMax;

func get_input():
	var stop = true
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			lastdir = inputs[dir]
			velocity = lastdir * MoveSpeed
			var vector_pos = inputs[dir] * GRID_SIZE
			sprite.look_at(sprite.global_position + vector_pos)
			stop = false

	if stop:
		velocity = Vector2.ZERO


func fire():
	SoundPlayer.play()
	canShoot = false
	fireRateTimer.start()
	var bullet_inst = bullet.instantiate()
	bullet_inst.SetOwner(playerNumber)
	bullet_inst.set_position(ShootingPoint.get_global_position())
	bullet_inst.set_rotation_degrees(ShootingPoint.get_global_rotation_degrees())
	bullet_inst.apply_central_impulse(lastdir * bullet_speed)
	get_tree().get_root().call_deferred("add_child", bullet_inst)
	

func MineButtlet(pNumber):
	return playerNumber == pNumber


func _on_timer_timeout():
	canShoot = true


func TakingHit():
	TakingHitAmount(1)
		
func TakingHitAmount(Amount): # Es gibt keine Overload in GDScript
	# HitSound.play()
	HP = HP - Amount
	if HP <= 0:
		Death()
	else:
		invs = true
		invTimer.start()
		VisualDamage()

func VisualDamage():
	aniIn.play("TookDamage")
	

func Death():
	get_node("/root/GameManger").RoundEnd(playerNumber)
	queue_free()


func BlockBombplacement():
	canBomb = false
	timerBomb.start()


func _on_bomb_timer_timeout():
	canBomb = true


func activateBuff():
	var randVal = randf();
	print(randVal)
	buffActive = true
	deactivateAllBuffIcons()
	if(randVal < 0.33):
		print("Speed increased")
		MoveSpeed = buffMoveSpeed
		timerBuff.start()
		speedBuff.modulate = Color(1, 1, 1, 1)
	elif(randVal < 0.66):
		if (BombCount < 3):
			BombCount += 1
			print("Bomb increased")
			bombBuff.modulate = Color(1, 1, 1, 1)
	else:
		print("Fire rate increadsed")
		timerBuff.start()
		fireRateTimer.set_wait_time( buffFireRate )
		bulletBuff.modulate = Color(1, 1, 1, 1)


func _on_buff_timer_timeout():
	fireRateTimer.set_wait_time( fireRate )
	MoveSpeed = normalMoveSpeed
	buffActive = false
	deactivateAllBuffIcons()


func deactivateAllBuffIcons():
	speedBuff.modulate = Color(1, 1, 1, 0.5)
	bulletBuff.modulate = Color(1, 1, 1, 0.5)
	bombBuff.modulate = Color(1, 1, 1, 0.5)


func getBuffTimer():
	return timerBuff.time_left;	


func _on_hit_check_area_entered(area: Area2D):
	var parent = area.get_parent()
	if parent is Buff:
		parent.queue_free()
		activateBuff()


func _on_invisable_frames_timeout():
	invs = false;


func getHP():
	return HP;


