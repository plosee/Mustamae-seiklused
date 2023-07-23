extends Node3D


func _on_interact_ray_knife():
	call_deferred("free")
	
