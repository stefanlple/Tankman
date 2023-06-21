extends StaticBody2D
class_name Wall


@export var indestructible = false;
@export var outside = false;
@export var hp = 1;

@onready var sprite = get_node("WallTexture")

var death = preload("res://death_effekt.tscn")

@export var NewSprite: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if (NewSprite != null):
		sprite.set_texture(NewSprite);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func GetHit():
	if (!indestructible):
		hp = hp -1
		if (hp <= 0):
			DeathE()
			queue_free() 
	

func GetInDestructable():
	return indestructible;

func GetOutside():
	return outside;

func DeathE():
	print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb")
	var death_inst = death.instantiate()
	death_inst.set_position(get_global_position())
	death_inst.set_rotation_degrees(get_global_rotation_degrees())
	get_tree().get_root().call_deferred("add_child", death_inst)


