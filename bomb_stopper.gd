extends Area2D # Das ist hier um den Bug zu fixen wenn eine Bombe zu nah einer ausßenwasdn plaziert wird und istamnt verschluckt werden

func _on_area_entered(area):
	if (area is Explosion):
		print("Hit Extra Wall")
		area.queue_free()
