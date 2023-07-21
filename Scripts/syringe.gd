extends Node3D

func _on_interact_ray_syringe():
	call_deferred("free")
