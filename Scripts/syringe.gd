extends Node3D

func _on_InteractRay_SyringeInteract():
	print("syringe pickup")
	self.queue_free()
