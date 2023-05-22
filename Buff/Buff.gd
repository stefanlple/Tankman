extends Node2D
class_name Buff


func getHit(ownerOfBullet):
	if ownerOfBullet == "1":
		get_node("/root/Ingame/Player1").activateBuff()
	else:
		get_node("/root/Ingame/Player2").activateBuff()
	queue_free()
