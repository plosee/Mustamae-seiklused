extends Node3D

func _on_interact_ray_viin():
	call_deferred("free")
	print("viin freed")
