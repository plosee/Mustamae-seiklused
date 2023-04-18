extends KinematicBody

func _on_InteractRay_KubikInteract():
	print("kubik kapoof")
	call_deferred("free")
	
