extends RayCast

var collider = null

func _physics_process(delta):
	collider = get_collider()
	if collider != null:
		print("interacted")
		if collider.is_in_group("Player"):
			print("player dead")
