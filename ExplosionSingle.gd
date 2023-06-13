extends Area2D
class_name Explosion

var nextPath;
var center = false

var over = false
var timeToOver = 0.5;

@onready var timer = get_node("Timer");
@onready var SoundPlayer = get_node("BoomSound")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	if(center):
		SoundPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func SetPath(newPath):
	nextPath = newPath;

func ToCenter():
	center = true

func _on_timer_timeout():
	if (over):
		queue_free();
	else:
		NextExplosion()

func NextExplosion():
	if(!center):
		CauseExplosion(nextPath)
	else:
		ExplodeAround()
	#queue_free();
	
	over = true
	timer.wait_time = 0.3
	timer.start()
	
	

func ExplodeAround():
	var aroundVectors = [Vector2.UP,Vector2.DOWN,Vector2.RIGHT,Vector2.LEFT]
	for path in aroundVectors:
		CauseExplosion(path*12)

func CauseExplosion(Path):
	var newCopy: Node = duplicate()
	newCopy.set_position(get_global_position()+ Path)
	newCopy.SetPath(Path)
	get_tree().get_root().call_deferred("add_child",newCopy)
	


func _on_area_entered(area):
	#print("Hit with Exp" + area.get_parent())
	if (area.get_parent() is Player):
		area.get_parent().TakingHitAmount(10) # -> Intsa Kill
		if(!center):
			queue_free() 
	if (area.get_parent() is Wall):
		area.get_parent().GetHit()
		if(!(center || area.get_parent().GetOutside())):
			queue_free() 
	if (area.get_parent() is Bomb):
		area.get_parent().GetHit()
		if(!center):
			queue_free() 
