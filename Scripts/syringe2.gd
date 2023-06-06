extends Node3D

func _on_InteractRay_Syringe2Interact():
	print("syringe pickup")
	self.queue_free()
