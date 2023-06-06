extends CharacterBody3D

func _on_InteractRay_Kubik2Interact():
	print("kubik kapoof")
	call_deferred("free")
	
