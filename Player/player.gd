extends CharacterBody2D

var GRID_SIZE=16
@onready var ray= $RayCast2D

@onready var sprite= get_node("Sprite")

var inputs={
	"ui_up":Vector2.UP,
	"ui_down":Vector2.DOWN,
	"ui_left":Vector2.LEFT,
	"ui_right":Vector2.RIGHT,
}

var rotate={
	"ui_up":Vector2.UP,
	"ui_down":Vector2.DOWN,
	"ui_left":Vector2.LEFT,
	"ui_right":Vector2.RIGHT,
}


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
