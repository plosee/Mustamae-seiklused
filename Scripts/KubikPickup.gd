extends Node3D

func _on_interact_ray_kubikinteract():
	self.call_deferred("free")

