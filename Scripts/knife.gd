extends Spatial

func _on_InteractRay_KnifeInteract():
	print("Knife Interact")
	call_deferred("free")
	
