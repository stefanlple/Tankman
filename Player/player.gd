extends CharacterBody2D

@export var playerNumber = "1";
@export var SpriteColor = Color(255, 0, 0, 1);

var GRID_SIZE=16
@onready var ray= $RayCast2D
@onready var sprite= get_node("Sprite")


var inputs;
var rotate;

func _ready():
	inputs={
	"Move_Up_Player" + playerNumber :Vector2.UP,
	"Move_Down_Player" + playerNumber:Vector2.DOWN,
	"Move_Left_Player" + playerNumber:Vector2.LEFT,
	"Move_Right_Player" + playerNumber:Vector2.RIGHT,
	}
	rotate = inputs;
	sprite.modulate = SpriteColor;

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)


func move(dir):
	var vector_pos=inputs[dir] * GRID_SIZE
	ray.target_position = vector_pos
	sprite.look_at(sprite.global_position + vector_pos)
	ray.force_raycast_update()
	if !ray.is_colliding():
		position+= vector_pos
