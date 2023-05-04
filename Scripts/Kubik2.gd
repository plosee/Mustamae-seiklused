extends KinematicBody

func _on_InteractRay_Kubik2Interact():
	print("kubik kapoof")
	call_deferred("free")
	
