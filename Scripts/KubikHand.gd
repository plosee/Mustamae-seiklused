extends Node3D

func _on_character_kimu():
	Global.KimuPuffDemo += 1
	
func _on_interact_ray_kubikrefill():
	pass
	
func _process(delta):
	if Global.KimuSmoke == true && Global.KimuPuffs > 1:
		Global.KimuPuffDemo -= 1
	if Global.KimuPuffs < 2:
		Global.KimuSmoke = false


