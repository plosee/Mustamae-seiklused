extends Node3D

func _on_character_kimu():
	Global.KimuPuffs -= 1

func _on_interact_ray_kubikrefill():
	Global.KimuPuffs = 100
	
