extends Spatial


func _on_InteractRay_SyringeInteract():
	print("syringe pickup")
	call_deferred("free")
	
