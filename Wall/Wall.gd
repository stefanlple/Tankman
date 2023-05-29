extends StaticBody2D
class_name Wall


@export var indestructible = false;
@export var outside = false;
@export var hp = 1;

@onready var sprite = get_node("WallTexture")

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
			queue_free() 
	

func GetInDestructable():
	return indestructible;

func GetOutside():
	return outside;
