extends RigidBody2D
var ownerOfBullet = "0";


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print(body, " entered");

func SetOwner(NewOwner):
	ownerOfBullet = NewOwner;

func _on_area_2d_area_entered(area):
	#print(area.get_parent())
	
	if (area.get_parent() is Player):
		if(!area.get_parent().MineButtlet(ownerOfBullet)):
			area.get_parent().TakingHit()
			queue_free() 
	if (area.get_parent() is Wall):
		area.get_parent().GetHit()
		queue_free();
	if (area.get_parent() is Bomb):
		area.get_parent().GetHit()
		queue_free();
	

