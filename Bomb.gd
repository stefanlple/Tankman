extends StaticBody2D
class_name Bomb

var BombOwner = ""
var explosion = preload("res://Explosion.tscn")
@export var trigger_OnTime = true;
@export var trigger_PerDamage = false;
@export var trigger_PerRemote = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Timer").start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if(trigger_OnTime):
		Boom();

func Boom():
	#print("fwe")
	var boom_inst = explosion.instantiate()
	boom_inst.ToCenter()
	boom_inst.set_position(get_global_position())
	get_tree().get_root().call_deferred("add_child",boom_inst)
	queue_free();
	


func _on_area_2d_area_exited(area):
	if (area.get_parent() is Player):
		set_collision_layer_value( 1, true )
		#print("Out")
		

func GetHit():
	if(trigger_PerDamage):
		Boom();
	
func SetBombOwner(own):
	BombOwner = own;


func _unhandled_input(event):
	if(trigger_PerRemote):
		if Input.is_action_pressed("Shoot_Player" +BombOwner):
			if Input.is_action_pressed("PlaceBomb_Player" +BombOwner): 
				get_tree().get_root().get_node("Ingame").get_node("Player" + BombOwner).BlockBombplacement()
				Boom()
		if Input.is_action_pressed("RemoteExp" +BombOwner):
			Boom()
	
